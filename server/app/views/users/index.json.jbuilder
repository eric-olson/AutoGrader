json.array!(@users) do |user|
  json.extract! user, :id, :multipass_id, :code_path
  json.url user_url(user, format: :json)
end
