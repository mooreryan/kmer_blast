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

require 'spec_helper'

describe Sequence do
  before do
    @sequence = Sequence.new sequence: "acac\nagt\tgccg\rgtg   cggc\r\naacaa\nag taga", mer_size: 4
    @sequence.save
  end

  subject { @sequence }
  
  it { should respond_to :sequence }
  it { should respond_to :mer_size }
  it { should be_valid }
  
  # removes whitespace
  specify { @sequence.sequence.should eq( 'acacagtgccggtgcggcaacaaagtaga' ) }

end

