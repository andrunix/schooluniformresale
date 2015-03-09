json.array!(@schools) do |school|
  json.extract! school, :id, :name, :description, :address1, :address2, :city, :state, :zip, :url, :email, :approved, :created_by
  json.url school_url(school, format: :json)
end
