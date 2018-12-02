require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :google_id => "Google",
        :name => "Name",
        :email_address => "Email Address",
        :avatar_url => "Avatar Url",
        :locale => "Locale",
        :hosted_domain => "Hosted Domain"
      ),
      User.create!(
        :google_id => "Google",
        :name => "Name",
        :email_address => "Email Address",
        :avatar_url => "Avatar Url",
        :locale => "Locale",
        :hosted_domain => "Hosted Domain"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Google".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email Address".to_s, :count => 2
    assert_select "tr>td", :text => "Avatar Url".to_s, :count => 2
    assert_select "tr>td", :text => "Locale".to_s, :count => 2
    assert_select "tr>td", :text => "Hosted Domain".to_s, :count => 2
  end
end
