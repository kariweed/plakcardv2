json.array!(@guests) do |guest|
  json.extract! guest, :id, :name, :table_num
  json.url guest_url(guest, format: :json)
end
