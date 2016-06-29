class ServiceStandardPresenter

  def initialize(service_standard)
    @service_standard = service_standard
  end

  def content_id
    service_standard.content_id
  end

  def content_payload
    {
      base_path: '/service-manual/service-standard',
      document_type: 'service_manual_service_standard',
      phase: 'beta',
      publishing_app: 'service-manual-publisher',
      rendering_app: 'service-manual-frontend',
      routes: [
        { type: 'exact', path: '/service-manual/service-standard' }
      ],
      schema_name: 'service_manual_service_standard',
      title: service_standard.title,
      details: {
        introduction: service_standard.introduction,
        body: service_standard.body,
        points: points_payload,
      }
    }
  end

private

  attr_reader :service_standard

  def points_payload
    point_payloads = service_standard.points.map do |point|
      edition = point.live_edition

      if edition
        {
          base_path: point.slug,
          summary: edition.summary,
          title: edition.title,
        }
      end
    end

    point_payloads.compact
  end
end
