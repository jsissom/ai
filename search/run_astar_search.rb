require_relative "astar_search"

class City
  attr_accessor :city,:lat,:long

  def initialize(city,lat,long)
    @city = city
    @lat = lat
    @long = long
  end
end

class Road
  attr_accessor :end1,:end2,:length

  def initialize(end1,end2,length)
    @end1 = end1
    @end2 = end2
    @length = length
  end
end

def test_cities
  l = []
  l << City.new(:Oradea,47.072,21.921)
  l << City.new(:Zerind,46.622,21.517)
  l << City.new(:Arad,46.166,21.316)
  l << City.new(:Sibu,45.787,24.143)
  l << City.new(:Faragas,45.843,24.978)
  l << City.new(:Neamt,46.919,26.356)
  l << City.new(:Iasi,47.157,27.59)
  l << City.new(:Vaslui,46.638,27.729)
  l << City.new(:Timisoara,45.755,21.237)
  l << City.new(:Lugoj,45.686,21.9)
  l << City.new(:Mehadia,44.906,22.36)
  l << City.new(:Dobreta,44.635,22.66)
  l << City.new(:Craiova,44.325,23.813)
  l << City.new(:Pitesti,44.86,24.868)
  l << City.new(:Bucharest,44.432,26.104)
  l << City.new(:Giurgiu,43.9,25.971)
  l << City.new(:Urziceni,44.718,26.645)
  l << City.new(:Hirsova,44.725,22.396)
  l << City.new(:Etorie,44.066,28.633)
  l << City.new(:RimnicuVilcea,45.105,24.376)
end

def test_roads
  l = []
  l << Road.new(:Oradea,:Zerind,71)
  l << Road.new(:Zerind,:Arad,75)
  l << Road.new(:Arad,:Timisoara,118)
  l << Road.new(:Timisoara,:Lugoj,111)
  l << Road.new(:Lugoj,:Mehadia,70)
  l << Road.new(:Mehadia,:Dobreta,75)
  l << Road.new(:Dobreta,:Craiova,120)
  l << Road.new(:Craiova,:Pitesti,138)
  l << Road.new(:Craiova,:RimnicuVilcea,145)
  l << Road.new(:Oradea,:Sibu,151)
  l << Road.new(:Arad,:Sibu,140)
  l << Road.new(:Sibu,:Faragas,99)
  l << Road.new(:Sibu,:RimnicuVilcea,80)
  l << Road.new(:RimnicuVilcea,:Pitesti,97)
  l << Road.new(:Faragas,:Bucharest,211)
  l << Road.new(:Pitesti,:Bucharest,101)
  l << Road.new(:Bucharest,:Giurgiu,90)
  l << Road.new(:Bucharest,:Urziceni,85)
  l << Road.new(:Urziceni,:Hirsova,98)
  l << Road.new(:Hirsova,:Etorie,86)
  l << Road.new(:Urziceni,:Vaslui,142)
  l << Road.new(:Vaslui,:Iasi,92)
  l << Road.new(:Iasi,:Neamt,87)
end

a = AstarSearch.new(test_cities,test_roads)

p = a.astar_search(:Arad,:Bucharest)
p p

