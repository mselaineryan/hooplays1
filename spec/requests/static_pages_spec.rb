require 'spec_helper'

describe "StaticPages" do
  
  describe "Home Page" do

    it "should have the content 'Hooplays'" do
      visit '/static_pages/home'
      expect(page).to have_content('Hooplays')
    end

    it "should have the title 'Home'" do 
    	visit '/static_pages/home'
    	expect(page).to have_title("Hooplays | Home")
    end
  end

  describe "About Page" do 
  	it "should have the content 'About'" do 
  		visit '/static_pages/about'
  		expect(page).to have_content('About')
  	end

  	it "should have the title 'About'" do 
  		visit '/static_pages/about'
  		expect(page).to have_title("Hooplays | About")
  	end
  end

  describe "FAQ Page" do 
  	it "should have the content 'FAQ'" do 
  		visit '/static_pages/faq'
  		expect(page).to have_content('FAQ')
  	end

  	it "should have the title 'FAQ'" do 
  		visit '/static_pages/faq'
  		expect(page).to have_title("Hooplays | FAQ")
  	end
  end

end
