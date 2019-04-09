defmodule WalletServerTest do
  use ExUnit.Case, async: true

  test "creates start wallet without any transactions" do
    wallet = WalletServer.start("harry")

    assert WalletServer.transactions(wallet) == []
  end

  test "deposit creates positive transaction" do
    wallet_pid = WalletServer.start("harry")

    assert 10 == WalletServer.deposit(wallet_pid, 10)
    assert WalletServer.transactions(wallet_pid) == [10]
  end

  test "withdraw creates negative transaction" do
    wallet_pid = WalletServer.start("harry")

    assert -10 == WalletServer.withdraw(wallet_pid, 10)
    assert WalletServer.transactions(wallet_pid) == [-10]
  end

  test "calculates balance" do
    wallet_pid = WalletServer.start("harry")

    WalletServer.deposit(wallet_pid, 10)
    WalletServer.withdraw(wallet_pid, 5)

    assert WalletServer.balance(wallet_pid) == 5
  end

  test "tracks transactions" do
    wallet_pid = WalletServer.start("harry")

    WalletServer.deposit(wallet_pid, 10)
    WalletServer.withdraw(wallet_pid, 5)

    assert WalletServer.transactions(wallet_pid) == [10, -5]
  end
end
