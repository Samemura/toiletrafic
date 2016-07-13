require 'rails_helper'

RSpec.describe "booths/index", type: :view do
  before(:each) do
    assign(:booths, [
      Booth.create!(
        :state => 2
      ),
      Booth.create!(
        :state => 2
      )
    ])
  end

  it "renders a list of booths" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
