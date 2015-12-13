defmodule HumanPlayerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "get_move returns the move chosen by the user" do
    board = TestHelper.setup_board([" ", " ", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])

    capture_io([input: "0\n", capture_prompt: false], fn ->
      assert HumanPlayer.get_move(board) === 0
    end)
  end

  test "get_move rejects non-numeric moves until valid move is entered" do
    board = TestHelper.setup_board([" ", " ", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])

    capture_io([input: "a\nb\n\n1\n", capture_prompt: false], fn ->
      assert HumanPlayer.get_move(board) === 1
    end)
  end

  test "get_move rejects claimed spaces until valid move is entered" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])

    capture_io([input: "0\n1\n2\n", capture_prompt: false], fn ->
      assert HumanPlayer.get_move(board) === 2
    end)
  end

  test "invalid_move? returns true for empty response" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("", board)
  end

  test "invalid_move? returns true for non-numeric input" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("hello!", board)
  end

  test "invalid_move? returns true for claimed space" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("0\n", board)
  end

  test "invalid_move? returns true if noise preceding valid input" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("asdsad4\n", board)
  end

  test "invalid_move? returns true if noise following valid input" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("4\nasfasfa", board)
  end

  test "invalid_move? returns true for backslash shenanigans" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("0\\n", board)
  end

  test "invalid_move? returns true for out-of-bounds index" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    assert HumanPlayer.invalid_move?("99\n", board)
  end

  test "invalid_move? returns false for input corresponding to unclaimed index" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    refute HumanPlayer.invalid_move?("4\n", board)
  end

  test "invalid_move? returns false for unclaimed index on bigger board" do
    big_board = TestHelper.setup_board(["X", "O", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " ",
                                        " ", " ", " ", " "])
    refute HumanPlayer.invalid_move?("13\n", big_board)
  end

  test "is_int? returns false for empty string" do
    refute HumanPlayer.is_int?("")
  end

  test "is_int? returns true for string integer with newline" do
    assert HumanPlayer.is_int?("1\n")
  end

  test "to_int converts a string representation of an integer to an integer" do
    assert HumanPlayer.to_int("1") === 1
  end

  test "to_int converts a string with a newline to an integer" do
    assert HumanPlayer.to_int("2\n") === 2
  end
end
