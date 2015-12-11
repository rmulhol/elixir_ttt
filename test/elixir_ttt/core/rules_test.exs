defmodule RulesTest do
  use ExUnit.Case

  test "game isn't over for an empty board" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    refute Rules.game_over?(empty_board)
  end

  test "game isn't over for board with available spaces" do
    incomplete_board = TestHelper.setup_board(["X", " ", " ",
                                               " ", "O", " ",
                                               " ", " ", "X"])
    refute Rules.game_over?(incomplete_board)
  end

  test "game is over for board with no available spaces" do
    completed_board = TestHelper.setup_board(["X", "O", "X",
                                              "X", "O", "X",
                                              "O", "X", "O"])
    assert Rules.game_over?(completed_board)
  end

  test "game is over for player win" do
    won_board = TestHelper.setup_board(["X", "X", "X",
                                        "O", "O", " ",
                                        " ", " ", " "])
    assert Rules.game_over?(won_board)
  end

  test "player isn't winner on empty board" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    refute Rules.player_wins?(empty_board, "X")
  end

  test "player isn't winner on tie game board" do
    tie_game_board = TestHelper.setup_board(["X", "O", "X",
                                             "X", "O", "X",
                                             "O", "X", "O"])
    refute Rules.player_wins?(tie_game_board, "X")
    refute Rules.player_wins?(tie_game_board, "O")
  end

  test "player isn't winner on lost board" do
    lost_board = TestHelper.setup_board(["X", "X", "X",
                                         "O", "O", " ",
                                         " ", " ", " "])
    refute Rules.player_wins?(lost_board, "O")
  end

  test "player is winner on won board" do
    won_board = TestHelper.setup_board(["X", "X", "X",
                                        "O", "O", " ",
                                        " ", " ", " "])
    assert Rules.player_wins?(won_board, "X")
  end

  test "game not won on empty board" do
    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    refute Rules.game_won?(empty_board)
  end

  test "game not won on tie game board" do
    tie_game_board = TestHelper.setup_board(["X", "O", "X",
                                             "X", "O", "X",
                                             "O", "X", "O"])
    refute Rules.game_won?(tie_game_board)
  end

  test "game won with player 'X' win" do
    won_board = TestHelper.setup_board(["X", "X", "X",
                                        "O", "O", " ",
                                        " ", " ", " "])
    assert Rules.game_won?(won_board)
  end

  test "game won with player 'O' win" do
    won_board = TestHelper.setup_board(["X", "X", " ",
                                        "O", "O", "O",
                                        " ", " ", " "])
    assert Rules.game_won?(won_board)
  end
end
