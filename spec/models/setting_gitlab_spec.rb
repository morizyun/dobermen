require 'rails_helper'

RSpec.describe SettingGitlab, type: :model do
  # ------------------------------------------------------------------
  # Attributes
  # ------------------------------------------------------------------
  describe '.attributes' do
    it 'has encrypted ssh_key' do
      setting = create(:setting_gitlab, ssh_key: 'sample')
      ssh_key = ActiveRecord::Base.connection.execute("SELECT ssh_key from setting_gitlabs where id = #{setting.id} limit 1;").values[0][0]
      decrypted_ssh_key = Encryption::Type.new.cast(ssh_key)
      expect(decrypted_ssh_key).to eq 'sample'
    end

    it 'has encrypted private_token' do
      setting = create(:setting_gitlab, private_token: 'sample_token')
      private_token = ActiveRecord::Base.connection.execute("SELECT private_token from setting_gitlabs where id = #{setting.id} limit 1;").values[0][0]
      decrypted_private_token = Encryption::Type.new.cast(private_token)
      expect(decrypted_private_token).to eq 'sample_token'
    end
  end

  # ------------------------------------------------------------------
  # Callbacks
  # ------------------------------------------------------------------
  describe '#add_last_slash' do
    subject { create(:setting_gitlab, base_url: url).base_url }
    context 'has last slash' do
      let(:url) { 'http://example.com/' }
      it { is_expected.to eq 'http://example.com/' }
    end
    context 'has not last slash' do
      let(:url) { 'http://example.com' }
      it { is_expected.to eq 'http://example.com/' }
    end
  end

  # ------------------------------------------------------------------
  # Public Instance Methods
  # ------------------------------------------------------------------
  describe '#all_projects' do
    context 'When user is admin' do
      let(:expect_array) { [
          Gitlab::ObjectifiedHash.new(
              path_with_namespace: 'test/rails-sample',
              web_url: 'https://example.com/root/rails-sample',
              ssh_url_to_repo: 'git@example.com:test_user/rails-sample.git',
              http_url_to_repo: 'https://example.com/test_user/rails-sample.git',
              last_activity_at: 10.days.ago
          ),
          Gitlab::ObjectifiedHash.new(
              path_with_namespace: 'test/rails-sample2',
              web_url: 'https://example.com/root/rails-sample2',
              ssh_url_to_repo: 'git@example.com:test_user/rails-sample2.git',
              http_url_to_repo: 'https://example.com/test_user/rails-sample2.git',
              last_activity_at: 12.days.ago
          )
      ] }

      it 'get all projects' do
        allow(GitlabService).to receive(:get_all_projects).and_return(expect_array)
        projects = described_class.new.all_projects(type: :admin)
        expect(projects).to eq expect_array
      end
    end

    context 'When user is not admin' do
      let(:expect_array) { [
          Gitlab::ObjectifiedHash.new(
              path_with_namespace: 'test/rails-sample',
              web_url: 'https://example.com/root/rails-sample',
              ssh_url_to_repo: 'git@example.com:test_user/rails-sample.git',
              http_url_to_repo: 'https://example.com/test_user/rails-sample.git',
              last_activity_at: 10.days.ago
          )
      ] }

      it 'get visible projects' do
        allow(GitlabService).to receive(:get_visible_projects).and_return(expect_array)
        projects = described_class.new.all_projects(type: :user)
        expect(projects).to eq expect_array
      end
    end
  end # all_project

  describe '#domain' do
    subject { build(:setting_gitlab, base_url: 'http://server_domain.sample:119229/').domain }
    it 'return domain' do
      is_expected.to eq 'server_domain.sample'
    end
  end
end
