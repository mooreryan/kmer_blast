class Sequence < Tableless
  column :sequence
  validates_presence_of :sequence

end
