require 'rails_helper'

RSpec.describe BrakemanJson do
  let(:json_path) { Rails.root.join('spec/test_files/brakeman_result.json').to_s }
  let(:json) { JSON.parse(File.read(json_path)) }

  describe '#summary' do
    it { expect(described_class.new(json).summary).to eq 'security_warnings => 7' }
    it { expect(described_class.new({}).summary).to eq 'No security issue!' }
  end

  describe '#has_warning?' do
    it { expect(described_class.new(json).has_warning?).to be_truthy }
    it { expect(described_class.new({}).has_warning?).to be_falsey }
  end

  describe '#warnings' do
    it 'return 7 warns' do
      warnings = described_class.new(json).warnings
      expect(warnings.count).to eq 7
      warnings.each { |w| expect(w.class).to eq BrakemanJson::Warn }
    end

    it 'return 0 warns' do
      warnings = described_class.new({}).warnings
      expect(warnings.count).to eq 0
    end
  end

  describe '#ruby_version' do
    it { expect(described_class.new(json).ruby_version).to eq '2.3.0' }
  end

  describe '#rails_version' do
    it { expect(described_class.new(json).rails_version).to eq '5.0.0.beta1' }
  end

  describe '#to_h' do
    it 'return hash' do
      result = described_class.new(json).to_h
      expect(result).to eq json.try(:deep_symbolize_keys)
    end
  end
end

RSpec.describe BrakemanJson::Warn do
  let(:json_path) { Rails.root.join('spec/test_files/brakeman_result.json').to_s }
  let(:json) { JSON.parse(File.read(json_path)).try(:deep_symbolize_keys) }
  subject { described_class.new(json[:warnings].first) }

  describe '#type' do
    it { expect(subject.type).to eq 'Mass Assignment' }
  end

  describe '#message' do
    it { expect(subject.message).to eq 'Parameters should be whitelisted for mass assignment' }
  end

  describe '#path' do
    it { expect(subject.path).to eq 'app/controllers/users_controller.rb#L78' }
  end

  describe '#reference_url' do
    it { expect(subject.reference_url).to eq 'http://brakemanscanner.org/docs/warning_types/mass_assignment/' }
  end

  describe '#confidence' do
    it { expect(subject.confidence).to eq 'High' }
  end

  describe '#danger?' do
    it { expect(subject.danger?).to be_truthy }
  end
end
