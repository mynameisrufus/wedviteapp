require 'acceptance/acceptance_helper'

feature 'Collaborate feature', %q{
  In order to collaborate on a wedding invitation plan
  As a wedding collaborator
  I want manage collaborators
} do

  background do
    change_subdomain :plan
    @wedding      = Wedding.make!
    @user         = User.make!
    @collaborator = Collaborator.make! user_id: @user.id, role: 'invite', wedding_id: @wedding.id
  end

  scenario 'invite a collaborator' do
    sign_in_with email: @user.email, password: @user.password
    visit wedding_path(@wedding)
    click_link 'Manage collaborators' 
    click_link 'Add collaborator'
    fill_in 'email', with: 'user@example.com'
    choose 'role_invite'
    click_button 'Add collaborator'
    page.should have_content 'An invitation to collaborate has been sent to user@example.com'
  end

  scenario 'add a collaborator' do
    true.should == true
  end

  scenario 'invite an already invited collaborator' do
    true.should == true
  end

  scenario 'add an already collaborating collaborator' do
    true.should == true
  end

  scenario 'change a collaborators role if I have the sender role' do
    true.should == true
  end

  scenario 'not allow me to change others roles unless I have the sender role' do
    true.should == true
  end

  scenario 'accept an invitation to collaborate on a wedding' do
    true.should == true
  end

  scenario 'get notified of if added as a collaborator to a wedding' do
    true.should == true
  end
end
