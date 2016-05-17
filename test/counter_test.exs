defmodule CounterTest do
  use ExUnit.Case

  setup _context do
    {:ok, pid} = Counter.start_link
    {:ok, [pid: pid]}
  end

  test "val/1 should return initial state of zero", context do
    assert Counter.val(context[:pid]) == 0
  end

  test "inc/1 should increment initial state by one", context do
    Counter.inc(context[:pid])
    assert Counter.val(context[:pid]) == 1
  end

  test "dec/1 should decrement initial state by zero", context do
    Counter.dec(context[:pid])
    assert Counter.val(context[:pid]) == -1
  end

  test "stop/1 should stop the server with reason :shutdown", context do
    true = Counter.stop(context[:pid])
    assert !Process.alive?(context[:pid])
  end
end
