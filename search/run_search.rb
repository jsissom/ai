require_relative 'search'

def run
  # Build data structure
  data = Hash.new
  data[:a] = [:b,:s]
  data[:b] = []
  data[:c] = [:d,:e,:f,:s]
  data[:d] = [:c]
  data[:e] = [:c,:h]
  data[:f] = [:c,:g]
  data[:g] = [:f,:h,:s]
  data[:h] = [:e,:g]
  data[:s] = [:a,:c,:g]

  # Method to call for each element
  visit = Proc.new do |key|
    puts "Visited: " + key.to_s
  end

  # Search
  puts "Depth First Search";
  Search.depthFirstSearch(data,:a,visit)

  puts "Breadth First Search";
  Search.breadthFirstSearch(data,:a,visit)
end

# Depth first: A B S C D E H G F
# Breadth first: A B S C G D E F H
run
