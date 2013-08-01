# == Schema Information
#
# Table name: sequences
#
#  id         :integer          not null, primary key
#  sequence   :text             not null
#  created_at :datetime
#  updated_at :datetime
#  mer_size   :integer          not null
#

class Sequence < ActiveRecord::Base
  validates :sequence, presence: true
  validates :mer_size, presence: true
  
  # remove any whitespace
  before_save { |seq| seq.sequence.gsub! /\s/, '' }
end
