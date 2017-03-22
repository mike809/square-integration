class Admin::MerchantTransactionsController < ApplicationController
  def index
  end

  def show
  end

  # TODO: Reporting on different years transactions

  # def report
  #   by_year = MerchantTransaction.all.group_by do |tr| DateTime.parse(tr.transaction_date).year end
  #   @transactions = by_year.each{ |year, trs| by_year[year] = trs.group_by{ |tr| DateTime.parse(tr.transaction_date).month } }
  # end
end
