defmodule AIPlayer do
  def get_move(board, player) do
    case opponent(board, player) do
      :no_opponent -> 0
      opponent -> best_move(board, player, opponent)
    end
  end

  def best_move(board, player, opponent) do
    Enum.max_by(Board.empty_spaces(board), fn(move) ->
      Board.place_move(board, move, player)
      |> minimax(player, opponent, false, 1)
    end)
  end

  def minimax(board, player, opponent, my_turn?, depth) do
    cond do
      Rules.game_over?(board) -> score(board, player, opponent) / depth
      my_turn? -> maximize(board, player, opponent, my_turn?, depth)
      true -> minimize(board, player, opponent, my_turn?, depth)
    end
  end

  def maximize(board, player, opponent, my_turn?, depth) do
    Enum.max(
      Enum.map(Board.empty_spaces(board), fn(move) ->
        Board.place_move(board, move, player)
        |> minimax(player, opponent, !my_turn?, depth + 1)
      end)
    )
  end

  def minimize(board, player, opponent, my_turn?, depth) do
    Enum.min(
      Enum.map(Board.empty_spaces(board), fn(move) ->
        Board.place_move(board, move, opponent)
        |> minimax(player, opponent, !my_turn?, depth + 1)
      end)
    )
  end

  def opponent(board, player) do
    Enum.uniq(board)
    |> Enum.filter(fn(cell) -> cell !== " " end)
    |> Enum.find(:no_opponent, fn(cell) -> cell !== player end)
  end

  def score(board, player, opponent) do
    cond do
      Rules.player_wins?(board, player) -> 10
      Rules.player_wins?(board, opponent) -> -10
      true -> 0
    end
  end
end
