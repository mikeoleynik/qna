ThinkingSphinx::Index.define :comment, with: :active_record do 
  #fileds
  indexes comment_body, sortable: true
  indexes user_id

  # attributes
  has created_at, updated_at
end