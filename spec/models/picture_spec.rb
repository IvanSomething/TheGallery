# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Picture, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe '#approved?' do
    subject { picture.approved? }

    let(:picture) { create :picture, status: status }

    context 'when status is approved' do
      let(:status) { 'approved' }

      it { is_expected.to be true }
    end

    context 'when status is not approved' do
      let(:status) { 'rejected' }

      it { is_expected.to be false }
    end
  end

  describe '.approved' do
    subject { described_class.approved }

    let!(:picture) { create :picture, status: 'approved' }
    let!(:rejected_picture) { create :picture, status: 'rejected' }
    let!(:pending) { create :picture, status: 'pending' }

    it { is_expected.to eq [picture] }
  end

  describe '.rejected' do
    subject { described_class.rejected }

    let!(:picture) { create :picture, status: 'approved' }
    let!(:rejected_picture) { create :picture, status: 'rejected' }
    let!(:pending) { create :picture, status: 'pending' }

    it { is_expected.to eq [rejected_picture] }
  end

  describe '.pending' do
    subject { described_class.pending_approval }

    let!(:picture) { create :picture, status: 'rejected' }
    let!(:rejected_picture) { create :picture, status: 'approved' }
    let!(:pending) { create :picture, status: 'pending' }

    it { is_expected.to eq [pending] }
  end

  describe '.without_rejected' do
    subject { described_class.without_rejected }

    let!(:picture) { create :picture, status: 'rejected' }
    let!(:rejected_picture) { create :picture, status: 'approved' }
    let!(:pending) { create :picture, status: 'pending' }

    it { is_expected.not_to eq [rejected_picture] }
  end
end
