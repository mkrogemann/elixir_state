defmodule CounterGSTest do
  use ExUnit.Case

  setup _context do
    {:ok, pid} = CounterGS.start_link
    {:ok, [pid: pid]}
  end

  test "val/1 should return initial state of zero", context do
    assert CounterGS.val(context[:pid]) == 0
  end

  test "inc/1 should increment initial state by one", context do
    CounterGS.inc(context[:pid])
    assert CounterGS.val(context[:pid]) == 1
  end

  test "dec/1 should decrement initial state by zero", context do
    CounterGS.dec(context[:pid])
    assert CounterGS.val(context[:pid]) == -1
  end

  test "stop/1 should stop the server with reason :normal", context do
    :ok = CounterGS.stop(context[:pid]) # only :normal will yield :ok
    assert !Process.alive?(context[:pid])
  end
end
