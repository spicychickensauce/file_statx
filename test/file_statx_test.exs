defmodule FileStatxTest do
  use ExUnit.Case
  doctest FileStatx

  test "stat" do
    {:ok, stat} =
      FileStatx.stat("./README.md")
      |> dbg()

    dbg(DateTime.from_unix(stat.ctime, :nanosecond))
  end
end
