json.array!(@exports) do |export|
  json.extract! export, :id, :item_id, :container, :booking, :loading, :port, :party, :agent, :remarks, :weight
  json.url export_url(export, format: :json)
end
