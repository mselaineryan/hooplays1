require 'spec_helper'

describe "AuthenticationPages" do
  
  subject { page }

  describe "login page" do 
  	before { visit login_path }

  	it { should have_content('Musician Log in') }
  	it { should have_title('Log in') }
  end

  describe "login" do 
  	before { visit login_path }

  	describe "with invalid information" do 
  		before { click_button "Log in" }

  		it { should have_title('Log in') }
  		it { should have_selector('div.alert.alert-error') }

  		describe "after visiting another page" do
        before { click_link "About Us" }
        it { should_not have_selector('div.alert.alert-error') }
      end
  	end

  	describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { log_in user }

      it { should have_title(user.name) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings', href: edit_user_path(user)) } 
      it { should have_link('Log out',    href: logout_path) }
      it { should_not have_link('Log in', href: login_path) }

      describe "followed by logout" do 
        before { click_link("Log out") }
        it { should have_link("log in to update shows") }
      end
    end
  end

  describe "authorization" do 

    describe "for non-signed-in users" do 
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Users controller" do 

        describe "visiting the edit page" do 
          before { visit edit_user_path(user) }
          it { should have_title('Log in') }
        end

        describe "submitting to the update aciton" do 
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(login_path) }
        end
      end
    end

    describe "as wrong user" do 
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { log_in user, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_url) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do 
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { log_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do 
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
