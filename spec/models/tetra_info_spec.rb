# == Schema Information
#
# Table name: tetra_infos
#
#  header :string(255)      not null, primary key
#  info   :text             not null
#

require 'spec_helper'

describe TetraInfo do
  before do
    # format of info_line:
    # tetranucleotide=TUD_observed_expected_calcdate;
    # note this file only has the first four tetranucleotides
    info_line = File.open( File.expand_path( '../spec/test_files/tetra_info_string.txt', 'r' ) ).read.chomp

    @tetra_info = TetraInfo.new header: "Acaryochloris_marina_MBIC11017_chromosome_complete_genome",
                                info: info_line
  end

  subject { @tetra_info }
  
  it { should respond_to :header }
  it { should respond_to :info }
  it { should be_valid }
  
  describe 'parse_info should parse the info into a nice map' do 
    specify do
      @tetra_info.parse_info.should eq( { header: :Acaryochloris_marina_MBIC11017_chromosome_complete_genome,
                                          info: 
                                          { AAAA: 
                                            { tud: 1.4923774658746862,
                                              observed: 47242,
                                              expected: 31655.530239671196,
                                              calcdate: "2013-07-27T20:49:38-04:00" },
                                            AAAC: 
                                            { tud: 1.1559403813643168,
                                              observed: 32838,
                                              expected: 28408.039488370876,
                                              calcdate: "2013-07-27T20:49:38-04:00" },
                                            AAAT:
                                            { tud: 1.343917525273023,
                                              observed: 42413,
                                              expected: 31559.228302632335,
                                              calcdate: "2013-07-27T20:49:38-04:00" },
                                            AAAG:
                                            { tud: 1.2660696984269424,
                                              observed: 35734,
                                              expected: 28224.354507811488,
                                              calcdate: "2013-07-27T20:49:38-04:00" } } } )
    end
  end

  describe 'parse_tud should parse the info into a nice tud map' do 
    specify do 
      @tetra_info.parse_tud.should eq( { header: :Acaryochloris_marina_MBIC11017_chromosome_complete_genome,
                                         tud_info: 
                                         { AAAA: 1.4923774658746862, 
                                           AAAC: 1.1559403813643168, 
                                           AAAT: 1.343917525273023, 
                                           AAAG: 1.2660696984269424} } )
    end
  end

end
