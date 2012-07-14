WeddingInvitor::Application.routes.draw do

  constraints subdomain: 'admin' do
    devise_for :admins

    match 'robots.txt' => 'application#robots'

    root to: 'rails_admin/main#dashboard'
    mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
  end

  constraints subdomain: 'plan' do
    devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", passwords: "users/passwords" }


    root to: 'users/dashboard#home'
    scope module: 'users' do
      match 'robots.txt' => 'base#robots'

      get 'collaborate/:token', action: :collaborate, controller: :collaborators, as: :collaborate

      resources :weddings do

        get :details
        put :update_details

        get :invitations
        put :update_invitations

        get :guestlist
        get 'invitation-and-stationery', action: :invitations, as: :invitations
        get :timeline
        get 'invite-guests', action: :confirm, controller: :invitations, as: :confirm
        get :deliver, controller: :invitations

        get :payment, controller: :payments
        post 'payment-success', controller: :payments, action: :success, as: :payment_success
        get 'payment-failure',  controller: :payments, action: :failure, as: :payment_failure


        get 'preview/ourday'         => 'preview#ourday', as: :ourday_preview
        get 'preview/thank'          => 'preview#thank', as: :thank_preview
        get 'preview/directions'     => 'preview#directions', as: :directions_preview
        get 'preview/invitation'     => 'preview#invitation', as: :invitation_preview
        get 'preview/stationery/:id' => 'preview#stationery', as: :stationery_preview
        get 'preview/guest/:id'      => 'preview#guest', as: :guest_preview

        resources :stationery, only: %w(index) do
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
      resources :stationery do
        get :build, on: :member
        get :preview, on: :member
        resources :images, controller: :stationery_images
        resources :assets, controller: :stationery_assets
      end
    end
  end

  constraints subdomain: 'invitations' do
    scope module: 'invitations' do
      match 'robots.txt' => 'base#robots'

      match ':token'           => 'stationery#show', as: :invitation

      match ':token/message'   => 'guests#message', as: :guest_message, method: :post
      match ':token/update'    => 'guests#update', as: :guest, method: :post
      match ':token/accept'    => 'guests#accept', as: :accept_invitation
      match ':token/decline'   => 'guests#decline', as: :decline_invitation
      match ':token/thankyou'  => 'guests#after_decline', as: :after_decline

      match ':token/details'   => 'weddings#details', as: :guesthome
      match ':token/ical'      => 'weddings#ical', as: :ical
    end
  end

  constraints subdomain: 'blog' do
    scope module: 'blog' do
      match 'robots.txt' => 'posts#robots'
      root to: 'posts#index'
      resources :posts, only: %w(index show) do
        get 'page/:page', action: :index, on: :collection, as: :page
      end
    end
  end

  scope module: 'site' do
    match 'robots.txt' => 'base#robots'
    root to: 'pages#home'
  end
end
