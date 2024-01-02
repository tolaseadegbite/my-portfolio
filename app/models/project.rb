class Project < ApplicationRecord
  validates :name, :description, :github_link, presence: true

  belongs_to :user

  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end

  has_rich_text :description

  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format" },
                      size: { less_than: 1.megabytes,
                              message:   "should be less than 1MB" }
end
