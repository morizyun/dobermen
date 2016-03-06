require 'rails_helper'

RSpec.describe GitService do
  describe '.find_info' do
    let(:project) { create(:project,
                           path_with_namespace: 'test/rails-sample',
                           web_url: 'https://example.com/root/rails-sample',
                           # ssh_url_to_repo: 'git@gitlab.morizyun.com:root/rails-sample.git',
                           # http_url_to_repo: 'http://gitlab.morizyun.com/root/rails-sample.git',
                           ssh_url_to_repo: 'git@example.com:root/rails-sample.git',
                           http_url_to_repo: 'http://example.com/root/rails-sample.git',
                           last_activity_at: 10.days.ago) }

    it 'get ruby/rails version' do
      allow(described_class).to receive(:_clone_repository).and_return('tmp')
      allow(described_class).to receive(:_get_ruby_version).and_return('2.3.0')
      allow(described_class).to receive(:_get_rails_version).and_return('5.0.0.beta3')
      info = described_class.find_info(project)

      expect(info[:ruby_version]).to eq '2.3.0'
      expect(info[:rails_version]).to eq '5.0.0.beta3'
    end
  end
end