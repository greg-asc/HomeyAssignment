require "rails_helper"

RSpec.describe StatusChange, type: :model do
  it { is_expected.to validate_presence_of(:prev_status) }
  it { is_expected.to validate_presence_of(:new_status) }
  it { is_expected.to belong_to(:project) }
  it { is_expected.to belong_to(:user) }

  describe "after create callback" do
    let(:user)    { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, status: "starting", user: user) }

    it "updates the project's status to to_status" do
      event = StatusChange.create!(
        project:     project,
        user:        user,
        prev_status: "starting",
        new_status:  "under_review"
      )
      expect(project.reload.status).to eq("under_review")
    end
  end
end

