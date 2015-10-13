class Article < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 5 }
    validates :slug, presence: true, uniqueness: { case_sensitive: false }
    belongs_to :user
    has_many :comments

    def to_param
      slug
    end
end
