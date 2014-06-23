require 'json'

class Elements
  def initialize
    json = '{"Hydrogen":{"weight":389,"value":400},"Helium":{"weight":309,"value":380},"Lithium":{"weight":339,"value":424},"Beryllium":{"weight":405,"value":387},"Boron":{"weight":12,"value":174},"Carbon":{"weight":298,"value":483},"Nitrogen":{"weight":409,"value":303},"Oxygen":{"weight":432,"value":497},"Fluorine":{"weight":414,"value":306},"Neon":{"weight":149,"value":127},"Sodium":{"weight":247,"value":341},"Magnesium":{"weight":327,"value":98},"Aluminium":{"weight":195,"value":343},"Silicon":{"weight":356,"value":122},"Phosphorus":{"weight":49,"value":157},"Sulfur":{"weight":151,"value":438},"Chlorine":{"weight":56,"value":460},"Argon":{"weight":317,"value":395},"Potassium":{"weight":383,"value":221},"Calcium":{"weight":281,"value":395},"Scandium":{"weight":394,"value":79},"Titanium":{"weight":377,"value":303},"Vanadium":{"weight":381,"value":308},"Chromium":{"weight":299,"value":295},"Manganese":{"weight":114,"value":447},"Iron":{"weight":422,"value":360},"Cobalt":{"weight":288,"value":249},"Nickel":{"weight":458,"value":482},"Copper":{"weight":91,"value":314},"Zinc":{"weight":104,"value":140},"Gallium":{"weight":470,"value":254},"Germanium":{"weight":77,"value":25},"Arsenic":{"weight":213,"value":393},"Selenium":{"weight":419,"value":96},"Bromine":{"weight":114,"value":199},"Krypton":{"weight":490,"value":8},"Rubidium":{"weight":278,"value":367},"Strontium":{"weight":310,"value":159},"Yttrium":{"weight":175,"value":109},"Zirconium":{"weight":453,"value":288},"Niobium":{"weight":56,"value":375},"Molybdenum":{"weight":147,"value":343},"Technetium":{"weight":123,"value":105},"Ruthenium":{"weight":325,"value":214},"Rhodium":{"weight":418,"value":428},"Palladium":{"weight":353,"value":387},"Silver":{"weight":182,"value":429},"Cadmium":{"weight":411,"value":394},"Indium":{"weight":322,"value":329},"Tin":{"weight":490,"value":436},"Antimony":{"weight":28,"value":479},"Tellurium":{"weight":443,"value":305},"Iodine":{"weight":345,"value":253},"Xenon":{"weight":463,"value":19},"Caesium":{"weight":361,"value":416},"Barium":{"weight":307,"value":417},"Lanthanum":{"weight":291,"value":453},"Cerium":{"weight":259,"value":414},"Praseodymium":{"weight":58,"value":83},"Neodymium":{"weight":127,"value":475},"Promethium":{"weight":11,"value":480},"Samarium":{"weight":361,"value":192},"Europium":{"weight":409,"value":271},"Gadolinium":{"weight":86,"value":231},"Terbium":{"weight":100,"value":75},"Dysprosium":{"weight":166,"value":128},"Holmium":{"weight":54,"value":109},"Erbium":{"weight":432,"value":399},"Thulium":{"weight":361,"value":395},"Ytterbium":{"weight":417,"value":222},"Lutetium":{"weight":311,"value":224},"Hafnium":{"weight":138,"value":101},"Tantalum":{"weight":177,"value":397},"Tungsten":{"weight":14,"value":234},"Rhenium":{"weight":480,"value":141},"Osmium":{"weight":208,"value":490},"Iridium":{"weight":121,"value":68},"Platinum":{"weight":182,"value":29},"Gold":{"weight":339,"value":267},"Mercury":{"weight":259,"value":438},"Thallium":{"weight":342,"value":425},"Lead":{"weight":65,"value":395},"Bismuth":{"weight":33,"value":497},"Polonium":{"weight":293,"value":394},"Astatine":{"weight":392,"value":210},"Radon":{"weight":116,"value":203},"Francium":{"weight":433,"value":253},"Radium":{"weight":303,"value":109},"Actinium":{"weight":149,"value":317},"Thorium":{"weight":342,"value":129},"Protactinium":{"weight":457,"value":50},"Uranium":{"weight":118,"value":77},"Neptunium":{"weight":117,"value":300},"Plutonium":{"weight":106,"value":455},"Americium":{"weight":66,"value":365},"Curium":{"weight":393,"value":407},"Berkelium":{"weight":289,"value":458},"Californium":{"weight":302,"value":322},"Einsteinium":{"weight":455,"value":94},"Fermium":{"weight":216,"value":347},"Mendelevium":{"weight":304,"value":331},"Nobelium":{"weight":49,"value":236},"Lawrencium":{"weight":84,"value":351},"Rutherfordium":{"weight":345,"value":233},"Dubnium":{"weight":168,"value":187},"Seaborgium":{"weight":361,"value":125},"Bohrium":{"weight":236,"value":479},"Hassium":{"weight":201,"value":353},"Meitnerium":{"weight":278,"value":307},"Darmstadtium":{"weight":308,"value":344},"Roentgenium":{"weight":171,"value":201},"Copernicium":{"weight":251,"value":460},"Ununtrium":{"weight":158,"value":52},"Ununquadium":{"weight":282,"value":113},"Ununpentium":{"weight":145,"value":497},"Ununhexium":{"weight":459,"value":449},"Ununseptium":{"weight":327,"value":7},"Ununoctium":{"weight":184,"value":411}}'

    @e = JSON.parse(json)
    @keys = @e.keys
    @keys.sort!
  end

  def size
    @keys.size
  end

  def number(name)
    @keys.index(name)
  end

  def name_at(i)
    @keys[i]
  end

  def weight_at(i)
    @e[name_at(i)]["weight"]
  end
  
  def value_at(i)
    @e[name_at(i)]["value"]
  end
