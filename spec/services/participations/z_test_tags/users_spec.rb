require 'rails_helper'

describe Participations::ZTestTags::Users do
  subject { described_class.call(user, tag) }

  let(:user) { create(:user, tags: %w[sport football]) }
  let(:tag) { 'music' }
  let(:events_without_tag) { create_list(:event, 70, tags: %w[]) }
  let(:events_with_tag) { create_list(:event, 30, tags: %w[music]) }

  context 'success' do
    before do
      events_without_tag.first(10).each { |event| create(:participation, event: event, user: user) }
      events_with_tag.first(30).each { |event| create(:participation, event: event, user: user) }
    end

    it 'adds tag to user' do
      expect { subject }.to change { user.reload.tags }.to(%w[sport football music])
    end
  end

  context 'fail' do
    before do
      events_without_tag.first(40).each { |event| create(:participation, event: event, user: user) }
      events_with_tag.first(1).each { |event| create(:participation, event: event, user: user) }
    end

    it 'does not add tag to user' do
      expect { subject }.not_to change { user.reload.tags }
    end
  end
end
