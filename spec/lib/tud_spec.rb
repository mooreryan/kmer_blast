require 'spec_helper'
require 'tud'

describe 'tud' do

  describe 'calc_tud' do
    it 'calculates tud for the sequence given'
  end

  describe 'blank_kmer_map' do
    describe 'gives 4**n combinations of stnd nucleotides if n >= 1' do
      specify do
        (1..6).map { |n| blank_kmer_map( n ).count }
          .should eq( (1..6).map { |n| 4**n } )
      end
    end
    
    describe 'sets all kmers to 0' do
      specify { blank_kmer_map( 4 ).values.reduce( :+ ).should eq 0 }
    end
  end
  
  describe 'count_kmers' do 
    let(:s) { 'AAcTCCnTGACtC' }
    describe 'counts kmers & ambiguous kmers from 2 - 5 inclusive' do
      # again, will do any number k
      kmaps = {
        2 => { kmers:  {AA: 1, AC: 2, CT: 2, TC: 2, CC: 1, TG: 1, GA: 1},
               ambigs: {CN: 1, NT: 1} },
        3 => { kmers:  {AAC: 1, ACT: 2, CTC: 2, TCC: 1, TGA: 1, GAC: 1},
               ambigs: {CCN: 1, CNT: 1, NTG:1} },
        4 => { kmers:  {ACTC: 2, CTCC: 1, TGAC: 1, GACT: 1, AACT: 1},
               ambigs: {TCCN: 1, CCNT: 1, CNTG: 1, NTGA: 1} },
        5 => { kmers:  {AACTC: 1, ACTCC: 1, TGACT: 1, GACTC: 1},
               ambigs: {CTCCN: 1, TCCNT: 1, CCNTG: 1, CNTGA: 1, NTGAC: 1} } 
      }

      specify do 
        kmaps.each do |size, value|
          kmers = count_kmers( size, s )
          [:kmers, :ambigs].each do |which|
            kmers[which].select { |k, v| v != 0 }.should eq( kmaps[ size ][ which ] )
          end
        end
      end
    end
  end
  
  describe 'expected_kmers' do 
    describe 'for kmer size of one, should match the raw count' do
      specify do 
        s = 'atgcatgctagtggcat'
        expected_kmers( s.length, blank_kmer_map( 1 ), mononuc_freq( s ) )
          .should eq( {A: 4.0, C: 3.0, T: 5.0, G: 5.0} )
      end
    end
  end
  
  describe 'gives expected kmers for k = 2,3,4' do
    # and more of course, it just gets too time consuming
    specify do
      (2..4).each do |n|
        kmer_map = expected_kmers( 4**n, blank_kmer_map( n ), {A: 0.25, C: 0.25, T: 0.25, G: 0.25} )
        kmer_map.select { |k, v| v == 1 }.count.should eq 4**n
      end
    end
  end


  describe 'mononuc_freq' do 
    describe 'calculates mononucleotide frequency' do 
      specify { mononuc_freq( 'AACATAGGCTGAnGiTTCCGCT' ).should eq( {A: 0.25, C: 0.25, T: 0.25, G: 0.25} ) }
    end
  end
end
