require 'spec_helper'

describe "Sequences" do
  subject { page }

  shared_examples_for 'all sequence pages' do
    it { should have_title full_title page_title }
    it { should have_selector 'h1', text: heading }
  end

  describe 'new' do 
    before { visit tetra_blast_path }
    
    let( :heading ) { 'Magic 4mer Blast' }
    let( :page_title ) { 'Magic 4mer Blast' }
    
    it_should_behave_like 'all sequence pages'

    it { should have_selector 'form' }
    it { should have_selector 'input' }
    it { should have_selector 'label', text: 'Sequence' }

    describe 'without anything entered' do
      it 'should not create a new sequence record' do
        expect { click_button 'Submit' }.not_to change Sequence, :count
      end
    end

    describe 'when something is pasted in' do
      before do 
        fill_in 'Sequence', with: 'actagtacgatcgatcgatcgatgcagcGACGTAGCTGACTGATGTACGTAGCTAGCTAGCTG'
        choose 'sequence_mer_size_4'

        TetraInfo.create header: 'im the header', info: "AAAA=1.5_3_2.0_imthecalcdate"
      end
      
      it 'should create a user' do 
        expect { click_button 'Submit' }.to change( Sequence, :count ).by 1
      end
    end
  end
end
