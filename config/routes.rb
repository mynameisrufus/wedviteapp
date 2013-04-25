WeddingInvitor::Application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mail-preview'
  end

  constraints subdomain: 'admin' do
    devise_for :admins

    match 'robots.txt' => 'application#robots'

    root to: 'rails_admin/main#dashboard'
    mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
  end

  constraints subdomain: 'plan' do
    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
      passwords: "users/passwords",
      omniauth_callbacks: "users/omniauth_callbacks"
    }

    root to: 'users/dashboard#home'
    scope module: 'users' do
      match 'robots.txt' => 'base#robots'

      get 'collaborate/:token', action: :collaborate, controller: :collaborators, as: :collaborate

      post 'payment-notify',  controller: :payments, action: :failure, as: :payment_notify

      resources :weddings do

        get :details
        put :update_details

        get :invitations
        put :update_invitations

        get :guestlist
        get 'invitation-and-stationery', action: :invitations, as: :invitations
        get :timeline
        get 'invite-guests', action: :confirm, controller: :invitations, as: :confirm
        get 'thank-guests', action: :confirm, controller: :thanks, as: :thank
        get 'deliver-invitations', action: :deliver, controller: :invitations, as: :deliver_invitations
        get 'deliver-thanks', action: :deliver, controller: :thanks, as: :deliver_thanks

        get :payment, controller: :payments
        get 'payment-success', controller: :payments, action: :success, as: :payment_success
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
          get 'remind'
          get 'thank'
          get 'link'
          post 'approve'
          post 'reject'
          post 'tentative'
          post 'accept'
          post 'decline'
          post 'move'
          resources :comments
        end
        resources :messages, except: %w(show) do
          resources :replies, except: %w(show)
        end
        resource :gift_registry, path: 'gift-registry', only: %w(show create update) do
          resources :gifts, only: %w(create update destroy)
        end
      end
      match 'feedback/new' => 'feedback#new', method: :get
      match 'feedback' => 'feedback#create', method: :post

      match 'help/:page' => 'help#page', as: :help_page
    end
  end

  constraints subdomain: 'design' do
    devise_for :designers, controllers: { sessions: "designers/sessions" }

    match 'robots.txt' => 'base#robots'

    root to: 'designers/dashboard#home'
    scope module: 'designers' do
      resources :stationery do
        get :build, on: :member
        get :preview, on: :member
        post :deploy, on: :member
        resources :images, controller: :stationery_images
        resources :assets, controller: :stationery_assets
      end
    end
  end

  constraints subdomain: 'invitations' do
    scope module: 'invitations' do
      match 'robots.txt' => 'base#robots'

      scope ":token" do
        root to: 'stationery#show', as: :invitation
        match 'print'     => 'stationery#print', as: :print_invitation

        get 'guestlist'   => 'weddings#guestlist', as: :guestlist
        get 'directions'  => 'weddings#directions', as: :directions
        get 'ourday'      => 'weddings#our_day', as: :our_day
        get 'thankyou'    => 'weddings#thank', as: :thank
        match 'ical'      => 'weddings#ical', as: :ical


        # TODO remove this
        match 'message'   => 'guests#message', as: :guest_message, method: :post

        get 'you'         => 'guests#show', as: :guest
        put 'update'     => 'guests#update', as: :update_guest
        match 'accept'    => 'guests#accept', as: :accept_invitation
        match 'decline'   => 'guests#decline', as: :decline_invitation

        resources :messages, only: %w(index create update destroy) do
          resources :replies, only: %w(create update destroy)
        end

        resources :gifts, only: :index do
          get :claim, on: :member
          get :unclaim, on: :member
        end
      end
    end
  end

  constraints subdomain: 'blog' do
    scope module: 'blog' do
      match 'robots.txt' => 'posts#robots'
      root to: 'posts#index'
      resources :posts, only: %w(index edit update show) do
        get 'page/:page', action: :index, on: :collection, as: :page
      end
    end
  end

  scope module: 'site' do
    match 'robots.txt' => 'base#robots'
    root to: 'pages#home'
  end
end
