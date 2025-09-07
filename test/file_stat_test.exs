defmodule FileStatTest do
  use ExUnit.Case
  doctest FileStat

  test "greets the world" do
    assert FileStat.hello() == :world
  end

  test "add" do
    assert FileStat.add(2, 3) == 5
  end
end
