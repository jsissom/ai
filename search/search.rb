class SearchQueue
  def initialize
    @queue = []
  end

  def enq(data)
    @queue.push(data)
  end
  
  def deq
    @queue.shift
  end

  def empty?
    @queue.empty?
  end
end

class Search
  def self.depthFirstSearch(data,start,visit)
    s = Search.new(data,start,visit)
    s.dfs(start)
  end

  def self.breadthFirstSearch(data,start,visit)
    s = Search.new(data,start,visit)
    s.bfs(start)
  end

  def initialize(data,start,visit)
    @data = data
    @start = start
    @visit = visit
    @visited = []
    @queue = SearchQueue.new
    @current = nil;
  end

  def bfs(start)
    visit(start)
    @queue.enq(start)

    while ! @queue.empty? do
      current = @queue.deq
      process(current)
    end
  end

  def dfs(current)
    visit(current)

    # Get the paths and search all the non-visited elements
    @data[current].each do |child|
      dfs(child) unless @visited.include?(child)
    end
  end

  private
    def process(current)
      # Get the paths and queue all the non-visited elements
      @data[current].each do |child|
        unless @visited.include?(child)
          visit(child)
          @queue.enq(child)
        end
      end
    end

    # mark it visited, call the visit method
    def visit(item)
      @visited << item
      @visit.call(item)
    end    
end
