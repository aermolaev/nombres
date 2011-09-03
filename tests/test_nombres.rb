require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/nombres')

class Integer
  include Nombres
end

class TestNombres < Test::Unit::TestCase
  @@nombres = {
    0 => 'zéro',
    1 => 'un',
    11 => 'onze',

    28 => 'vingt-huit',
    31 => 'trente et un',
    180 => 'cent quatre-vingts',
    183 => 'cent quatre-vingt-trois',
    124 => 'cent vingt-quatre',
    777 => 'sept cent soixante-dix-sept',
    851 => 'huit cent cinquante et un',

    101 => 'cent un',
    1_001 => 'mille un',

    3_033 => 'trois mille trente-trois',
    3_300 => 'trois mille trois cents',
    300_000 => 'trois cent mille',

    1_000_000 => 'un million',
    300_000_000 => 'trois cents millions',
    80_000_000 => 'quatre-vingts millions',
  }

  def test_nombres
    @@nombres.each do |num, str|
      assert_equal str, num.to_nombre
    end
  end
end