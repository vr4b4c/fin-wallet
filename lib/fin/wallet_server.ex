defmodule WalletServer do
  def start(uid) do
    Server.start(__MODULE__, Wallet.new(uid))
  end

  def transactions(wallet_pid) do
    Server.call(wallet_pid, :transactions)
  end

  def deposit(wallet_pid, amount) do
    Server.call(wallet_pid, {:deposit, amount})
  end

  def withdraw(wallet_pid, amount) do
    Server.call(wallet_pid, {:withdraw, amount})
  end

  def balance(wallet_pid) do
    Server.call(wallet_pid, :balance)
  end

  def handle_command(:transactions, _caller_pid, wallet) do
    response = Wallet.transactions(wallet)

    {response, wallet}
  end

  def handle_command(:balance, _caller_pid, wallet) do
    response = Wallet.balance(wallet)

    {response, wallet}
  end

  def handle_command({:deposit, amount}, _caller_pid, wallet) do
    wallet = Wallet.deposit(wallet, amount)

    {Wallet.balance(wallet), wallet}
  end

  def handle_command({:withdraw, amount}, _caller_pid, wallet) do
    wallet = Wallet.withdraw(wallet, amount)

    {Wallet.balance(wallet), wallet}
  end
end
