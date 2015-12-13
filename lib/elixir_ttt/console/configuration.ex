defmodule Configuration do
  def default do
    {Board.create(3), {:human, "X"}, {:ai, "O"}}
  end
end
