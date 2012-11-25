require 'spec_helper'

describe Invitations::InviteMailer do

  let(:mail) {
    guests = [Guest.make, Guest.make]
    Invitations::InviteMailer.prepare sender: User.make,
                                      wedding: Wedding.make,
                                      guests: guests
  }

  it 'should deliver the email' do
    mail.deliver
    ActionMailer::Base.deliveries.should_not be_empty
  end

  describe "SendGrid API" do

    it 'should have correct category' do
      sendgrid_header = ActiveSupport::JSON.decode(mail.deliver.header['X-SMTPAPI'].value)
      sendgrid_header["category"].should eq "Invitations"
    end

    it 'should have correct email addresses' do
      sendgrid_header = ActiveSupport::JSON.decode(mail.deliver.header['X-SMTPAPI'].value)
      sendgrid_header["to"].size.should eq 2
    end

    it 'should have correct invitation urls' do
      sendgrid_header = ActiveSupport::JSON.decode(mail.deliver.header['X-SMTPAPI'].value)
      sendgrid_header["sub"]["-invitation_url-"].size.should eq 2
    end

    it 'should have correct invitation urls' do
      sendgrid_header = ActiveSupport::JSON.decode(mail.deliver.header['X-SMTPAPI'].value)
      sendgrid_header["sub"]["-guest_name-"].size.should eq 2
      sendgrid_header["sub"]["-invitation_url-"].size.should eq 2
    end

    it 'should have substitute values in body' do
      mail.encoded.should have_selector 'span', text: 'Dear -guest_name-,'
      mail.encoded.should have_xpath "//a[contains(@href,'-invitation_url-')]"
    end

  end
end
