defmodule MessagesTest do
  use ExUnit.Case

  test "intro_message welcomes the user to tic tac toe" do
    assert Regex.match?(~r/welcome/i, Messages.game_introduction)
  end

  test "game_configuration_description describes game setup" do
    assert Regex.match?(~r/X/, Messages.game_configuration_description)
    assert Regex.match?(~r/O/, Messages.game_configuration_description)
  end

  test "game_starting_notification notifies the user game is about to begin" do
    assert Regex.match?(~r/Here we go!/i, Messages.game_starting_notification)
  end

  test "ai_move_notification notifies the user AI player is moving" do
    assert Regex.match?(~r/AI/, Messages.ai_move_notification)
  end

  test "move_request prompts the user for a move" do
    assert Regex.match?(~r/move/i, Messages.move_request)
  end

  test "invalid_move_notification notifies user input is not valid" do
    assert Regex.match?(~r/invalid/i, Messages.invalid_move_notification)
  end

  test "player_win_notification notifies user the passed player has won" do
    assert Regex.match?(~r/X wins/i, Messages.player_win_notification("X"))
  end

  test "tie_game_notification notifies user of a tie game" do
    assert Regex.match?(~r/tie game/i, Messages.tie_game_notification)
  end

  test "play_again_offer prompts the user to select whether to play again" do
    assert Regex.match?(~r/again?/i, Messages.play_again_offer)
  end

  test "goodbye bids farewell to the user" do
    assert Regex.match?(~r/goodbye/i, Messages.goodbye)
  end
end
