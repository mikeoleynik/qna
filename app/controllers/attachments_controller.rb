class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attach

  respond_to :js

  def destroy
    respond_with(@attachment.destroy) if current_user.author_of?(@attachment.attachable)
  end

  private

  def set_attach
  	@attachment = Attachment.find(params[:id])
  end
end