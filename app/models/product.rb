class Product < ActiveRecord::Base
  belongs_to :category

  validates :title, :description, :category, presence: true  
  validates :price, numericality: { greater_than: 0 }
  validate :title_is_shorter_than_description

  scope :published, -> { where(published: true) }

  def title_is_shorter_than_description
    return if title.blank? or description.blank?
    if title.length > description.length
      errors.add(:title, 'should be shorter than description')
    end
  end
end