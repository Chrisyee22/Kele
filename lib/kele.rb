require 'httparty'
require 'json'

class Kele
  include HTTParty


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

    else
      p "Email or password are incorrect"

    end
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("#{@api_uri}/users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("#{@api_uri}/mentors/#{mentor_id}/student_availability", headers: {
      "authorization" => @auth_token})
      @mentor_availability = JSON.parse(response.body)
  end
end
