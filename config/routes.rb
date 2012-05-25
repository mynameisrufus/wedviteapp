WeddingInvitor::Application.routes.draw do

  constraints subdomain: 'admin' do
    devise_for :admins

    match 'robots.txt' => 'application#robots'

    root to: 'rails_admin/main#dashboard'
    mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
  end

  constraints subdomain: 'plan' do
    devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

    root to: 'users/dashboard#home'
    scope module: 'users' do
      match 'robots.txt' => 'base#robots'

      resources :weddings do

        get 'collaborators/collaborate/:token', action: :collaborate, controller: :collaborators, as: :collaborate

        get :details
        put :update_details

        get :guestlist
        get 'invitation-and-stationery', action: :invitations, as: :invitations
        get :timeline
        get 'invite-guests', action: :confirm, controller: :invitations, as: :confirm
        get :deliver, controller: :invitations

        get :payment
        post 'payment-success', action: :payment_success, as: :payment_success
        get 'payment-failure', action: :payment_failure, as: :payment_failure

        %w(wording ceremony_only_wording save_the_date_wording thank_you_wording ceremony_what ceremony_how reception_what reception_how).each do |markup_action|
          get markup_action
        end
        resources :stationary, only: %w(index) do
          get 'payment'
          get 'payment-success', action: :payment_success, as: :payment_success
          get 'payment-failure', action: :payment_failure, as: :payment_failure
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
      match 'feedback/new' => 'feedback#new', method: :get
      match 'feedback' => 'feedback#create', method: :post

      match 'help/:page' => 'help#page', as: :help_page
    end
  end

  constraints subdomain: 'design' do
    devise_for :designers

    match 'robots.txt' => 'base#robots'

    root to: 'designers/dashboard#home'
    scope module: 'designers' do
      resources :stationary do
        resources :weddings
      end
    end
  end

  constraints subdomain: 'invitations' do
    scope module: 'invitations' do
      match 'robots.txt' => 'base#robots'

      match ':token'         => 'stationary#show', as: :invitation

      match ':token/message' => 'guests#message', as: :guest_message, method: :post
      match ':token/update'  => 'guests#update', as: :guest, method: :post
      match ':token/accept'  => 'guests#accept', as: :accept_invitation
      match ':token/decline' => 'guests#decline', as: :decline_invitation

      match ':token/details' => 'weddings#details', as: :details
      match ':token/ical'    => 'weddings#ical', as: :ical
    end
  end

  scope module: 'site' do
    match 'robots.txt' => 'base#robots'
    root to: 'pages#home'
  end
end
