require 'rails_helper'

RSpec.describe "booths/show", type: :view do
  before(:each) do
    @booth = assign(:booth, Booth.create!(
      :state => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
  end
end
