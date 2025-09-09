defmodule FileStatxTest do
  use ExUnit.Case
  doctest FileStatx

  defmacrop assert_same_time(t1, t2) do
    quote do
      d1 = DateTime.from_unix!(unquote(t1))
      d2 = DateTime.from_unix!(unquote(t2), :nanosecond)
      assert DateTime.truncate(d1, :second) == DateTime.truncate(d2, :second)
    end
  end

  test "stat" do
    {:ok, statx} = FileStatx.stat("./README.md")
    {:ok, stat} = File.stat("./README.md", time: :posix)

    assert stat.type == statx.type
    assert stat.mode == statx.mode
    assert stat.size == statx.size
    assert_same_time(stat.atime, statx.atime)
    assert_same_time(stat.mtime, statx.mtime)

    # Ideally we could test somehow that statx.ctime is before stat.ctime,
    # but that test would fail after a git clone or on different platforms,
    # so we only test that it's before or equal.
    ctime1 = DateTime.from_unix!(stat.ctime)
    ctime2 = DateTime.from_unix!(statx.ctime, :nanosecond)
    assert DateTime.truncate(ctime2, :second) <= DateTime.truncate(ctime1, :second)

    # errors match
    stat_err = File.stat("doesnt_exist")
    assert ^stat_err = FileStatx.stat("doesnt_exist")
  end
end
