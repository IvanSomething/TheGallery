# frozen_string_literal: true

class PicturesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @pictures = Picture.approved
  end

  def create
    @picture = Picture.create(pictures_params)
    if @picture.persisted?
      redirect_to pictures_path
    else
      render json: @picture.errors, status: :unprocessable_entity
    end
  end

  def edit
    find_params_id
  end

  def approve
    find_params_id
    @picture.update!(status: 'approved')
    redirect_to pictures_path
  end

  def reject
    find_params_id
    @picture.update!(status: 'rejected')
    redirect_to pictures_path
  end

  def pending
    if current_user.try(:admin?)
      @pictures = Picture.pending_approval
      render 'partials/admin_index'
    else 
      redirect_to pictures_path
    end
  end

  private

  def pictures_params
    params.permit(:image, :description).merge(user: current_user)
  end

  def find_params_id
    @picture = Picture.find(params[:id])
  end
end
