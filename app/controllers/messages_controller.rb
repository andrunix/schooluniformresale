class MessagesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource 
  # skip_authorize_resource :only => :friends

  # GET /messages
  # GET /messages.json
  def index
    # @messages = Message.where(to_user_id: current_user.id)
    @messages = current_user.incoming_messages.order(created_at: :desc)
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message.update_attribute(:unread, false)
  end

  # GET /messages/new
  def new
    #@message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # GET /messages/1/reply
  def reply
    logger.debug "***** reply called"
    message = Message.find(params[:id])

    return if message.nil?

    @message = Message.new(parent_message_id: params[:id],
      item_id: message.item_id,
      from_user_id: current_user.id,
      to_user_id: message.from_user_id,
      subject: "Re: #{message.subject}")
  end

  # POST /messages
  # POST /messages.json
  def create
    #@message = Message.new(message_params)

    if @message.parent_message_id.present?
      parent_message = Message.find(@message.parent_message_id)
      @message.to_user_id = parent_message.from_user_id
    end

    item = Item.find(@message.item_id) if @message.item_id.present?

    @message.from_user_id = current_user.id
    if !@message.subject.present?
      if item != nil
        @message.subject = "#{item.name}"
      else
        @message.subject = params[:subject]
      end
    end
    @message.unread = true

    respond_to do |format|
      if @message.save
        format.html { redirect_to (item != nil) ? item : messages_path, notice: 'Message was successfully sent.' }        
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_message
    #   @message = Message.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:from_user_id, :to_user_id, :parent_message_id, :subject, :message, :item_id, :unread, :folder_id)
    end
end
