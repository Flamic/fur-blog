class AttachmentsController < ApplicationController
  def index
    @attachments = Attachment.all
  end

  def show
    @attachment = Attachment.find(params[:id])
  end
  
  def new
    @attachment = Attachment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @attachment = Attachment.new(params[:attachment]) do |t|
      if params[:attachment][:data]
        t.data      = params[:attachment][:data].read
        t.filename  = params[:attachment][:data].original_filename
        t.mime_type = params[:attachment][:data].content_type
      end
    end
    @attachment.article = @article
    
    @attachment.save
  end
  
  def destroy
    Article.find(params[:article_id]).attachment.destroy
  end

  def article_params
    #params.require(:attachment).permit(:data, :filename, :mime_type, :article_id)
    params.require(:attachment).permit(:article_id, :attachment)
end
