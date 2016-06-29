require 'rails_helper'

RSpec.describe 'Update the service standard', type: :feature do
  context 'when the service standard does not exist' do
    before do
      stub_any_publishing_api_put_content
      stub_any_publishing_api_publish
      publishing_api_does_not_have_item ServiceStandard.content_id
    end

    it 'displays a blank form' do
      visit edit_service_standard_path

      # :with doesn't work with empty strings, work around by using be_blank
      expect(find_field("Title").text).to be_blank
      expect(find_field("Introduction").text).to be_blank
      expect(find_field("Body").text).to be_blank
    end

    it 'creates and publishes the service standard' do
      visit edit_service_standard_path

      fill_in 'Title', with: 'Digital Service Standard'
      fill_in 'Introduction', with: 'The Service Standard is a set of 18 criteria'
      fill_in 'Body', with: 'All public facing services must meet the standard.'

      click_first_button 'Save and publish'

      assert_publishing_api_put_content(
        ServiceStandard.content_id,
        request_json_includes(
          title: 'Digital Service Standard',
          details: {
            introduction: 'The Service Standard is a set of 18 criteria',
            body: 'All public facing services must meet the standard.',
            points: []
          }
        )
      )

      assert_publishing_api_publish ServiceStandard.content_id

      within '.alert' do
        expect(page).to have_content('Service standard has been published')
      end
    end
  end

  context 'when the service standard already exists' do
    before do
      publishing_api_has_item({
        content_id: ServiceStandard.content_id,
        base_path: '/service-manual/service-standard',
        document_type: 'service_manual_service_standard',
        phase: 'beta',
        publishing_app: 'service-manual-publisher',
        rendering_app: 'service-manual-frontend',
        routes: [
          { type: 'exact', path: '/service-manual/service-standard' }
        ],
        schema_name: 'service_manual_service_standard',
        title: 'Analogue Service Standard',
        details: {
          introduction: 'The Analogue Service Standard is a set of 18 criteria',
          body: 'All analogue services must meet the standard.',
          points: []
        }
      })
    end

    it 'displays a form showing the existing standard' do
      visit edit_service_standard_path

      expect(page).to have_field 'Title', with: 'Analogue Service Standard'
      expect(page).to have_field 'Introduction', with: 'The Analogue Service Standard is a set of 18 criteria'
      expect(page).to have_field 'Body', with: 'All analogue services must meet the standard.'
    end
  end
end
