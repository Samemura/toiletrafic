require 'rails_helper'

RSpec.describe "booths/edit", type: :view do
  before(:each) do
    @booth = assign(:booth, Booth.create!(
      :state => 1
    ))
  end

  it "renders the edit booth form" do
    render

    assert_select "form[action=?][method=?]", booth_path(@booth), "post" do

      assert_select "input#booth_state[name=?]", "booth[state]"
    end
  end
end
