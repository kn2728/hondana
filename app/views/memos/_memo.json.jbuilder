json.extract! memo, :id, :content, :user_id, :book_id, :created_at, :updated_at
json.url memo_url(memo, format: :json)
