defmodule BoardTest do
  use ExUnit.Case

  test "creates an empty 3x3 board" do
    board_3x3 = TestHelper.setup_board([" ", " ", " ",
                                        " ", " ", " ",
                                        " ", " ", " "])
    assert Board.create(3) === board_3x3
  end

  test "creates an empty 4x4 board" do
    board_4x4 = TestHelper.setup_board([" ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " "])
    assert Board.create(4) === board_4x4
  end


  test "places a move on an empty board" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    board_with_move = TestHelper.setup_board(["X", " ", " ",
                                              " ", " ", " ",
                                              " ", " ", " "])
    assert Board.place_move(empty_board, 0, "X") === board_with_move
  end

  test "places a move on a board with moves" do
    board_with_moves = TestHelper.setup_board(["X", "O", " ",
                                               " ", " ", " ",
                                               " ", " ", " "])
    expected_board = TestHelper.setup_board(["X", "O", "X",
                                                      " ", " ", " ",
                                                      " ", " ", " "])
    actual_board = Board.place_move(board_with_moves, 2, "X")
    assert actual_board === expected_board
  end

  test "empty_spaces returns indexes of all spaces on empty board" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])

    all_spaces = [0, 1, 2, 3, 4, 5, 6, 7, 8]

    assert Board.empty_spaces(empty_board) === all_spaces
  end

  test "empty_spaces returns indexes of open spaces on board with moves" do
    board_with_moves = TestHelper.setup_board(["X", "O", " ",
                                               " ", " ", " ",
                                               " ", " ", " "])

    empty_spaces = [2, 3, 4, 5, 6, 7, 8]

    assert Board.empty_spaces(board_with_moves) === empty_spaces
  end

  test "space_empty? returns true for unclaimed space" do
    board_with_moves = TestHelper.setup_board(["X", "O", " ",
                                               " ", " ", " ",
                                               " ", " ", " "])
    assert Board.space_empty?(board_with_moves, 2)
  end

  test "space_empty? returns false for claimed space" do
    board_with_moves = TestHelper.setup_board(["X", "O", " ",
                                               " ", " ", " ",
                                               " ", " ", " "])
    refute Board.space_empty?(board_with_moves, 1)
  end

  test "returns rows' contents for 3x3 board" do
    board_3x3 = TestHelper.setup_board(["A", "B", "C",
                                        "D", "E", "F",
                                        "G", "H", "I"])
    rows_3x3 = [["A", "B", "C"],
                ["D", "E", "F"],
                ["G", "H", "I"]]
    assert Board.rows(board_3x3) === rows_3x3
  end

  test "returns rows' contents for 4x4 board" do
    board_4x4 = TestHelper.setup_board(["A", "B", "C", "D",
                                        "E", "F", "G", "H",
                                        "I", "J", "K", "L",
                                        "M", "N", "O", "P"])
    rows_4x4 = [["A", "B", "C", "D"],
                ["E", "F", "G", "H"],
                ["I", "J", "K", "L"],
                ["M", "N", "O", "P"]]
    assert Board.rows(board_4x4) === rows_4x4
  end

  test "returns columns' contents for 3x3 board" do
    board_3x3 = TestHelper.setup_board(["A", "B", "C",
                                        "D", "E", "F",
                                        "G", "H", "I"])
    columns_3x3 = [["A", "D", "G"],
                   ["B", "E", "H"],
                   ["C", "F", "I"]]
    assert Board.columns(board_3x3) === columns_3x3
  end

  test "returns columns' contents for 4x4 board" do
    board_4x4 = TestHelper.setup_board(["A", "B", "C", "D",
                                        "E", "F", "G", "H",
                                        "I", "J", "K", "L",
                                        "M", "N", "O", "P"])
    columns_4x4 = [["A", "E", "I", "M"],
                   ["B", "F", "J", "N"],
                   ["C", "G", "K", "O"],
                   ["D", "H", "L", "P"]]
    assert Board.columns(board_4x4) === columns_4x4
  end

  test "returns diagonals' contents for 3x3 board" do
    board_3x3 = TestHelper.setup_board(["A", "B", "C",
                                        "D", "E", "F",
                                        "G", "H", "I"])
    diagonals_3x3 = [["A", "E", "I"], ["C", "E", "G"]]
    assert Board.diagonals(board_3x3) === diagonals_3x3
  end

  test "returns diagonals' contents for 4x4 board" do
    board_4x4 = TestHelper.setup_board(["A", "B", "C", "D",
                                        "E", "F", "G", "H",
                                        "I", "J", "K", "L",
                                        "M", "N", "O", "P"])
    diagonals_4x4 = [["A", "F", "K", "P"], ["D", "G", "J", "M"]]
    assert Board.diagonals(board_4x4) === diagonals_4x4
  end

  test "returns the side length for a 3x3 board" do
    board_3x3 = TestHelper.setup_board([" ", " ", " ",
                                        " ", " ", " ",
                                        " ", " ", " "])
    assert Board.side_length(board_3x3) === 3
  end

  test "returns the side length for a 4x4 board" do
    board_4x4 = TestHelper.setup_board([" ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " "])
    assert Board.side_length(board_4x4) === 4
  end
end
