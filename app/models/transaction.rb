class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :marketpost
  attr_accessor :email
  attr_accessible :description, :user_id, :sender_id, :receiver_id, :email, :marketpost_id, :hidden_transaction, :receiver_read, :sender_read
  validate :email_has_user
  validates :description, presence: true, length: { minimum: 5 }

  private

  def email_has_user
    if not self.email.nil?
      self.receiver = User.find_by_email self.email
      if self.receiver.nil?
        errors.add(:base, "E-mail address has no account associated")
      end
    end
  end
end
