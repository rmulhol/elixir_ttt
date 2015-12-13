ExUnit.start()

defmodule TestHelper do
  use ExUnit.Case

  def assert_includes(message, substring) do
    assert Regex.match?(~r/#{substring}/i, message)
  end

  def setup_board(passed_board) do
    board_length = Enum.count(passed_board)
    side_length = board_length |> :math.sqrt |> round
    new_board = Board.create(side_length)
    do_setup_board(passed_board, new_board, board_length, 0)
  end

  def do_setup_board(passed_board, new_board, board_length, current_index) do
    cond do
      current_index >= board_length -> new_board
      Enum.at(passed_board, current_index) === " " ->
        do_setup_board(passed_board, new_board, board_length, current_index + 1)
      true ->
        move_at_index = Enum.at(passed_board, current_index)
        updated_board = Board.place_move(new_board, current_index, move_at_index)
        do_setup_board(passed_board, updated_board, board_length, current_index + 1)
    end
  end
end
