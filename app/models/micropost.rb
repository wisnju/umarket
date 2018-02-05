class Micropost < ActiveRecord::Base
  belongs_to :user
  #定义了读取用户内容的默认排序
  default_scope -> { order(created_at: :desc) }
  #将图片与模型关联
  mount_uploader :picture, PictureUploader
  #用户存在性验证和发布内容长度验证
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size
  
  private
  
    # 验证上传的图片大小
    def picture_size
      if picture.size > 2.megabytes
        errors.add(:picture, "should be less than 2MB")
      end
    end
end
