json.array!(@announcements) do |announcement|
  json.extract! announcement, :id, :title, :article_id
  json.url announcement_url(announcement, format: :json)
end
