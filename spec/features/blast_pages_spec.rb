require 'spec_helper'

describe 'BlastPages' do
  subject { page }

  shared_examples_for 'all blast pages' do
    it { should have_title full_title page_title }
    it { should have_selector 'h1', text: heading }
  end

  describe 'Blast' do
    before { visit blast_path }
    
    let(:heading) { 'Kmer Blast' }
    let(:page_title) { 'Kmer Blast' }

    it_should_behave_like 'all blast pages'

    it { should have_selector 'form' }
    it { should have_selector 'input' }
    it { should have_selector 'label', text: 'Sequence' }
  end
end
