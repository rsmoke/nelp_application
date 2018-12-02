require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email_address => "MyString",
      :avatar_url => "MyString",
      :locale => "MyString",
      :hosted_domain => "MyString"
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input[name=?]", "user[name]"

      assert_select "input[name=?]", "user[email_address]"

      assert_select "input[name=?]", "user[avatar_url]"

      assert_select "input[name=?]", "user[locale]"

      assert_select "input[name=?]", "user[hosted_domain]"
    end
  end
end
