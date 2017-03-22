class MerchantTransaction < ApplicationRecord
  belongs_to :merchant_location

  def notes=(tenders)
    write_attribute(:notes, tenders.map(&:note).join(','))
  end

  def currency=(tenders)
    write_attribute(:currency, tenders.first.amount_money.currency)
  end

  def amount_money=(tenders)
    write_attribute(:amount_money, tenders.inject(0){ |total, tender|  total += tender.amount_money.amount })
  end

  def processing_fee_money=(tenders)
    write_attribute(:processing_fee_money, tenders.inject(0){ |total, tender|  total += tender.processing_fee_money.amount })
  end
end
