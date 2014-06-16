require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do

    before { visit root_path }

    it "should have the content 'Hooplays'" do
      expect(page).to have_content('Hooplays')
    end

    it "should have the title 'Hooplays'" do 
    	expect(page).to have_title("Hooplays")
    end

    it "should not have a custom page title" do 
    	expect(page).not_to have_title('| Home')
    end
  end


  describe "About Page" do 
    before { visit about_us_path }
  	it "should have the content 'About Us'" do 
  		expect(page).to have_content('About Us')
  	end

  	it "should have the title 'About Us'" do 
  		expect(page).to have_title("Hooplays | About Us")
  	end
  end

  

end
