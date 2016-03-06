require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe '.upsert!' do
    let(:key_web_url) { 'https://example.com/root/rails-sample' }
    let(:in_hash) {
      {
          path_with_namespace: 'test/rails-sample',
          web_url: key_web_url,
          ssh_url_to_repo: 'git@example.com:test_user/rails-sample.git',
          http_url_to_repo: 'https://example.com/test_user/rails-sample.git',
          last_activity_at: 10.days.ago
      }
    }

    context 'when existing record' do
      before { create(:project, web_url: key_web_url) }

      it 'updating record are successful' do
        Timecop.freeze(Time.zone.now)
        described_class.upsert!(in_hash)

        record = described_class.where(web_url: key_web_url).first
        expect(record.path_with_namespace).to eq 'test/rails-sample'
        expect(record.web_url).to eq key_web_url
        expect(record.ssh_url_to_repo).to eq 'git@example.com:test_user/rails-sample.git'
        expect(record.http_url_to_repo).to eq 'https://example.com/test_user/rails-sample.git'
        expect(record.last_activity_at).to eq 10.days.ago
      end
    end

    context 'when not existing record' do
      it 'inserting record are successful' do
        Timecop.freeze(Time.zone.now)
        described_class.upsert!(in_hash)

        record = described_class.where(web_url: key_web_url).first
        expect(record.path_with_namespace).to eq 'test/rails-sample'
        expect(record.web_url).to eq key_web_url
        expect(record.ssh_url_to_repo).to eq 'git@example.com:test_user/rails-sample.git'
        expect(record.http_url_to_repo).to eq 'https://example.com/test_user/rails-sample.git'
        expect(record.last_activity_at).to eq 10.days.ago
      end
    end
  end
end
