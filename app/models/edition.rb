class Edition < ActiveRecord::Base
  PUBLISHERS = {
    "Design Community" => "http://sm-11.herokuapp.com/designing-services/design-community/",
    "Agile Community" => "http://sm-11.herokuapp.com/agile-delivery/agile-community"
  }.freeze

  belongs_to :guide
  scope :draft, -> { where(state: 'draft') }
  scope :published, -> { where(state: 'published') }

  validates_presence_of [:state, :phase, :description, :title, :update_type, :body, :publisher_title, :publisher_href]

  before_validation :assign_publisher_href

  def draft?
    state == 'draft'
  end

  def published?
    state == 'published'
  end

private

  def assign_publisher_href
    self.publisher_href = PUBLISHERS[publisher_title] if publisher_title.present?
  end
end