class Animal < ActiveRecord::Base
  Dir[File.join(File.dirname(__FILE__), "*.rb")].each do |f|
    Animal.const_get(File.basename(f, '.rb').classify)
  end

  #
  # Single Table Inheritance (STI) - Defines the column name for use with single table inheritance
  #
  self.inheritance_column = :race

  belongs_to :tribe

  validates :race, presence: true

  scope :lions, -> { where(race: 'Lion') }
  scope :meerkats, -> { where(race: 'Meerkat') }
  scope :wild_boars, -> { where(race: 'WildBoar') }

  def talk
    raise 'Abstract Method'
  end

  def self.select_options
    descendants.map{ |c| c.to_s }.sort
  end


  class << self
    def races
      #%w(Lion WildBoar Meerkat)
      children = []
      descendants.select {|d| children << d.to_s }
      children.sort()
    end
  end

  attr_accessible :age, :name, :race
end
