class Product < ApplicationRecord
  has_many :subscripters, dependent: :destroy
  has_one_attached :featured_image
  has_rich_text :description

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  after_update_commit :notify_subscribers, if: :back_in_stock?

  private

  def back_in_stock?
    inventory_count_previously_was.zero? && inventory_count.positive?
  end

  def notify_subscribers
    subscripters.each do |subscripter|
      ProductMailer.with(subscripter: subscripter, product: self).in_stock.deliver_later
    end
  end
end
