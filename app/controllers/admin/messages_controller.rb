module Admin
  # MessagesController
  class MessagesController < AdminController
    before_action :authenticate_user!, except: %i[new create]
    before_action :show_history, only: [:index]
    before_action :set_message, only: [:show, :edit, :update, :destroy]

    # GET /messages
    def index
      @q = Message.ransack(params[:q])
      messages = @q.result(distinct: true)
      @objects = messages.page(@current_page).order(position: :desc)
      @total = messages.size
      @messages = @objects.order(:position)
      if !@objects.first_page? && @objects.size.zero?
        redirect_to messages_path(page: @current_page.to_i.pred, search: @query)
      end
    end

    # GET /messages/1
    def show
      @objects = Message.all
      message = Message.find_by(id: params[:id])
      # @reply = Message.new(reply_id: message.id)
      # message.update(read: true) unless message.read
    end

    # GET /messages/new
    def new
      @message = Message.new
      authorize @message
    end

    # GET /messages/1/edit
    def edit
      authorize @message
    end

    # POST /messages
    def create
      @message = Message.new(message_params)
      # if verify_recaptcha(model: @message, timeout: 10, message: "Oh! It's error with reCAPTCHA!") and @message.save
      if @message.save
        redirect_to app_thanks_es_path(@message.id)
      else
        redirect_to root_path, notice: 'error'
      end
        # ContactMailer.contact(@message).deliver_now
      # else
      #   redirect_to "/", notice: 'no enviado'
      # end
      authorize @message
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
      redirect_to messages_url, notice: actions_messages(@message)
      authorize @message
    end

    def destroy_multiple
      Message.destroy redefine_ids(params[:multiple_ids])
      redirect_to(
        messages_path(page: @current_page, search: @query),
        notice: actions_messages(Message.new)
      )
      authorize @message
    end

    # PATCH/PUT /messages/1
    # def update
    #   if @message.update(message_params)
    #     redirect(@message, params)
    #   else
    #     render :edit
    #   end
    #   authorize @message
    # end

    # def clone
    #   @message = Message.clone_record params[:message_id]
    #
    #   if @message.save
    #     redirect_to admin_messages_path
    #   else
    #     render :new
    #   end
    #   authorize @message
    # end

    def import
      Message.import(params[:file])
      redirect_to(
        admin_messages_path(page: @current_page, search: @query),
        notice: actions_messages(Message.new)
      )
      authorize @message
    end

    def download
      @messages = Message.all
      respond_to do |format|
        format.html
        format.xls { send_data(@messages.to_xls) }
        format.json { render :json => @messages }
      end
      authorize @messages
    end

    def reload
      @q = Message.ransack(params[:q])
      messages = @q.result(distinct: true)
      @objects = messages.page(@current_page).order(position: :desc)
    end

    def sort
      Message.sorter(params[:row])
      render :index
    end

    private

    # def set_attachments
    #   @attachments = ['logo', 'brand', 'photo', 'avatar', 'cover', 'image',
    #                   'picture', 'banner', 'attachment', 'pic', 'file']
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:name, :dni, :address, :subject, :content)
    end

    def show_history
      get_history(Message)
    end

  end
end
