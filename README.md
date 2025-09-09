# FileStatx

Implements an alternative to `File.stat/1` via a rust NIF.

This version comes with correct file creation (birth) timestamps, which are not optainable via the standard library.
These timestamps are only available by using the `statx` syscall, which erlang doesn't implement yet.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `file_statx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:file_statx, "~> 1.0.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/file_statx>.
