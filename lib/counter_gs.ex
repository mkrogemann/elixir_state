defmodule CounterGS do
  use GenServer

  # Client API

  def inc(pid) do
    GenServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenServer.cast(pid, :dec)
  end

  def val(pid) do
    GenServer.call(pid, :val)
  end

  def stop(pid) do
    GenServer.stop(pid, :normal)
  end

  def start_link(initial_value \\ 0) do
    GenServer.start_link(__MODULE__, initial_value, name: :counter)
  end

  # Callbacks

  def init(initial_value) do
    {:ok, initial_value}
  end

  def handle_cast(:inc, val) do
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do
    {:reply, val, val}
  end
end
