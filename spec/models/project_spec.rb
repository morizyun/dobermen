require 'rails_helper'

RSpec.describe Project, type: :model do
  describe '.upsert_by_gitlab!' do
    let(:key_web_url) { 'https://example.com/root/rails-sample' }
    let(:setting) { create(:setting_gitlab) }
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
        described_class.upsert_by_gitlab!(in_hash, setting)

        record = described_class.where(web_url: key_web_url).first
        expect(record.path_with_namespace).to eq 'test/rails-sample'
        expect(record.web_url).to eq key_web_url
        expect(record.ssh_url_to_repo).to eq 'git@example.com:test_user/rails-sample.git'
        expect(record.http_url_to_repo).to eq 'https://example.com/test_user/rails-sample.git'
        expect(record.last_activity_at.to_i).to eq 10.days.ago.to_i
      end
    end

    context 'when not existing record' do
      it 'inserting record are successful' do
        described_class.upsert_by_gitlab!(in_hash, setting)

        record = described_class.where(web_url: key_web_url).first
        expect(record.path_with_namespace).to eq 'test/rails-sample'
        expect(record.web_url).to eq key_web_url
        expect(record.ssh_url_to_repo).to eq 'git@example.com:test_user/rails-sample.git'
        expect(record.http_url_to_repo).to eq 'https://example.com/test_user/rails-sample.git'
        expect(record.last_activity_at.to_i).to eq 10.days.ago.to_i
      end
    end
  end

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  describe '#ssh_url_with_domain' do
    let(:project) { build(:project, ssh_url_to_repo: 'ssh://git@localhost:10022/test/project.git', setting_gitlab: setting_gitlab) }
    subject { project.ssh_url_with_domain }

    context 'have setting_gitlab with domain setting' do
      let(:setting_gitlab) { create(:setting_gitlab, base_url: 'http://server_domain.sample:119229/') }
      it 'return a url which replaced of domain' do
        expect(subject).to eq 'ssh://git@server_domain.sample:10022/test/project.git'
      end
    end

    context 'do not have setting_gitlab' do
      let(:setting_gitlab) { nil }
      it { expect(subject).to eq 'ssh://git@localhost:10022/test/project.git' }
    end
  end

  describe '#web_url_with_domain' do
    let(:project) { build(:project, web_url: 'https://localhost:119229/test/project', setting_gitlab: setting_gitlab) }
    subject { project.web_url_with_domain }

    context 'have setting_gitlab with domain setting' do
      let(:setting_gitlab) { create(:setting_gitlab, base_url: 'http://server_domain.sample:119229/') }
      it 'return a url which replaced of domain' do
        expect(subject).to eq 'https://server_domain.sample:119229/test/project'
      end
    end

    context 'do not have setting_gitlab' do
      let(:setting_gitlab) { nil }
      it { expect(subject).to eq 'https://localhost:119229/test/project' }
    end
  end

end
