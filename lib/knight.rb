require_relative "vertex"

def initialise_knight_graph
  #8x8 vertex array
  knight_graph = Array.new(8) do |row_index|
    Array.new(8) do |col_index|
      Vertex.new([row_index, col_index])
    end
  end

  #connect the vertices according to knight moves
  knight_graph.each_with_index do |row, row_index|
    row.each_with_index do |vertex, col_index|
      [2,1,-1,-2].each do |i|
        j = (i.abs == 2 ? 1 : 2)
        if row_index + i > 0
          if col_index + j > 0
            Vertex
              .connect(vertex, knight_graph.dig(row_index+i, col_index+j))
          end
          if col_index - j > 0
            Vertex
              .connect(vertex, knight_graph.dig(row_index+i, col_index-j))
          end
        end
      end
    end
  end

  knight_graph
end


def knight_moves(start, finish)
  knight_graph = initialise_knight_graph()

  start_vertex = knight_graph.dig(*start)
  queue = [] << ([] << start_vertex)
  finish_vertex = knight_graph.dig(*finish)
  shortest_path = calculate_moves(queue, finish_vertex, [start_vertex])

  puts "It would take #{shortest_path.length - 1} moves to get there:"
  shortest_path.each{ |vertex| p vertex.value }
end

def calculate_moves(queue, b, history=[])
  until queue.size == 0
    path = queue.shift
    return path if path[-1].value == b.value

    path[-1].adjacent.each do |vertex|
      unless history.include?(vertex)
        queue << path + [vertex]
        history << vertex
      end
    end
  end

  []
end
