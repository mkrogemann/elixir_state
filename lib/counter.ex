defmodule Counter do

  # Client API

  def inc(pid) do
    send(pid, :inc)
    :ok
  end

  def dec(pid) do
    send(pid, :dec)
    :ok
  end

  def val(pid) do
    send(pid, {:val, self})
    receive do
      {:reply, val} -> val
    end
  end

  def start_link(initial_value \\ 0) do
    pid = spawn(__MODULE__, :loop, [initial_value])
    {:ok, pid}
  end

  def stop(pid) do
    Process.exit(pid, :shutdown)
  end

  # Server

  def loop(value) do
    receive do
      :inc -> loop(value + 1)
      :dec -> loop(value - 1)
      {:val, from} ->
        send(from, {:reply, value})
        loop(value)
    end
  end
end
