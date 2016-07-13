require 'rails_helper'

RSpec.describe "booths/new", type: :view do
  before(:each) do
    assign(:booth, Booth.new(
      :state => 1
    ))
  end

  it "renders new booth form" do
    render

    assert_select "form[action=?][method=?]", booths_path, "post" do

      assert_select "input#booth_state[name=?]", "booth[state]"
    end
  end
end
