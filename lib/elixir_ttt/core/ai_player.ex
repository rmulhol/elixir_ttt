defmodule AIPlayer do
  def get_move(board, player) do
    opponent = opponent(board, player)
    best_move(board, player, opponent)
  end

  defp best_move(_, _, :no_opponent), do: 0
  defp best_move(board, player, opponent) do
    Enum.max_by(Board.empty_spaces(board), fn(move) ->
      board
      |> Board.place_move(move, player)
      |> minimax(player, opponent, false, 1)
    end)
  end

  defp minimax(board, player, opponent, _, 6) do
    score(board, player, opponent) / 6
  end

  defp minimax(board, player, opponent, my_turn?, depth) do
    cond do
      Rules.game_over?(board) -> score(board, player, opponent) / depth
      my_turn? -> maximize(board, player, opponent, depth)
      true -> minimize(board, player, opponent, depth)
    end
  end

  defp maximize(board, player, opponent, depth) do
    Enum.max(
      parallel_map(Board.empty_spaces(board), fn(move) ->
        board
        |> Board.place_move(move, player)
        |> minimax(player, opponent, false, depth + 1)
      end)
    )
  end

  defp minimize(board, player, opponent, depth) do
    Enum.min(
      parallel_map(Board.empty_spaces(board), fn(move) ->
        board
        |> Board.place_move(move, opponent)
        |> minimax(player, opponent, true, depth + 1)
      end)
    )
  end

  def opponent(board, player) do
    board
    |> Board.unique_tokens
    |> Enum.find(:no_opponent, fn(token) -> token !== player end)
  end

  def score(board, player, opponent) do
    cond do
      Rules.player_wins?(board, player) -> 10
      Rules.player_wins?(board, opponent) -> -10
      true -> 0
    end
  end

  def parallel_map(coll, fun) do
    coll
    |> Enum.map(&(Task.async(fn -> fun.(&1) end)))
    |> Enum.map(&Task.await/1)
  end
end
