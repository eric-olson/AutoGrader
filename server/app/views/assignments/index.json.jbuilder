json.array!(@assignments) do |assignment|
  json.extract! assignment, :id, :description, :test_path, :spec_path
  json.url assignment_url(assignment, format: :json)
end
