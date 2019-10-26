require 'rails_helper'

describe Participations::ZTestTags::Process do
  subject { described_class.call(participation) }

  let(:user) { create(:user, tags: %w[music movie]) }
  let(:event) { create(:event, tags: %w[sport football]) }
  let(:participation) { create(:participation, event: event, user: user) }

  it 'calls Participations::ZTestTags::Users' do
    expect(Participations::ZTestTags::Users).to receive(:call).twice.and_call_original
    subject
  end
  it 'calls Participations::ZTestTags::Events' do
    expect(Participations::ZTestTags::Events).to receive(:call).twice.and_call_original
    subject
  end
end
