class Client

  def initialize(email, password)
    response = HTTP.post(ENV['HOST_URL'] + "/user/login", json: {user_details: { email: email, password: password } } )

    if response.code == 200
      @auth_token =  JSON.parse(response.body)["token"]
    end
  end

  def get_users
    HTTP.auth(@auth_token).
      get(ENV['HOST_URL'] + "/user").to_s
  end

  def get_user(user_id)
    HTTP.auth(@auth_token).
      get(ENV['HOST_URL'] + "/user/" + user_id).to_s
  end

  def delete_user(user_id)
    HTTP.auth(@auth_token).
      delete(ENV['HOST_URL'] + "/user/" + user_id).to_s
  end

  def update_user(user_id, new_data)
    HTTP.auth(@auth_token).
      put(ENV['HOST_URL'] + "/user/" + user_id, json: { user_details: new_data } ).to_s
  end
end
