class ServiceStandardController < ApplicationController

  def edit
    @service_standard = get_service_standard_from_publishing_api
  end

  def update
    save_and_publish_service_standard(create_service_standard_from_form_data)
    redirect_to edit_service_standard_path, notice: "Service standard has been published"
  end

private

  def get_service_standard_from_publishing_api
    service_standard = ServiceStandard.new

    payload = PUBLISHING_API.get_content(ServiceStandard.content_id)

    if payload then
      payload = payload.to_hash

      service_standard.title = payload['title']
      service_standard.introduction = payload['details']['introduction']
      service_standard.body = payload['details']['body']
    end

    service_standard
  end

  def create_service_standard_from_form_data
    service_standard = ServiceStandard.new

    service_standard.title = form_parameter(:title)
    service_standard.introduction = form_parameter(:introduction)
    service_standard.body = form_parameter(:body)

    service_standard
  end

  def save_and_publish_service_standard(service_standard)
    service_standard_for_publication =
      ServiceStandardPresenter.new(service_standard)

    PUBLISHING_API.put_content(
      service_standard_for_publication.content_id,
      service_standard_for_publication.content_payload
    )
    PUBLISHING_API.publish(
      service_standard_for_publication.content_id,
      "major"
    )
  end

  def form_parameter(param)
    params.fetch(:service_standard, {}).fetch(param)
  end
end
