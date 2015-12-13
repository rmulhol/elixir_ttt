defmodule GamePresenter do
  def introduce_game do
    IO.puts Messages.game_introduction
  end

  def describe_game_configuration do
    IO.puts Messages.game_configuration_description
  end

  def notify_game_starting do
    IO.puts Messages.game_starting_notification
  end

  def notify_ai_move do
    IO.puts Messages.ai_move_notification
  end

  def solicit_move do
    IO.gets Messages.move_request
  end

  def notify_invalid_move do
    IO.puts Messages.invalid_move_notification
  end

  def display_board(board) do
    IO.puts BoardPresenter.present(board)
  end

  def display_board_indexes(empty_board) do
    board_indexes = Board.empty_spaces(empty_board)
    IO.puts BoardPresenter.present(board_indexes)
  end

  def announce_result(board) do
    case Enum.find(Board.unique_tokens(board), :no_winner, fn(token) ->
      Rules.player_wins?(board, token) end) do
        :no_winner -> IO.puts Messages.tie_game_notification
        winner -> IO.puts Messages.player_win_notification(winner)
      end
  end

  def play_again? do
    response = IO.gets Messages.play_again_offer
    affirmative_response?(response)
  end

  def goodbye do
    IO.puts Messages.goodbye
  end

  def affirmative_response?(response) do
    Regex.match?(~r/^y/i, response)
  end
end
