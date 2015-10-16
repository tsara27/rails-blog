class Article < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 5 }
    validates :slug, presence: true, uniqueness: { case_sensitive: false }
    belongs_to :user
    has_many :comments

    def to_param
      slug
    end

    def next
      self.class.where("id > :id",id: id).take(1)
    end

    def prev
      self.class.where("id < :id",id: id).take(1)
    end
end
