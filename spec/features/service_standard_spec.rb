require 'rails_helper'

RSpec.describe 'Update the service standard', type: :feature do
  it 'displays a blank form' do
    visit edit_service_standard_path

    # :with doesn't work with empty strings, work around by using be_blank
    expect(find_field("Title").text).to be_blank
    expect(find_field("Introduction").text).to be_blank
    expect(find_field("Body").text).to be_blank
  end
end
