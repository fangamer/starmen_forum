class Forum::ReplyController < ApplicationController
  before_action :require_forum
  before_action :require_topic
  before_action :require_login
  before_action :early_checks

  before_action :preview, only:[:post], if:->{params[:preview]}

  def backwards_compatibility
    super
    @page = "posts"
    @smilies = []
  end

  def early_checks
    # check if user is not banned from this forum
    # check if user is not banned from posting
    # check if user is not banned from this topic
    # check if topic is locked
  end

  def index
    @message = Message.new(topic:@topic)
  end

  def preview
    @message = Message.new(message_params)
    @message.topic = @topic
    @preview = true
    render action: :index
  end

  def post
    @message = Message.new(message_params)
    @message.topic = @topic
    @message.creator = @logged_in_user
    @message.ip_address = request.remote_ip
    if @message.save
      redirect_to @message.url
    else
      render action: :index
    end
  end

  helper_method def type(type)
    case type
      when :edit then "Edit!"
      when :reply then "Reply!"
      when :new_topic then "Create New Topic!"
      else "Reply!"
    end
  end

private

  def message_params
    params[:message].permit(:body_original,:show_sig,:disable_smilies,:disable_textile)
  end
end
