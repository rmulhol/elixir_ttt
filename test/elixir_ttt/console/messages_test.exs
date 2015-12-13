defmodule MessagesTest do
  use ExUnit.Case

  def assert_includes(message, substring) do
    TestHelper.assert_includes(message, substring)
  end

  test "intro_message welcomes the user to tic tac toe" do
    assert_includes(Messages.game_introduction, "welcome")
  end

  test "game_configuration_description describes game setup" do
    configuration_description = Messages.game_configuration_description
    assert_includes(configuration_description, "'X'")
    assert_includes(configuration_description, "'O'")
  end

  test "game_starting_notification notifies the user game is about to begin" do
    assert_includes(Messages.game_starting_notification, "Here we go!")
  end

  test "ai_move_notification notifies the user AI player is moving" do
    assert_includes(Messages.ai_move_notification, "AI")
  end

  test "move_request prompts the user for a move" do
    assert_includes(Messages.move_request, "move")
  end

  test "invalid_move_notification notifies user input is not valid" do
    assert_includes(Messages.invalid_move_notification, "invalid")
  end

  test "player_win_notification notifies user the passed player has won" do
    assert_includes(Messages.player_win_notification("X"), "X wins")
  end

  test "tie_game_notification notifies user of a tie game" do
    assert_includes(Messages.tie_game_notification, "tie game")
  end

  test "play_again_offer prompts the user to select whether to play again" do
    assert_includes(Messages.play_again_offer, "again?")
  end

  test "goodbye bids farewell to the user" do
    assert_includes(Messages.goodbye, "goodbye")
  end
end
