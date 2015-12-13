defmodule ConfigurationTest do
  use ExUnit.Case

  test "default returns tuple of 3x3 board with human and AI players" do
    default_board = Board.create(3)
    default_player_1 = {:human, "X"}
    default_player_2 = {:ai, "O"}
    default_configuration = {default_board, default_player_1, default_player_2}
    assert Configuration.default === default_configuration
  end
end
