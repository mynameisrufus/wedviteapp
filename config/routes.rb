WeddingInvitor::Application.routes.draw do

  constraints subdomain: 'admin' do
    devise_for :admins

    root to: 'rails_admin/main#dashboard'
    mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
  end

  constraints subdomain: 'plan' do
    devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

    root to: 'users/dashboard#home'
    scope module: 'users' do
      resources :weddings do
        get 'collaborators/collaborate/:token', action: :collaborate, controller: :collaborators, as: :collaborate
        %w(wording ceremony_only_wording save_the_date_wording ceremony_what ceremony_how reception_what reception_how).each do |markup_action|
          get markup_action
        end
        resources :stationary, only: %w(index) do
          get 'purchase'
          get 'choose'
        end
        resource :locations, only: [] do
          get 'ceremony'
          get 'reception'
          post 'ceremony',   action: :create_ceremony
          post 'reception', action: :create_reception
          put 'ceremony',    action: :update_ceremony
          put 'reception',  action: :update_reception
        end
        resources :collaborators, except: %w(show)
        resources :guests do
          post 'approve'
          post 'reject'
          post 'tentative'
          post 'accept'
          post 'decline'
          post 'move'
          resources :comments
        end
      end
      match 'help/:page' => 'help#page', as: :help_page
    end
  end

  constraints subdomain: 'design' do
    devise_for :designers

    root to: 'designers/dashboard#home'
    scope module: 'designers' do
      resources :stationary do
        resources :weddings
      end
    end
  end

  constraints subdomain: 'invitations' do
    scope module: 'invitations' do
      match ':token' => 'stationary#show', as: :invitation
      match ':token/message' => 'weddings#message', as: :message, method: :post
      match ':token/accept'  => 'weddings#accept', as: :accept
      match ':token/decline' => 'weddings#decline', as: :decline
      match ':token/details' => 'weddings#details', as: :details
    end
  end

  # http://wedding-invite.com/i/AD8L91/george-and-mildred
  scope module: 'site' do
    root to: 'pages#home'
  end
end
