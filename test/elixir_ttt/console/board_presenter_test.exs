defmodule BoardPresenterTest do
  use ExUnit.Case

  test "builds string representation of an empty 3x3 board" do
    board_3x3 = TestHelper.setup_board([" ", " ", " ",
                                        " ", " ", " ",
                                        " ", " ", " "])
    expected_presentation = "   |   |   \n" <>
                            "-----------\n" <>
                            "   |   |   \n" <>
                            "-----------\n" <>
                            "   |   |   \n"
    assert BoardPresenter.present(board_3x3) === expected_presentation
  end

  test "builds string representation of a 3x3 board with moves" do
    board_3x3 = TestHelper.setup_board(["X", "O", " ",
                                        " ", "O", " ",
                                        " ", " ", "X"])
    expected_presentation = " X | O |   \n" <>
                            "-----------\n" <>
                            "   | O |   \n" <>
                            "-----------\n" <>
                            "   |   | X \n"
    assert BoardPresenter.present(board_3x3) === expected_presentation
  end

  test "builds string representation of an empty 4x4 board" do
    board_4x4 = TestHelper.setup_board([" ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " "])
    expected_presentation = "   |   |   |   \n" <>
                            "---------------\n" <>
                            "   |   |   |   \n" <>
                            "---------------\n" <>
                            "   |   |   |   \n" <>
                            "---------------\n" <>
                            "   |   |   |   \n"
    assert BoardPresenter.present(board_4x4) === expected_presentation
  end

  test "build string representation of a 4x4 board with moves" do
    board_4x4 = TestHelper.setup_board(["X", " ", " ", "O",
                                        " ", "X", "O", " ",
                                        " ", "X", "O", " ",
                                        "X", " ", " ", "O"])
    expected_presentation = " X |   |   | O \n" <>
                            "---------------\n" <>
                            "   | X | O |   \n" <>
                            "---------------\n" <>
                            "   | X | O |   \n" <>
                            "---------------\n" <>
                            " X |   |   | O \n"
    assert BoardPresenter.present(board_4x4) === expected_presentation
  end

  test "builds a 3x3 row" do
    row_3x3 = ["X", "O", " "]
    expected_presentation = " X | O |   "
    assert BoardPresenter.present_row(row_3x3) === expected_presentation
  end

  test "builds a 4x4 row" do
    row_4x4 = ["X", "O", " ", "X"]
    expected_presentation = " X | O |   | X "
    assert BoardPresenter.present_row(row_4x4) === expected_presentation
  end

  test "builds a line separator for a 3x3 board" do
    rows_3x3 = Board.create(3) |> Board.rows
    expected_presentation = "\n-----------\n"
    assert BoardPresenter.line_separator(rows_3x3) === expected_presentation
  end

  test "builds a line separator for a 4x4 board" do
    rows_4x4 = Board.create(4) |> Board.rows
    expected_presentation = "\n---------------\n"
    assert BoardPresenter.line_separator(rows_4x4) === expected_presentation
  end
end
