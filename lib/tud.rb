# main worker of this module
def calc_kud size, seq
  seq.gsub! /\n/, ''
  kmer_counts = count_kmers( size, seq ) [:kmers]
  nucleotide_frequency = mononuc_freq seq
  expected = expected_kmers seq.length, kmer_counts, nucleotide_frequency
  
  kuds = {}
  kmer_counts.each do |kmer, num|
    # haven't looked whether it is even possible for it to be 0
    unless expected[kmer] == 0
      kuds[kmer] = num / expected[kmer].to_f
    else
      kuds[kmer] = 0
    end
  end
  kuds
end

#### helper fns ####

# creates map of all kmers of size n set to 0
def blank_kmer_map size
  kmers = {}
  %w[A C T G].repeated_permutation(size).to_a.map { |arr| arr.join.to_sym }.each { |s| kmers[s] = 0 }
  kmers
end

# this function has been checked against jellyfish, and it aggrees with it
# though jellyfish is of course faster
def count_kmers size, seq
  seq.upcase!
  # creates this structure: {AAAA: 0, AAAC: 0, ... , GGGG: 0}
  # for whatever kmer size you select
  tetras = blank_kmer_map size
  ambigs = {}
  # sliding window of kmers, increments the tetras hash for each occurence of kmer
  (0..(seq.length - size)).each do |num|
    unless tetras[seq[num..num+(size-1)].to_sym].nil? # should throw out kmers with ambiguous bases
      tetras[seq[num..num+(size-1)].to_sym] += 1 
    else
      unless ambigs[seq[num..num+(size-1)].to_sym].nil?
        ambigs[seq[num..num+(size-1)].to_sym] += 1
      else
        ambigs[seq[num..num+(size-1)].to_sym] = 1
      end
    end
  end

  {kmers: tetras, ambigs: ambigs}
end

# doesn't create its own list of all kmers
# rather uses the one provided to save the
# duplicated calculation
#
# also can handle any length of kmer set
# that you put into kmers_map
def expected_kmers len, kmers_map, freq_map
  exp_kmers = {}
  kmers_map.each do |kmer, num| 
    k_arr = kmer.to_s.split( // )
    expected_num = k_arr.map { |k| freq_map[k.to_sym] }.reduce( :* ) * len
    exp_kmers[kmer] = expected_num
  end
  exp_kmers
end

# counts A,C,T,G; removes any others
# subtracts num of ambig bases from total
def mononuc_freq seq
  seq.upcase!
  counts = %w[A C T G].map { |l| seq.count l }
  total_no_ambigs = counts.reduce( :+ ).to_f

  { A: counts[0] / total_no_ambigs,
    C: counts[1] / total_no_ambigs,
    T: counts[2] / total_no_ambigs,
    G: counts[3] / total_no_ambigs }
end

def print_map hash_map
  hash_map.each do |k, v|
    puts "#{k}\t#{v}"
  end
end
