require 'rails_helper'

RSpec.describe GitService do
  describe '.find_info' do
    context 'When Rails Rails Project' do
      let(:project) { create(:project,
                             path_with_namespace: 'test/rails-sample',
                             web_url: 'https://example.com/root/rails-sample',
                             ssh_url_to_repo: 'git@example.com:root/rails-sample.git',
                             http_url_to_repo: 'http://example.com/root/rails-sample.git',
                             last_activity_at: 10.days.ago) }

      it 'get ruby/rails version and brakeman result' do
        allow(described_class).to receive(:_clone_repository).and_return('tmp')
        allow(described_class).to receive(:_check_by_brakeman).and_return({ ruby_version: '2.3.0',
                                                                            rails_version: '5.0.0.beta3',
                                                                            check: { key: 'value' } })
        info = described_class.find_info(project)

        expect(info[:ruby_version]).to eq '2.3.0'
        expect(info[:rails_version]).to eq '5.0.0.beta3'
        expect(info[:brakeman_json]).to eq({ ruby_version: '2.3.0',
                                             rails_version: '5.0.0.beta3',
                                             check: { key: 'value' } })
      end
    end

    context 'When not Rails project' do
      let(:project) { create(:project,
                             path_with_namespace: 'test/non-rails-sample',
                             web_url: 'https://example.com/root/non-rails-sample',
                             ssh_url_to_repo: 'git@example.com:root/non-rails-sample.git',
                             http_url_to_repo: 'http://example.com/root/non-rails-sample.git',
                             last_activity_at: 10.days.ago) }

      it 'return error_message' do
        allow(described_class).to receive(:_clone_repository).and_return('tmp')
        allow(described_class).to receive(:_check_by_brakeman).and_raise('not rails')
        info = described_class.find_info(project)

        expect(info[:error_message]).to eq 'not rails'
      end
    end
  end
end