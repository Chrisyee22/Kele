require 'httparty'

class Kele
  include HTTParty


  def initialize(email, password)
    @api_url = 'https://www.bloc.io/api/v1'
    options = {
      body: {
        email: email,
        password: password
      }
    }
    response = self.class.post "#{@api_url}/sessions", options

    if response.code == 200
      p "Welcome #{email}!"

    else
      p "Email or password are incorrect"

    end
  end
end
