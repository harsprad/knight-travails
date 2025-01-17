class Vertex
  attr_accessor :value, :adjacent

  def initialize(coord)
    @value = coord
    @adjacent = []
  end

  def self.connect(vertex_1, vertex_2)
    return if vertex_1.nil? || vertex_2.nil?
    return if vertex_1.value == vertex_2.value

    vertex_1.adjacent << vertex_2
    vertex_2.adjacent << vertex_1
  end
end
