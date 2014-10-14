class Marketpost < ActiveRecord::Base
  belongs_to :user, validate: true
  attr_accessible :message, :user, :user_id, :title, :post_type, :tag_list, :hidden_marketpost
  acts_as_taggable_on :tags
  validates :user_id, :title, :message, :post_type, presence: true
  has_many :transactions, dependent: :destroy
end
