# FileStatx

Implements an alternative to `File.stat/1` via a rust NIF.

This version comes with correct file creation (birth) timestamps, which are not optainable via the standard library.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `file_stat` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:file_stat, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/file_stat>.
