class SearchQueue
  def initialize
    @queue = []
  end

  def empty?
    @queue.empty?
  end

  # Stack
  def push(data)
    @queue.push(data)
  end

  def pop
    @queue.pop
  end

  # Queue
  def enq(data)
    @queue.push(data)
  end

  def deq
    @queue.shift
  end
end

class AstarSearch
  def initialize(cities,roads)
    @explored = []
    @queue = SearchQueue.new

    @cities = cities
    @roads = roads
  end

  def astar_search(from,destination)
    @queue.enq([from])
    begin
      current_path = @queue.deq
      last_node = current_path[-1]

      @explored.push(last_node)

      if destination == last_node
        return current_path
      end

      neighbors = neighbors(last_node,destination)
      neighbors.each do |node|
        @queue.enq(current_path + Array(node)) if ! @explored.include?(node)
      end
    end while ! @queue.empty?
    return []
  end

  private
    # Get all neighbors to a city in order of distance to destination
    def neighbors(node,destination)
      nodes = []
      roads = roads(node)
      roads.each { |r| nodes << (r.end1 == node ? r.end2 : r.end1) }

      nodes.sort! { |a,b| distance(a,destination) <=> distance(b,destination) }
    end

    # Retrieve roads from city
    def roads(city)
      @roads.select { |r| (r.end1 == city) || (r.end2 == city) }
    end

    # Retrieve city object from list
    def city(city)
      x = @cities.select { |c| c.city == city }
      x[0]
    end

    # Determine distance in km
    def distance(from_city,to_city)
      f = city(from_city)
      t = city(to_city)

      # r in km
      r = 6371
      dLat = to_rad(t.lat - f.lat)
      dLon = to_rad(t.long - f.long)
      lat1 = to_rad(f.lat)
      lat2 = to_rad(t.lat)

      a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      r * c;
    end

    def to_rad(a)
      a * Math::PI / 180
    end
end
