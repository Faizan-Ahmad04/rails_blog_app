# class Blog < ApplicationRecord
#   belongs_to :user
#   has_one_attached :image
#   has_many :comments
  
#   validate :image_file_format
 
#   private

#   def image_file_format
#     if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/jpg))
#       image.purge
#       errors.add(:image, 'File must be an image (JPEG/PNG/JPG )')
#     end
#   end
# end


class Blog < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  validate :image_mandatory, :image_file_format

  private

  def image_mandatory
    unless image.attached?
      errors.add(:image, 'must be attached')
    end
  end

  def image_file_format
    return unless image.attached?

    unless image.content_type.in?(%w(image/jpeg image/png image/jpg))
      image.purge
      errors.add(:image, 'File must be an image (JPEG/PNG/JPG)')
    end
  end
end
