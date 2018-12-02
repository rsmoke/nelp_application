require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :name => "Name",
      :email_address => "Email Address",
      :avatar_url => "Avatar Url",
      :locale => "Locale",
      :hosted_domain => "Hosted Domain"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email Address/)
    expect(rendered).to match(/Avatar Url/)
    expect(rendered).to match(/Locale/)
    expect(rendered).to match(/Hosted Domain/)
  end
end
