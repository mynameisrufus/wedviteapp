# RailsAdmin config file. Generated on June 04, 2012 14:41
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  # If your default_local is different from :en, uncomment the following 2 lines and set your default locale here:
  # require 'i18n'
  # I18n.default_locale = :de

  config.current_user_method { current_admin } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, Admin

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, Admin

  # Set the admin name here (optional second array element will appear in a beautiful RailsAdmin red ©)
  config.main_app_name = ['Wedding Invitor', 'Admin']
  # or for a dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }


  #  ==> Global show view settings
  # Display empty fields in show views
  # config.compact_show_view = false

  #  ==> Global list view settings
  # Number of default rows per-page:
  # config.default_items_per_page = 20

  #  ==> Included models
  # Add all excluded models here:
  # config.excluded_models = [Admin, Agency, AgencyDesigner, AgencyDesignerToken, CollaborationToken, Collaborator, Comment, Designer, Event, Guest, GuestStrict, Location, Message, Payment, Stationary, StationaryAsset, StationaryImage, User, Wedding]

  # Add models here if you want to go 'whitelist mode':
  config.included_models = [Admin, Agency, AgencyDesigner, AgencyDesignerToken, CollaborationToken, Collaborator, Comment, Designer, Event, Guest, GuestStrict, Location, Message, Payment, Stationary, StationaryAsset, StationaryImage, User, Wedding]

  # Application wide tried label methods for models' instances
  # config.label_methods << :description # Default is [:name, :title]

  #  ==> Global models configuration
  # config.models do
  #   # Configuration here will affect all included models in all scopes, handle with care!
  #
  #   list do
  #     # Configuration here will affect all included models in list sections (same for show, export, edit, update, create)
  #
  #     fields_of_type :date do
  #       # Configuration here will affect all date fields, in the list section, for all included models. See README for a comprehensive type list.
  #     end
  #   end
  # end
  #
  #  ==> Model specific configuration
  # Keep in mind that *all* configuration blocks are optional.
  # RailsAdmin will try his best to provide the best defaults for each section, for each field.
  # Try to override as few things as possible, in the most generic way. Try to avoid setting labels for models and attributes, use ActiveRecord I18n API instead.
  # Less code is better code!
  # config.model MyModel do
  #   # Cross-section field configuration
  #   object_label_method :name     # Name of the method called for pretty printing an *instance* of ModelName
  #   label 'My model'              # Name of ModelName (smartly defaults to ActiveRecord's I18n API)
  #   label_plural 'My models'      # Same, plural
  #   weight -1                     # Navigation priority. Bigger is higher.
  #   parent OtherModel             # Set parent model for navigation. MyModel will be nested below. OtherModel will be on first position of the dropdown
  #   navigation_label              # Sets dropdown entry's name in navigation. Only for parents!
  #   # Section specific configuration:
  #   list do
  #     filters [:id, :name]  # Array of field names which filters should be shown by default in the table header
  #     items_per_page 100    # Override default_items_per_page
  #     sort_by :id           # Sort column (default is primary key)
  #     sort_reverse true     # Sort direction (default is true for primary key, last created first)
  #     # Here goes the fields configuration for the list view
  #   end
  # end

  # Your model's configuration, to help you get started:

  # All fields marked as 'hidden' won't be shown anywhere in the rails_admin unless you mark them as visible. (visible(true))

  # config.model Admin do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :failed_attempts, :integer 
  #     configure :unlock_token, :string 
  #     configure :locked_at, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Agency do
  #   # Found associations:
  #     configure :principal_contact, :belongs_to_association 
  #     configure :agency_designers, :has_many_association 
  #     configure :designers, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :taxation_reference, :string 
  #     configure :account_number, :string 
  #     configure :designer_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model AgencyDesigner do
  #   # Found associations:
  #     configure :agency, :belongs_to_association 
  #     configure :designer, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :agency_id, :integer         # Hidden 
  #     configure :designer_id, :integer         # Hidden 
  #     configure :role, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model AgencyDesignerToken do
  #   # Found associations:
  #     configure :agency, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :role, :string 
  #     configure :email, :string 
  #     configure :agency_id, :integer         # Hidden 
  #     configure :token, :string 
  #     configure :claimed_on, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model CollaborationToken do
  #   # Found associations:
  #     configure :wedding, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :role, :string 
  #     configure :email, :string 
  #     configure :wedding_id, :integer         # Hidden 
  #     configure :token, :string 
  #     configure :claimed_on, :datetime 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Collaborator do
  #   # Found associations:
  #     configure :user, :belongs_to_association 
  #     configure :wedding, :belongs_to_association 
  #     configure :evt, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :role, :string 
  #     configure :user_id, :integer         # Hidden 
  #     configure :wedding_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Comment do
  #   # Found associations:
  #     configure :guest, :belongs_to_association 
  #     configure :user, :belongs_to_association 
  #     configure :evt, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :text, :text 
  #     configure :guest_id, :integer         # Hidden 
  #     configure :user_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Designer do
  #   # Found associations:
  #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :biography, :text 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Event do
  #   # Found associations:
  #     configure :eventfull, :polymorphic_association 
  #     configure :wedding, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :headline, :string 
  #     configure :quotation, :text 
  #     configure :state, :string 
  #     configure :eventfull_id, :integer         # Hidden 
  #     configure :eventfull_type, :string         # Hidden 
  #     configure :wedding_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Guest do
  #   # Found associations:
  #     configure :wedding, :belongs_to_association 
  #     configure :evt, :has_many_association 
  #     configure :comments, :has_many_association 
  #     configure :messages, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :state, :string 
  #     configure :name, :string 
  #     configure :email, :string 
  #     configure :address, :string 
  #     configure :phone, :string 
  #     configure :adults, :integer 
  #     configure :children, :integer 
  #     configure :attending_reception, :boolean 
  #     configure :invited_on, :datetime 
  #     configure :replyed_on, :datetime 
  #     configure :partner_number, :integer 
  #     configure :comments_count, :integer 
  #     configure :wedding_id, :integer         # Hidden 
  #     configure :position, :integer 
  #     configure :token, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :messages_count, :integer 
  #     configure :invited_to_reception, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model GuestStrict do
  #   # Found associations:
  #     configure :wedding, :belongs_to_association 
  #     configure :evt, :has_many_association 
  #     configure :comments, :has_many_association 
  #     configure :messages, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :state, :string 
  #     configure :name, :string 
  #     configure :email, :string 
  #     configure :address, :string 
  #     configure :phone, :string 
  #     configure :adults, :integer 
  #     configure :children, :integer 
  #     configure :attending_reception, :boolean 
  #     configure :invited_on, :datetime 
  #     configure :replyed_on, :datetime 
  #     configure :partner_number, :integer 
  #     configure :comments_count, :integer 
  #     configure :wedding_id, :integer         # Hidden 
  #     configure :position, :integer 
  #     configure :token, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :messages_count, :integer 
  #     configure :invited_to_reception, :boolean   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Location do
  #   # Found associations:
  #     configure :evt, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :address_components, :serialized 
  #     configure :types, :serialized 
  #     configure :formatted_address, :string 
  #     configure :formatted_phone_number, :string 
  #     configure :international_phone_number, :string 
  #     configure :name, :string 
  #     configure :vicinity, :string 
  #     configure :website, :string 
  #     configure :google_url, :string 
  #     configure :google_id, :string 
  #     configure :lat, :decimal 
  #     configure :lng, :decimal 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Message do
  #   # Found associations:
  #     configure :guest, :belongs_to_association 
  #     configure :evt, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :text, :text 
  #     configure :guest_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Payment do
  #   # Found associations:
  #     configure :purchasable, :polymorphic_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :gross, :float 
  #     configure :transaction_fee, :float 
  #     configure :currency, :string 
  #     configure :purchasable_id, :integer         # Hidden 
  #     configure :purchasable_type, :string         # Hidden 
  #     configure :user_id, :integer 
  #     configure :transaction_id, :string 
  #     configure :gateway, :string 
  #     configure :gateway_response, :serialized 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Stationary do
  #   # Found associations:
  #     configure :agency, :belongs_to_association 
  #     configure :weddings, :has_many_association 
  #     configure :stationary_images, :has_many_association 
  #     configure :stationary_assets, :has_many_association 
  #     configure :payments, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :style, :string 
  #     configure :description, :text 
  #     configure :html, :text 
  #     configure :desktop, :boolean 
  #     configure :mobile, :boolean 
  #     configure :print, :boolean 
  #     configure :published, :boolean 
  #     configure :popularity, :integer 
  #     configure :price, :float 
  #     configure :commision, :float 
  #     configure :agency_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :preview_file_name, :string         # Hidden 
  #     configure :preview_content_type, :string         # Hidden 
  #     configure :preview_file_size, :integer         # Hidden 
  #     configure :preview_updated_at, :datetime         # Hidden 
  #     configure :preview, :paperclip   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model StationaryAsset do
  #   # Found associations:
  #     configure :stationary, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :stationary_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model StationaryImage do
  #   # Found associations:
  #     configure :stationary, :belongs_to_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :stationary_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model User do
  #   # Found associations:
  #     configure :collaborations, :has_many_association 
  #     configure :weddings, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :email, :string 
  #     configure :password, :password         # Hidden 
  #     configure :password_confirmation, :password         # Hidden 
  #     configure :reset_password_token, :string         # Hidden 
  #     configure :reset_password_sent_at, :datetime 
  #     configure :remember_created_at, :datetime 
  #     configure :sign_in_count, :integer 
  #     configure :current_sign_in_at, :datetime 
  #     configure :last_sign_in_at, :datetime 
  #     configure :current_sign_in_ip, :string 
  #     configure :last_sign_in_ip, :string 
  #     configure :first_name, :string 
  #     configure :last_name, :string 
  #     configure :billing_name, :string 
  #     configure :billing_address, :string 
  #     configure :billing_state, :string 
  #     configure :billing_country, :string 
  #     configure :billing_zip, :string 
  #     configure :billing_city, :string 
  #     configure :chargify_subscription_id, :integer 
  #     configure :masked_card_number, :string 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
  # config.model Wedding do
  #   # Found associations:
  #     configure :stationary, :belongs_to_association 
  #     configure :ceremony_where, :belongs_to_association 
  #     configure :reception_where, :belongs_to_association 
  #     configure :evt, :has_many_association 
  #     configure :events, :has_many_association 
  #     configure :guests, :has_many_association 
  #     configure :collaborators, :has_many_association 
  #     configure :collaboration_tokens, :has_many_association 
  #     configure :users, :has_many_association 
  #     configure :payments, :has_many_association   #   # Found columns:
  #     configure :id, :integer 
  #     configure :name, :string 
  #     configure :wording, :text 
  #     configure :save_the_date_wording, :text 
  #     configure :ceremony_only_wording, :text 
  #     configure :respond_deadline, :datetime 
  #     configure :ceremony_when, :datetime 
  #     configure :ceremony_how, :text 
  #     configure :ceremony_what, :text 
  #     configure :has_reception, :boolean 
  #     configure :reception_when, :datetime 
  #     configure :reception_how, :text 
  #     configure :reception_what, :text 
  #     configure :partner_one_name, :string 
  #     configure :partner_two_name, :string 
  #     configure :payment_made, :boolean 
  #     configure :payment_date, :datetime 
  #     configure :stationary_id, :integer         # Hidden 
  #     configure :ceremony_location_id, :integer         # Hidden 
  #     configure :reception_location_id, :integer         # Hidden 
  #     configure :created_at, :datetime 
  #     configure :updated_at, :datetime 
  #     configure :ceremony_when_end, :datetime 
  #     configure :reception_when_end, :datetime 
  #     configure :invite_process_started_at, :datetime 
  #     configure :invite_process_started, :boolean 
  #     configure :thank_you_wording, :text   #   # Sections:
  #   list do; end
  #   export do; end
  #   show do; end
  #   edit do; end
  #   create do; end
  #   update do; end
  # end
end
