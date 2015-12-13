defmodule Messages do
  def game_introduction do
    crlf <> "Welcome to tic tac toe!" <> crlf
  end

  def game_configuration_description do
    "You're 'X' and the computer is 'O'. Each space corresponds to a " <>
    "number. When it's your turn, enter the number to claim the space." <> crlf
  end

  def game_starting_notification do
    "Get ready to play. Here we go!" <> crlf
  end

  def ai_move_notification do
    "AI player moving..."
  end

  def move_request do
    "Enter your move: "
  end

  def invalid_move_notification do
    "Invalid move. Try again."
  end

  def player_win_notification(token) do
    "#{token} wins!"
  end

  def tie_game_notification do
    "Tie game!"
  end

  def play_again_offer do
    "Would you like to play again?" <> crlf
  end

  def goodbye do
    "Goodbye!"
  end

  def crlf do
    "\n"
  end

  def space_separator do
    " | "
  end

  def dash do
    "-"
  end

  def space do
    " "
  end
end
