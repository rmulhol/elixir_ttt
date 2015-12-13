defmodule Runner do
  def run do
    GamePresenter.introduce_game

    {board, player_1, player_2} = Configuration.default

    GamePresenter.describe_game_configuration
    GamePresenter.display_board_indexes(board)

    start_game({board, player_1, player_2})
  end

  def start_game({board, player_1, player_2}) do
    GamePresenter.notify_game_starting
    GamePresenter.display_board(board)
    game_loop({board, player_1, player_2})
  end

  def take_turn(board, {:human, token}) do
    move = HumanPlayer.get_move(board)
    Board.place_move(board, move, token)
  end

  def take_turn(board, {:ai, token}) do
    GamePresenter.notify_ai_move
    move = AIPlayer.get_move(board, token)
    Board.place_move(board, move, token)
  end

  def game_loop({board, player_1, player_2}) do
    if Rules.game_over?(board) do
      end_game_sequence(board)
    else
      updated_board = take_turn(board, player_1)
      GamePresenter.display_board(updated_board)
      game_loop({updated_board, player_2, player_1})
    end
  end

  def end_game_sequence(board) do
    GamePresenter.announce_result(board)
    if GamePresenter.play_again? do
      {board, player_1, player_2} = Configuration.default
      start_game({board, player_1, player_2})
    else
      GamePresenter.goodbye
    end
  end
end
