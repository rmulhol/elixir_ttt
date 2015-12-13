defmodule GamePresenterTest do
  use ExUnit.Case
  import ExUnit.CaptureIO


  def assert_includes(message, substring) do
    TestHelper.assert_includes(message, substring)
  end

  test "introduce_game prints game introduction to stdio" do
    game_intro = capture_io(fn -> GamePresenter.introduce_game end)
    assert_includes(game_intro, "welcome")
  end

  test "describe_game_configuration prints description to stdio" do
    game_configuration_description = capture_io(fn ->
      GamePresenter.describe_game_configuration end)
    assert_includes(game_configuration_description, "'X'")
    assert_includes(game_configuration_description, "'O'")
  end

  test "notify_game_starting prints game starting notice to stdio" do
    game_starting_notice = capture_io(fn ->
      GamePresenter.notify_game_starting end)
    assert_includes(game_starting_notice, "Here we go!")
  end

  test "notify_ai_move prints ai move notice to stdio" do
    ai_move_notification = capture_io(fn -> GamePresenter.notify_ai_move end)
    assert_includes(ai_move_notification, "AI")
  end

  test "solicit_move prints move request to stdio" do
    move_request = capture_io(fn -> GamePresenter.solicit_move end)
    assert_includes(move_request, "move")
  end

  test "solicit_move returns input from the user" do
    capture_io([input: "hello"], fn ->
      assert GamePresenter.solicit_move === "hello" end)
  end

  test "notify_invalid_move prints invalid move notification to stdio" do
    invalid_move_notification = capture_io(fn ->
      GamePresenter.notify_invalid_move end)
    assert_includes(invalid_move_notification, "invalid move")
  end

  test "display_board prints the board presentation to stdio" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    expected_presentation = "   |   |   \n" <>
                            "-----------\n" <>
                            "   |   |   \n" <>
                            "-----------\n" <>
                            "   |   |   \n\n"
    presented_board = capture_io(fn ->
      GamePresenter.display_board(empty_board) end)
    assert expected_presentation === presented_board
  end

  test "display_board_indexes prints board with indexes to stdio" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    expected_presentation = " 0 | 1 | 2 \n" <>
                            "-----------\n" <>
                            " 3 | 4 | 5 \n" <>
                            "-----------\n" <>
                            " 6 | 7 | 8 \n\n"
    presented_board_indexes = capture_io(fn ->
      GamePresenter.display_board_indexes(empty_board) end)
    assert expected_presentation === presented_board_indexes
  end

  test "announce_result announces a win for 'X'" do
    x_win_board = TestHelper.setup_board(["X", "X", "X",
                                          "O", "O", " ",
                                          " ", " ", " "])
    result_announced = capture_io(fn ->
      GamePresenter.announce_result(x_win_board) end)
    assert_includes(result_announced, "X wins")
  end

  test "announce_result announces a win for 'O'" do
    o_win_board = TestHelper.setup_board(["O", " ", " ",
                                          "X", "O", "X",
                                          " ", " ", "O"])
    result_announced = capture_io(fn ->
      GamePresenter.announce_result(o_win_board) end)
    assert_includes(result_announced, "O wins")
  end

  test "announce_result announces a tie if no win" do
    tie_board = TestHelper.setup_board(["X", "O", "X",
                                        "X", "O", "X",
                                        "O", "X", "O"])
    result_announced = capture_io(fn ->
      GamePresenter.announce_result(tie_board) end)
    assert_includes(result_announced, "tie")
  end

  test "play_again? offers choice whether to play again" do
    play_again_offer = capture_io([input: "hello"], fn ->
      GamePresenter.play_again? end)
    assert_includes(play_again_offer, "again?")
  end

  test "play_again? returns true if user enters 'yes'" do
    capture_io([input: "yes"], fn ->
      assert GamePresenter.play_again? end)
  end

  test "play_again? returns true if user enters 'Y'" do
    capture_io([input: "Y"], fn ->
      assert GamePresenter.play_again? end)
  end

  test "play_again? returns false if user enters 'no'" do
    capture_io([input: "no"], fn ->
      refute GamePresenter.play_again? end)
  end

  test "goodbye prints farewell message to stdio" do
    farewell_message = capture_io(fn -> GamePresenter.goodbye end)
    assert_includes(farewell_message, "goodbye")
  end

  test "affirmative_response? returns false for 'no'" do
    refute GamePresenter.affirmative_response?("no")
  end

  test "affirmative_response? returns false for empty string" do
    refute GamePresenter.affirmative_response?("")
  end

  test "affirmative_response? returns true for 'y'" do
    assert GamePresenter.affirmative_response?("y")
  end

  test "affirmative_response? returns true for 'yes'" do
    assert GamePresenter.affirmative_response?("yes")
  end

  test "affirmative_response? returns true for 'YEAH'" do
    assert GamePresenter.affirmative_response?("YEAH")
  end

  test "affirmative_response? returns true when newline follows 'yes'" do
    assert GamePresenter.affirmative_response?("yes\n")
  end
end
