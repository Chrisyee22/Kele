require 'httparty'
require 'json'
require './lib/roadmap'

class Kele

  include HTTParty
  include Roadmap
  attr_accessor :user_data

  def initialize(email, password)
    @api_uri = 'https://www.bloc.io/api/v1'
    options = {
      body: {
        email: email,
        password: password
      }
    }
    response = self.class.post "#{@api_uri}/sessions", options

    if response.code == 200
      p "Welcome #{email}!"
      @auth_token = response["auth_token"]

    else
      p "Email or password are incorrect"

    end
  end

  def get_me
    response = self.class.get("#{@api_uri}/users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("#{@api_uri}/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token})
      @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page = 1)
        response = self.class.get("#{@api_uri}/message_threads?page=#{page}", headers: {"authorization" => @auth_token})
      # response = self.class.get("#{@api_uri}/message_threads", headers: { "authorization" => @auth_token })
      @messages = JSON.parse(response.body)
  end

  def create_message(sender_email, recipient_id, message_thread, subject, body)

    response = self.class.post("#{@api_uri}/messages",
      if token
        msg_data ={
          body: {
          "sender": sender_email,
          "recipient_id": recipient_id,
          "token": message_thread,
          "subject": subject,
          "stripped-text": body
      }
    }
  else
    msg_data ={
      body: {
        'sender': sender_email,
        'recipient_id': recipient_id,
        'subject': subject,
        'stripped-text': body
      },
        headers: {"authorization" => @auth_token})
      }
    end
    response = self.class.post("#{@api_uri}/messages",
  end

  def create_submission(assignment_branch, assignment_commit_link, checkpoint_id, comment)
    response = self.class.post("#{@api_uri}/checkpoint_submissions",
      body: {
        "assignment_branch": assignment_branch,
        "assignment_commit_link": assignment_commit_link,
        "checkpoint_id": checkpoint_id,
        "comment": comment,
        "enrollment_id": @me_hash["current_enrollment"]["id"],
      },
      headers: {"authorization" => @auth_token})

  end

end
