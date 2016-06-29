class ServiceStandard
  attr_accessor :title, :introduction, :body

  def self.content_id
    "00f693d4-866a-4fe6-a8d6-09cd7db8980b".freeze
  end

  def content_id
    ServiceStandard.content_id
  end

  def points
    Point.all
  end
end
