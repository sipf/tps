require 'spec_helper'

describe Helpscout::API, lib: true do
  describe '.conversations_reports', vcr: { cassette_name: 'helpscout_conversations_reports' } do
    let(:from) { Date.new(2017, 11) }
    let(:to)   { Date.new(2017, 12) }

    before { Rails.cache.clear }

    subject { described_class.new.conversations_reports(from, to) }

    it 'returns one conversation_reports object per month' do
      expect(subject.size).to eq 2
    end

    it 'populates reports with replies count and tags' do
      report = subject.first
      expect(report.dig('replies', 'count')).to be > 0
      expect(report.dig('tags', 'top').count).to be > 0
    end
  end
end
