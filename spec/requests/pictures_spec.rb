# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pictures', type: :request do
  describe 'GET /index' do
    subject { get pictures_path }

    let!(:pending) { create :picture, status: 'pending' }
    let!(:rejected) { create :picture, status: 'rejected' }
    let!(:approved) { create :picture, status: 'approved' }
    let(:approved_picture_edit_path) { edit_picture_path(approved) }
    let(:pending_picture_edit_path) { edit_picture_path(pending) }
    let(:rejected_picture_edit_path) { edit_picture_path(rejected) }

    context 'when user is not signed in' do
      it 'returns status code 200' do
        expect(subject).to eq 200
      end

      it 'displays only approved picture' do
        subject
        expect(response.body).to include(approved_picture_edit_path)
        expect(response.body).not_to include(pending_picture_edit_path)
        expect(response.body).not_to include(rejected_picture_edit_path)
      end
    end
  end
end
