module Roadmap
  

    def get_roadmap(roadmap_id)
      response = self.class.get("#{@api_uri}/roadmap/#{roadmap_id}", headers: { "authroization" =>@auth_token})
      @roadmap = JSON.parse(response.body)
    end

    def get_checkpoint(checkpoint_id)
      response = self.class.get("#{@api_uri}/checkpoint#{checkpoint_id}",
      headers: { "authorization" => @auth_token})
      @checkpoint = JSON.parse(response.body)
    end

end
