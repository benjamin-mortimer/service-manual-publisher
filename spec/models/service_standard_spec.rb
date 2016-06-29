require 'rails_helper'

RSpec.describe ServiceStandard, "#content_id" do
  it "returns a preassigned UUID" do
    expect(
      described_class.new().content_id
    ).to eq("00f693d4-866a-4fe6-a8d6-09cd7db8980b")
  end
end

RSpec.describe ServiceStandard, "#points" do
  it "returns a list of all points" do
    point = create(:point)

    expect(
      described_class.new.points
    ).to eq([point])
  end
end
