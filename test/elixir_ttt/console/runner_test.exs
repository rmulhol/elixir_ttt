defmodule RunnerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  def assert_includes(message, substring) do
    TestHelper.assert_includes(message, substring)
  end

  test "run allows a game where AI wins" do
    console_output = capture_io([input: "0\n1\n3\nno\n"], fn ->
      Runner.run end)

    assert_includes(console_output, "O wins")
  end

  test "run allows a tie game" do
    console_output = capture_io([input: "0\n8\n7\n2\n3\nno\n"], fn ->
      Runner.run end)

    assert_includes(console_output, "tie")
  end

  test "start_game ties if AI v AI" do
    board = TestHelper.setup_board([" ", " ", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    player_1 = {:ai, "X"}
    player_2 = {:ai, "O"}

    console_output = capture_io([input: "n\n"], fn ->
      Runner.start_game({board, player_1, player_2}) end)

    assert_includes(console_output, "tie")
  end

  test "take_turn returns a board with human move for human player" do
    board = TestHelper.setup_board([" ", " ", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    expected_board = TestHelper.setup_board(["X", " ", " ",
                                             " ", " ", " ",
                                             " ", " ", " "])
    human_player = {:human, "X"}

    capture_io([input: "0\n"], fn ->
      assert Runner.take_turn(board, human_player) === expected_board end)
  end

  test "take_turn returns a board with AI move for AI player" do
    board = TestHelper.setup_board([" ", " ", " ",
                                    " ", " ", " ",
                                    " ", " ", " "])
    expected_board = TestHelper.setup_board(["O", " ", " ",
                                             " ", " ", " ",
                                             " ", " ", " "])
    ai_player = {:ai, "O"}

    capture_io([input: "0\n"], fn ->
      assert Runner.take_turn(board, ai_player) === expected_board end)
  end

  test "end_game_sequence ends the game if user opts not to play again" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", "X", "O",
                                    " ", " ", "X"])
    conclusion = capture_io([input: "n\n"], fn ->
      Runner.end_game_sequence(board) end)
    refute Regex.match?(~r/tie/i, conclusion)
  end

  test "end_game_sequence plays another game if user opts to play again" do
    board = TestHelper.setup_board(["X", "O", " ",
                                    " ", "X", "O",
                                    " ", " ", "X"])
    conclusion = capture_io([input: "y\n0\n8\n7\n2\n3\nn\n"], fn ->
      Runner.end_game_sequence(board) end)
    assert_includes(conclusion, "tie")
  end
end
