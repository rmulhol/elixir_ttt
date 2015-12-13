defmodule AIPlayerTest do
  use ExUnit.Case

  test "defaults to 0" do
    #   _ _ _
    #   _ _ _
    #   _ _ _

    empty_board = TestHelper.setup_board([" ", " ", " ",
                                          " ", " ", " ",
                                          " ", " ", " "])
    assert AIPlayer.get_move(empty_board, "X") === 0
  end

  test "takes the center if available when moving second" do
    #   O _ _
    #   _ _ _
    #   _ _ _

    one_move_board = TestHelper.setup_board(["O", " ", " ",
                                             " ", " ", " ",
                                             " ", " ", " "])
    assert AIPlayer.get_move(one_move_board, "X") === 4
  end

  test "claims a win" do
    #   X X _
    #   O O _
    #   _ _ _

    win_opportunity_board = TestHelper.setup_board(["O", "O", " ",
                                                    "X", "X", " ",
                                                    " ", " ", " "])
    assert AIPlayer.get_move(win_opportunity_board, "X") === 5
  end

  test "blocks a loss" do
    #   _ X _
    #   O O _
    #   _ _ X

    loss_opportunity_board = TestHelper.setup_board([" ", "X", " ",
                                                     "O", "O", " ",
                                                     " ", " ", "X"])
    assert AIPlayer.get_move(loss_opportunity_board, "X") === 5
  end

  test "blocks a fork" do
    #   O _ _
    #   _ X _
    #   _ _ O

    fork_opportunity_board = TestHelper.setup_board(["O", " ", " ",
                                                     " ", "X", " ",
                                                     " ", " ", "O"])
    fork_blocking_moves = [1, 3, 5, 7]
    assert AIPlayer.get_move(fork_opportunity_board, "X") in fork_blocking_moves
  end

  test "takes a quick win even if win inevitable" do
    #   X O _
    #   _ X O
    #   _ _ _

    inevitable_win_board = TestHelper.setup_board(["X", "O", " ",
                                                   " ", "X", "O",
                                                   " ", " ", " "])
    assert AIPlayer.get_move(inevitable_win_board, "X") === 8
  end

  test "prolongs game even if loss is inevitable" do
    #   _ X O
    #   _ O _
    #   _ _ _

    inevitable_loss_board = TestHelper.setup_board([" ", "X", "O",
                                                    " ", "O", " ",
                                                    " ", " ", " "])
    assert AIPlayer.get_move(inevitable_loss_board, "X") === 6
  end

  test "returns opponent token if opponent on board" do
    board_with_opponent = TestHelper.setup_board(["O", " ", " ",
                                                  " ", " ", " ",
                                                  " ", " ", " "])
    assert AIPlayer.opponent(board_with_opponent, "X") === "O"
  end

  test "returns :no_opponent if no opponent on board" do
    board_without_opponent = TestHelper.setup_board([" ", " ", " ",
                                                     " ", " ", " ",
                                                     " ", " ", " "])
    assert AIPlayer.opponent(board_without_opponent, "X") === :no_opponent
  end

  test "scores 10 if player wins" do
    board_with_win = TestHelper.setup_board(["X", "X", "X",
                                             "O", "O", " ",
                                             " ", " ", " "])
    assert AIPlayer.score(board_with_win, "X", "O") === 10
  end

  test "scores -10 if opponent wins" do
    board_with_loss = TestHelper.setup_board(["X", "X", " ",
                                              "O", "O", "O",
                                              " ", " ", " "])
    assert AIPlayer.score(board_with_loss, "X", "O") === -10
  end

  test "scores 0 if no winner on board" do
    board_without_win = TestHelper.setup_board([" ", " ", " ",
                                                " ", " ", " ",
                                                " ", " ", " "])
    assert AIPlayer.score(board_without_win, "X", "O") === 0
  end

  test "parallel_map maps a collection" do
    fake_coll = [1, 2, 3, 4, 5]
    fake_fn = fn(n) -> n * 2 end
    assert AIPlayer.parallel_map(fake_coll, fake_fn) === Enum.map(fake_coll, fake_fn)
  end
end
