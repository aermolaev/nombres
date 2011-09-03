module Nombres
  def to_nombre
    nombre_to_str(self)
  end

  def nombre(number)
    nombre_to_str(number.to_i)
  end

  private

  @@tokens = {
    'zero' => 'zéro',
    0 => '',
    1 => 'un',
    2 => 'deux',
    3 => 'trois',
    4 => 'quatre',
    5 => 'cinq',
    6 => 'six',
    7 => 'sept',
    8 => 'huit',
    9 => 'neuf',
    10 => 'dix',
    11 => 'onze',
    12 => 'douze',
    13 => 'treize',
    14 => 'quatorze',
    15 => 'quinze',
    16 => 'seize',
    20 => 'vingt',
    30 => 'trente',
    40 => 'quarante',
    50 => 'cinquante',
    60 => 'soixante',
    80 => 'quatre-vingt',
    100 => 'cent'
  }

  @@milles = {
    0 => ' ',
    1 => ' mille',
    2 => ' million',
    3 => ' milliard',
    4 => ' trillion',
    5 => ' quadrillion',
    6 => ' quintillion'
  }

  def get_token(token)
    @@tokens[token]
  end

  def get_mille(mille, num)
    @@milles[mille] + (mille >= 2 && num > 1 ? 's' : '')
  end

  def prefix_chiffre(decade, chiffre)
    case
      when decade >= 2 && decade <= 7
        case
          when chiffre >= 2 || chiffre == 0
            '-'

          when chiffre == 1
            ' et '

          else
            ''
        end

      when decade >= 8
        '-'

      else
        ''
    end
  end

  def from_0_9(decade, chiffre)
    if chiffre > 0
      prefix_chiffre(decade, chiffre) + get_token(chiffre)
    else
      decade == 8 ? 's' : ''
    end
  end

  def from_10_19(decade, chiffre)
    string = prefix_chiffre(decade, chiffre)
    string << (chiffre <= 6 ? get_token(10 + chiffre) : get_token(10) + '-' + get_token(chiffre))
  end

  def cent_tokenize(number, mille)
    string  = ' '
    cent = number % 1000 / 100
    decade = number % 100 / 10
    chiffre = number % 10

    string << case
      when cent > 1
        get_token(cent) + ' ' + get_token(100)

      when cent == 1
        get_token(100)

      else
        ''
    end

    if mille == 0 && cent > 1 && decade == 0 && chiffre == 0
      string << 's'
    end

    string << ' ' << case
      when decade == 1 || decade == 7 || decade == 9
        get_token((decade - 1) * 10) + from_10_19(decade, chiffre)

      else
        get_token(decade * 10) + from_0_9(decade, chiffre)
    end
  end

  def nombre_to_str(number)
    return get_token('zero') if number == 0

    string = ''
    mille = 0

    while number != 0
      num = number % 1000
      mille_string = ''

      unless mille == 1 && num < 2
        mille_string << cent_tokenize(num, mille)
      end

      if num != 0
        mille_string << get_mille(mille, num)
      end

      string = mille_string + string

      number /= 1000
      mille += 1
    end

    string.strip.gsub(/\s+/, ' ')
  end
end
