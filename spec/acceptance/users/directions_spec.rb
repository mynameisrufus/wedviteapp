require 'acceptance/acceptance_helper'

feature 'Directions feature', %q{
  In order to inform my guests of where my wedding is
  As a wedding collaborator
  I want manage directions
} do

  background do
    change_subdomain :plan
  end

  context "ceremony" do
    scenario 'create ceremony directions' do
      wedding, user, collaborator = wedup!
      navigate_to_wedding wedding, user

      click_link 'Wedding Details'

      within '#new_ceremony_location' do
        fill_in 'ceremony_location[name]', with: "Bombay"
        fill_in 'ceremony_how',            with: "Lorem foo"
        click_button "Save directions"
      end

      page.should have_content("Ceremony directions have been added.")
      wedding.reload
      wedding.ceremony_how.should eq "Lorem foo"
      wedding.ceremony_where.name.should eq "Bombay"
    end

    scenario 'update ceremony directions' do
      wedding, user, collaborator = wedup!

      location = wedding.ceremony_where = Location.create name: "Bombay"

      wedding.ceremony_how = "Lorem bar"
      wedding.save

      navigate_to_wedding wedding, user

      click_link 'Wedding Details'

      within '#edit_ceremony_location' do
        fill_in 'ceremony_location[name]', with: "Jakarta"
        fill_in 'ceremony_how',            with: "Lorem foo"
        click_button "Save directions"
      end

      page.should have_content("The ceremony directions have been updated.")

      wedding.reload
      wedding.ceremony_how.should eq "Lorem foo"
      wedding.ceremony_where.name.should eq "Jakarta"
    end
  end

  context "reception" do
    scenario 'create reception directions' do
      wedding, user, collaborator = wedup!
      navigate_to_wedding wedding, user

      click_link 'Wedding Details'

      within '#new_reception_location' do
        fill_in 'reception_location[name]', with: "Bombay"
        fill_in 'reception_how',            with: "Lorem foo"
        click_button "Save directions"
      end

      page.should have_content("Reception directions have been added.")
      wedding.reload
      wedding.reception_how.should eq "Lorem foo"
      wedding.reception_where.name.should eq "Bombay"
    end

    scenario 'update reception directions' do
      wedding, user, collaborator = wedup!

      location = wedding.reception_where = Location.create name: "Bombay"

      wedding.reception_how = "Lorem bar"
      wedding.save

      navigate_to_wedding wedding, user

      click_link 'Wedding Details'

      within '#edit_reception_location' do
        fill_in 'reception_location[name]', with: "Jakarta"
        fill_in 'reception_how',            with: "Lorem foo"
        click_button "Save directions"
      end

      page.should have_content("The reception directions have been updated.")

      wedding.reload
      wedding.reception_how.should eq "Lorem foo"
      wedding.reception_where.name.should eq "Jakarta"
    end
  end
end
