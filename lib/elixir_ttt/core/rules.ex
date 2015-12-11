defmodule Rules do
  def game_over?(board) do
    Enum.empty?(Board.empty_spaces(board)) or
    game_won?(board)
  end

  def player_wins?(board, player) do
    Enum.any?(winning_combinations(board), fn(combo) ->
      Enum.all?(combo, fn(cell) -> cell === player end)
    end)
  end

  def game_won?(board) do
    Enum.any?(winning_combinations(board), fn(combo) ->
      Enum.count(Enum.uniq(combo)) === 1 and
      Enum.all?(combo, fn(cell) -> cell !== Board.empty_space end)
    end)
  end

  def winning_combinations(board) do
    Board.rows(board) ++ Board.columns(board) ++ Board.diagonals(board)
  end
end
