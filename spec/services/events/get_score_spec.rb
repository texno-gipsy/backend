require 'rails_helper'

describe Events::GetScore do
  let(:user) { create(:user, tags: %w[a b q]) }
  let(:event1) { create(:event, tags: []) }
  let(:event2) { create(:event, tags: []) }
  let(:event3) { create(:event, tags: []) }

  before do
    create(:participation, event: event1, user: create(:user, tags: %w[a b c]))
    create(:participation, event: event1, user: create(:user, tags: %w[a]))
    create(:participation, event: event1, user: create(:user, tags: %w[b d]))

    create(:participation, event: event2, user: create(:user, tags: %w[a]))
    create(:participation, event: event2, user: create(:user, tags: %w[a]))
    create(:participation, event: event2, user: create(:user, tags: %w[a]))

    create(:participation, event: event3, user: create(:user, tags: %w[a c d]))
  end

  it 'returns score for event1' do
    expect(described_class.call(event1, user)).to eq(0.15904041823988746)
  end
  it 'returns score for event2' do
    expect(described_class.call(event2, user)).to eq(0)
  end
  it 'returns score for event3' do
    expect(described_class.call(event3, user)).to eq(0)
  end
end
