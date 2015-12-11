defmodule BoardPresenter do
  def present(board) do
    rows = Board.rows(board)
    Enum.map_join(rows, line_separator(rows), &present_row/1) <> "\n"
  end

  def present_row(row) do
    " " <> Enum.join(row, " | ") <> " "
  end

  def line_separator(rows) do
    num_rows = Enum.count(rows)
    num_dashes = num_rows * 3 + num_rows - 1
    "\n" <> String.duplicate("-", num_dashes) <> "\n"
  end
end