end

class Knapsack
  attr_accessor :contains

  def initialize(max_weight)
    @score = nil
    @max_weight = max_weight

    @elements = Elements.new
    empty!
  end

  def self.new_value(max_weight,value)
    k = Knapsack.new(max_weight)
    k.contains = value
    k
  end

  def self.new_random(max_weight)
    k = Knapsack.new(max_weight)
    k.random!
    k
  end

  def score
    return @score if ! @score.nil?

    s = value
    if weight > @max_weight
      s -= (weight - @max_weight) * 50
    end
    s
  end

  def random!
    @score = nil
    @contains = ''
    @elements.size.times do
      r = Random.rand(10)
      if r == 0
        @contains = @contains + '1'
      else
        @contains = @contains + '0'
      end
    end
  end

  def empty!
    @score = nil
    @contains = ''.rjust(@elements.size, '0')
  end

  def set(i)
    @score = nil
    @contains[i] = '1'
  end
  
  def clear(i)
    @score = nil
    @contains[i] = '0'
  end
  
  def toggle(i)
    @score = nil
    @contains[i] = @contains[i] == '0' ? '1' : '0'
  end

  def add(name)
    @score = nil
    set(@elements.number(name))
  end
  
  def remove(name)
    @score = nil
    clear(@elements.number(name))
  end

  def mutate
    r = Random.rand(@contains.length)
    toggle(r)
  end

  def mate_with(other)
    pivot = Random.rand(@contains.length)

    c1 = @contains[0...pivot] + other.contains[pivot...@contains.length]
    c2 = other.contains[0...pivot] + @contains[pivot...@contains.length]
    [c1,c2]
  end

  def weight
    w = 0
    (0...@elements.size).each do |i|
      if @contains[i] == '1'
        w += @elements.weight_at(i)
      end
    end
    w
  end

  def value
    v = 0
    (0...@elements.size).each do |i|
      if @contains[i] == '1'
        v += @elements.value_at(i)
      end
    end
    v
  end

  def display
    printed = false
    print "Contains:\n  "
    line = 0
    (0...@elements.size).each do |i|
      if @contains[i] == '1'
        printed = true
        print "#{@elements.name_at(i)}, "
        line += 1
        if line > 6
          line = 0
          print "\n  "
        end
      end
    end
    puts "Nothing" if ! printed
    puts
    print_summary
  end

  def print_summary
    puts "Weight: #{weight} Value: #{value} Score: #{score}"
  end

  def to_s
    @contains
  end
end

class Population
  def initialize(weight,size,options = {})
    options[:elitism_pct] ||= 0.2
    @elitism_pct = options[:elitism_pct];
    @chromosomes = []
    @weight = weight
    @size = size
    fill_with_random!
  end

  def fill_with_random!
    s = @chromosomes.length
    (@size - s).times { @chromosomes.push(Knapsack.new_random(@weight)) }
  end

  def get(i)
    @chromosomes[i]
  end

  def sort!
    @chromosomes.sort_by! { |a| 0 - a.score }
  end

  def print_all
    @chromosomes.each_with_index { |c,i| print_one(c,i) }
  end

  def print_one(c,i)
    c = @chromosomes[i] if c.nil?
    puts "%02d #{c.contains} %8d (%5d/%5d)" % [i,c.score,c.weight,c.value]
  end

  def kill!
    threshold = (@elitism_pct * @chromosomes.length).floor
    @chromosomes.pop while @chromosomes.length > threshold
  end

  def mate!
    c1 = Random.rand(@chromosomes.length)
    c2 = c1
    c2 = Random.rand(@chromosomes.length) while c2 == c1

    cc1,cc2 = @chromosomes[c1].mate_with(@chromosomes[c2])
    @chromosomes.push(Knapsack.new_value(@weight,cc1))
    @chromosomes.push(Knapsack.new_value(@weight,cc2))
  end

  def generation
    sort!
    kill!
    mate!
    fill_with_random!
    sort!
  end
end

p = Population.new(1000,20)

1000.times do |i|
  print "%5d  " % i
  p.sort!
  p.print_one(nil,0)
  p.generation
end

puts "Final Solution:"
p.print_one(nil,0)
    p.get(0).display