class AgencyDesigner < ActiveRecord::Base
  belongs_to :agency
  belongs_to :designer

  validates_presence_of :designer_id, :agency_id, :role

  def self.add_or_invite_designer_to_agency(options)
    email    = options.delete :email
    agency   = options.delete :agency
    admin    = options.delete :admin
    designer = Designer.where(email: email).first || Designer.invite!(email: email)
    agency_designer = self.class.create! admin: (admin || false), designer: designer, agency: agency
    if agency_designer
      AgencyDesignerMailer.added_to_account_email(agency_designer).deliver
      agency_designer
    else

    end
  end
end
