defmodule Board do
  def create(side_length) do
    Enum.take(Stream.cycle([empty_space]), side_length * side_length)
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
    transpose(rows(board))
  end

  def diagonals(board) do
    [negative_slope_diagonal(board), positive_slope_diagonal(board)]
  end

  def side_length(board) do
    board |> Enum.count |> :math.sqrt |> round
  end

  def empty_space do
    " "
  end

  defp transpose(rows), do: transpose(rows, [])
  defp transpose([[]|_], acc), do: Enum.reverse(acc)
  defp transpose(rows, acc) do
    transpose(Enum.map(rows, &tl/1), [Enum.map(rows, &hd/1) | acc])
  end

  defp negative_slope_diagonal(board) do
    start = 0
    increment = side_length(board) + 1
    diagonal(board, start, increment)
  end

  defp positive_slope_diagonal(board) do
    start = side_length(board) - 1
    increment = start
    diagonal(board, start, increment)
  end

  defp diagonal(board, start, increment) do
    board
    |> Enum.drop(start)
    |> Enum.take_every(increment)
    |> Enum.take(side_length(board))
  end
end
