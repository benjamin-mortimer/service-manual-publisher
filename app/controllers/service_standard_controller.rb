class ServiceStandardController < ApplicationController

  def edit
    @service_standard = get_service_standard_from_publishing_api
  end

  def update
    # nothing to do, yet
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
end
