module AttachmentsHelper
    def get_image
        @attachment = Attachment.find(params[:id])
        send_data(@attachment.data, :type => @attachment.mime_type, :filename => "#{@attachment.name}.jfif", :disposition => "inline")
    end
end
