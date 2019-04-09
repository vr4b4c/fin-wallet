defmodule WalletTest do
  use ExUnit.Case, async: true

  test "creates new wallet without any transactions" do
    wallet = Wallet.new("harry")

    assert Wallet.transactions(wallet) == []
  end

  test "deposit creates positive transaction" do
    wallet =
      "harry"
      |> Wallet.new()
      |> Wallet.deposit(10)

    assert Wallet.transactions(wallet) == [10]
  end

  test "withdraw creates negative transaction" do
    wallet =
      "harry"
      |> Wallet.new()
      |> Wallet.withdraw(10)

    assert Wallet.transactions(wallet) == [-10]
  end

  test "calculates balance" do
    wallet =
      "harry"
      |> Wallet.new()
      |> Wallet.deposit(10)
      |> Wallet.withdraw(5)

    assert Wallet.balance(wallet) == 5
  end

  test "tracks transactions" do
    wallet =
      "harry"
      |> Wallet.new()
      |> Wallet.deposit(10)
      |> Wallet.withdraw(5)

    assert Wallet.transactions(wallet) == [10, -5]
  end
end
