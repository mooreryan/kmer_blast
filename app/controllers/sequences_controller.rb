require 'foo'
require 'tud'

class SequencesController < ApplicationController
  def new
    @sequence = Sequence.new
  end

  def show
    @sequence = Sequence.find params[:id]
    @bar = calc_kud @sequence.mer_size.to_i, @sequence.sequence
  end

  def edit
  end

  def index
  end

  def create
    @sequence = Sequence.new sequence_params
    if @sequence.save
      redirect_to @sequence
    else
      render 'new'
    end
  end

  private
  
  def sequence_params
    # this should throw an error if sequence isnt
    # provided, but it doesn't seem to do so
    params.require( :sequence ).permit( :sequence, :mer_size )
  end

end
