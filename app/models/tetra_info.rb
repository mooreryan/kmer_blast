# == Schema Information
#
# Table name: tetra_infos
#
#  header :string(255)      not null, primary key
#  info   :text             not null
#

require 'r_squared'
require 'tud'

class TetraInfo < ActiveRecord::Base

  def TetraInfo.r_squared_info query_record
    query_kud = calc_kud query_record.mer_size.to_i, query_record.sequence
    @analysis_map = {}
    tetra_info = TetraInfo.all.map { |rec| rec.parse_tud }
    tetra_info.each do |rec|
      @analysis_map[ rec[:header] ] = analyze query_kud, rec[:tud_info]
    end
    @analysis_map
  end

  # returns a useable TetraInfo 'record'
  def parse_info
    info_map = {}
    
    # tetranucleotide=TUD_observed_expected_calcdate;....
    self.info.
      # one entry in array for each kmer
      split( ';' ).
      # [["AAAA", "1.49_47242_31655.53_2013-07-27T20:49:38-04:00"], ...]
      map { |s| s.split '=' }.
      # [[:AAAA, {tud: ..., observed: ..., expected: ..., calcdate: ...}], ...]
      map { |kmer, info| arr = info.split '_'
      [ kmer.to_sym, 
        { tud: arr[0].to_f, observed: arr[1].to_i, 
          expected: arr[2].to_f, calcdate: arr[3]}] }.
      # each entry: {AAAA: { tud: ..., observed: ..., expected: ..., calcdate: ...}, ...}
      each { |kmer, hmap| info_map[kmer] = hmap } 
    
    { header: self.header.to_sym, info: info_map }
  end

  def parse_tud
    tud_map = {}
    
    self.info.
      split(';').
      map { |s| s.split '=' }.
      each { |kmer, info| tud_map[kmer.to_sym] = info.split( '_' )[0].to_f }
    
    { header: self.header.to_sym, tud_info: tud_map }
  end



end
