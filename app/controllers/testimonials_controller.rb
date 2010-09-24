class TestimonialsController < ApplicationController
  
  before_filter do |controller|
    controller.ensure_logged_in "you_must_log_in_to_send_a_message"
    controller.ensure_authorized "you_are_not_authorized_to_do_this"
  end
  
  before_filter :ensure_feedback_not_given
  
  def new
    @testimonial = Testimonial.new
  end

  def create
    @testimonial = Testimonial.new(params[:testimonial])
    puts 
    if @testimonial.save
      flash[:notice] = ["feedback_sent_to", @conversation.other_party(@current_user).given_name, @conversation.other_party(@current_user)]
      redirect_to (session[:return_to_inbox_content] || root)
    else
      puts @testimonial.errors.full_messages.inspect
      render :action => new
    end    
  end
  
  def skip
    @participation.update_attribute(:feedback_skipped, true)
    flash[:notice] = "feedback_skipped"
    respond_to do |format|
      format.html { redirect_to single_conversation_path(:conversation_type => "received", :person_id => @current_user.id, :id => @conversation.id) }
      format.js { render :layout => false }
    end
  end
  
  private
  
  def ensure_feedback_not_given
    @conversation = Conversation.find(params[:message_id])
    @participation = Participation.find_by_person_id_and_conversation_id(@current_user, @conversation)
    unless @participation.feedback_can_be_given? 
      flash[:error] = "you_have_already_given_feedback_about_this_event"
      redirect_to root and return
    end  
  end

end