defmodule HumanPlayer do
  def get_move(board) do
    move = GamePresenter.solicit_move
    if invalid_move?(move, board) do
      GamePresenter.notify_invalid_move
      get_move(board)
    else
      to_int(move)
    end
  end

  def invalid_move?(move, board) do
    !(is_int?(move) and
    Board.space_empty?(board, to_int(move)))
  end

  def is_int?(move) do
    Regex.match?(~r/^[0-9]+\n$/, move)
  end

  def to_int(n) do
    n |> String.strip |> String.to_integer
  end
end
