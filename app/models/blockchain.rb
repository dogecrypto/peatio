# encoding: UTF-8
# frozen_string_literal: true

# TODO: Add specs.
class Blockchain < ActiveRecord::Base
  has_many :currencies, foreign_key: :blockchain_key, primary_key: :key

  # TODO: Add more validations.
  validates :height, numericality: { greater_than_or_equal_to: 1, only_integer: true }

  def explorer=(hash)
    write_attribute(:explorer_address, hash.fetch('address'))
    write_attribute(:explorer_transaction, hash.fetch('transaction'))
  end

  def status
    super&.inquiry
  end

  def case_insensitive?
    !case_sensitive?
  end
end

# == Schema Information
# Schema version: 20180708171446
#
# Table name: blockchains
#
#  id                   :integer          not null, primary key
#  key                  :string(255)      not null
#  name                 :string(255)
#  client               :string(255)      not null
#  server               :string(255)
#  height               :integer          not null
#  min_confirmations    :integer          default(6), not null
#  explorer_address     :string(255)
#  explorer_transaction :string(255)
#  status               :string(255)      not null
#  case_sensitive       :boolean          default(TRUE), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_blockchains_on_key     (key) UNIQUE
#  index_blockchains_on_status  (status)
#
