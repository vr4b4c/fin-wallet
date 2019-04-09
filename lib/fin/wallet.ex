defmodule Wallet do
  defstruct [:uid, :transactions]

  def new(uid) do
    %Wallet{uid: uid, transactions: []}
  end

  def withdraw(wallet, amount) when amount > 0 do
    %{wallet | transactions: [-amount | wallet.transactions]}
  end

  def deposit(wallet, amount) when amount > 0 do
    %{wallet | transactions: [amount | wallet.transactions]}
  end

  def balance(wallet) do
    Enum.sum(wallet.transactions)
  end

  def transactions(wallet) do
    Enum.reverse(wallet.transactions)
  end
end
