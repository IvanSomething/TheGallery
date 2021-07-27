# frozen_string_literal: true

class Picture < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_attached_file :image, styles: { large: '600x600>', medium: '400x300>' }
  validates_attachment_content_type :image, content_type: %r{\Aimage/.*\z}
  scope :approved, -> { where(status: 'approved') }
  scope :pending_approval, -> { where(status: 'pending') }
  scope :rejected, -> { where(status: 'rejected') }
  scope :without_rejected, -> { where.not(status: 'rejected') }

  def approved?
    status == 'approved'
  end
end
