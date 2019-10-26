require 'rails_helper'

describe Participations::ZTestTags::Events do
  subject { described_class.call(event, tag) }

  let(:event) { create(:event, tags: %w[sport football]) }
  let(:tag) { 'music' }
  let(:users_without_tag) { create_list(:user, 70, tags: %w[]) }
  let(:users_with_tag) { create_list(:user, 30, tags: %w[music]) }

  context 'success' do
    before do
      users_without_tag.first(10).each { |user| create(:participation, event: event, user: user) }
      users_with_tag.first(30).each { |user| create(:participation, event: event, user: user) }
    end

    it 'adds tag to event' do
      expect { subject }.to change { event.reload.tags }.to(%w[sport football music])
    end
  end

  context 'fail' do
    before do
      users_without_tag.first(40).each { |user| create(:participation, event: event, user: user) }
      users_with_tag.first(1).each { |user| create(:participation, event: event, user: user) }
    end

    it 'does not add tag to event' do
      expect { subject }.not_to change { event.reload.tags }
    end
  end
end
