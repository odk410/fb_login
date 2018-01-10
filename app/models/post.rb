class Post < ActiveRecord::Base
  validates :title, presence: true,
                    length: { minimum: 2 }
  validates :content
end
