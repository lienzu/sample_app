require 'spec_helper'
  describe "Static pages" do
  subject { page }
  shared_examples_for "all static pages" do
      it { should have_selector('h1',text:heading) }
      it { should have_title(full_title(page_title)) }
    end
  describe "Home page" do
    before { visit root_path }
        let(:heading)    { 'Sample App' }
        let(:page_title) { '' }
        
        it_should_behave_like "all static pages"
        it { should_not have_title('| Home') }
    #it { should have_content('Sample App') }
    #it { should have_title(full_title('')) }
    #it { should_not have_title('| Home') }
    
    describe "for signed-in users" do
          let(:user) { FactoryGirl.create(:user) }
          before do
            FactoryGirl.create(:micropost, user: user, content: "Lorem")
            FactoryGirl.create(:micropost, user: user, content: "Ipsum")
            sign_in user
            visit root_path
          end
          it "should render the user's feed" do
              user.feed.each do |item|
                  expect(page).to have_selector("li##{item.id}", text: item.content)
              end
          end
          
          describe "follower/following counts" do
                 let(:other_user) { FactoryGirl.create(:user) }
                 before do
                   other_user.follow!(user)
                   visit root_path
                 end
                 it { should have_link("0 following", href: following_user_path(user)) }
                 it { should have_link("1 followers", href: followers_user_path(user)) }
          end
    end
end
  describe "Help page" do
    before { visit help_path }
    let(:heading)    { 'Help' }
    let(:page_title) { 'Help' }
    
    it_should_behave_like "all static pages"
    
   # it { should have_content('Help') }
   # it { should have_title(full_title('Help')) }
  end
  describe "About page" do
    before { visit about_path }
    let(:heading)    { 'About Us' }
    let(:page_title) { 'About Us' }
    
    it_should_behave_like "all static pages"
    #it { should have_content('About') }
    #it { should have_title(full_title('About Us')) }
  end
  describe "Contact page" do
      before { visit contact_path }
      let(:heading)    { 'Contact' }
      let(:page_title) { 'Contact' }
      
      it_should_behave_like "all static pages"
      #it { should have_selector('h1',text:  'Contact') }
      #it { should have_title(full_title('Contact')) }
    end
    
    it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us')) 
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home" 
    expect(page).to have_title(full_title('Sample App'))
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app" 
    expect(page).to have_title(full_title('Sample App'))
    end
  end


=begin
require 'spec_helper'
describe "Static pages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit root_path
      expect(page).to have_content('Sample App')
    end
    it "should have the base title" do
          visit root_path
          expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end 
    it "should not have a custom page title" do
          visit root_path
          expect(page).not_to have_title('| Home')
    end
end
  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
end
    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end 
end
  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end
    it "should have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")

    end 
  end
  describe "Contact page" do
    it "should have the content 'Contact Us'" do
      visit contact_path
      expect(page).to have_content('Contact Us')
    end
    it "should have the title 'Contact Us'" do
      visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact Us")

    end 
  end
end
=end