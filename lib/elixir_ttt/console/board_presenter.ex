defmodule BoardPresenter do
  def present(board) do
    rows = Board.rows(board)
    Enum.map_join(rows, line_separator(rows), &present_row/1) <> crlf
  end

  defp present_row(row) do
    space <> Enum.join(row, " | ") <> space
  end

  defp line_separator(rows) do
    crlf <> String.duplicate("-", num_dashes(rows)) <> crlf
  end

  defp num_dashes(rows) do
    num_cells = Enum.count(rows)
    num_dashes_for_cells(num_cells) + num_dashes_for_boundaries(num_cells)
  end

  defp num_dashes_for_cells(num_cells) do
    num_dashes_per_cell = 3
    num_dashes_per_cell * num_cells
  end

  defp num_dashes_for_boundaries(num_cells) do
    num_cells - 1
  end

  defp space do
    " "
  end

  defp crlf do
    "\n"
  end
end
