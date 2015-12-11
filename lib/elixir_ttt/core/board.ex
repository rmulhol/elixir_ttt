defmodule Board do
  def create(side_length) do
    Enum.take(Stream.cycle([" "]), side_length * side_length)
  end

  def place_move(board, index, token) do
    List.replace_at(board, index, token)
  end

  def empty_spaces(board) do
    for {" ", index} <- Enum.with_index(board), do: index
  end

  def space_empty?(board, space) do
    space in empty_spaces(board)
  end

  def rows(board) do
    Enum.chunk(board, side_length(board))
  end

  def columns(board) do
    transpose = fn
      ([[]|_], _) -> []
      (rows, fun) -> [Enum.map(rows, &hd/1)] ++ fun.(Enum.map(rows, &tl/1), fun)
    end

    transpose.(rows(board), transpose)
  end

  def diagonals(board) do
    diagonal = fn(board, start, increment) ->
      Enum.drop(board, start)
      |> Enum.take_every(increment)
      |> Enum.take(side_length(board))
    end

    negative_slope_diagonal = diagonal.(board, 0, side_length(board) + 1)
    positive_slope_diagonal = diagonal.(board, side_length(board) - 1, side_length(board) - 1)

    [negative_slope_diagonal, positive_slope_diagonal]
  end

  def side_length(board) do
    Enum.count(board)
    |> :math.sqrt
    |> round
  end
end
