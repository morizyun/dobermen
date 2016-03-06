require 'rails_helper'

RSpec.describe GitlabService do
  describe '.all_projects' do
    let(:expect_array) {
      [
          {
              path_with_namespace: 'test/rails-sample',
              web_url: 'https://example.com/root/rails-sample',
              ssh_url_to_repo: 'git@example.com:test_user/rails-sample.git',
              http_url_to_repo: 'https://example.com/test_user/rails-sample.git',
              last_activity_at: 10.days.ago
          },
          {
              path_with_namespace: 'test/rails-sample2',
              web_url: 'https://example.com/root/rails-sample2',
              ssh_url_to_repo: 'git@example.com:test_user/rails-sample2.git',
              http_url_to_repo: 'https://example.com/test_user/rails-sample2.git',
              last_activity_at: 12.days.ago
          },
      ]
    }

    it 'get all projects' do
      allow(described_class).to receive(:_get_all_projects).and_return(expect_array)
      projects = described_class.all_projects

      expect(projects).to eq expect_array
    end
  end
end