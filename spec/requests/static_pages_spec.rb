require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do

    it "should have the content 'Hooplays'" do
      visit '/static_pages/home'
      expect(page).to have_content('Hooplays')
    end

    it "should have the title 'Home'" do 
    	visit '/static_pages/home'
    	expect(page).to have_title("Hooplays")
    end

    it "should not have a custom page title" do 
    	visit '/static_pages/home'
    	expect(page).not_to have_title('| Home')
    end
  end

  describe "About Page" do 
  	it "should have the content 'About Us'" do 
  		visit '/static_pages/about_us'
  		expect(page).to have_content('About Us')
  	end

  	it "should have the title 'About Us'" do 
  		visit '/static_pages/about_us'
  		expect(page).to have_title("Hooplays | About Us")
  	end
  end

  

end
