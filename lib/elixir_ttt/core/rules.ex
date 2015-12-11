defmodule Rules do
  def game_over?(board) do
    no_empty_spaces?(board) or game_won?(board)
  end

  def player_wins?(board, player) do
    all_belong_to_this_player? = player_combination_matcher(player)
    Enum.any?(winning_combinations(board), all_belong_to_this_player?)
  end

  def game_won?(board) do
    Enum.any?(winning_combinations(board), &all_belong_to_one_player?/1)
  end

  defp winning_combinations(board) do
    Board.rows(board) ++ Board.columns(board) ++ Board.diagonals(board)
  end

  defp no_empty_spaces?(board) do
    Enum.empty?(Board.empty_spaces(board))
  end

  defp player_combination_matcher(player) do
    fn(combination) ->
      Enum.all?(combination, fn(cell) -> cell === player end)
    end
  end

  defp all_belong_to_one_player?(combination) do
    all_the_same?(combination) and none_empty?(combination)
  end

  defp all_the_same?(combination) do
    Enum.count(Enum.uniq(combination)) === 1
  end

  defp none_empty?(combination) do
    Enum.all?(combination, &not_empty?/1)
  end

  defp not_empty?(cell) do
    cell !== Board.empty_space
  end
end
