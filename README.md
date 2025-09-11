# FileStatx

Implements an alternative to `File.stat/1` via a rust NIF.

This version comes with correct file creation (birth) timestamps, which are not obtainable via the standard library.
These timestamps are only available by using the `statx` syscall, which erlang doesn't implement yet.

## Status

I'm using [Epoch SemVer](https://antfu.me/posts/epoch-semver).
So the API will only be considered stable when **v1_000** is released.
But in contrast to v0 versioning, I'm already commited to SemVer.

The prebuild binaries are only tested on `x86_64-unknown-linux-gnu`.
Other targets are not tested. Windows isn't supported at all.

## Installation

Add `file_statx` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:file_statx, "~> 1.0.1"}
  ]
end
```

Documentation: <https://hexdocs.pm/file_statx>

## Force compilation

This library includes pre-compiled binaries for the native Rust code. If you want to force-compile the Rust code, you can add the following configuration to your application:

`config :rustler_precompiled, :force_build, file_statx: true`

You also need to add `:rustler` to your dependencies.

## Release

- Bump all versions -> merge to main
- On Github: releases -> new -> tag: `v{$version}` -> publish
- Wait for artifacts to build
- Run `mix rustler_precompiled.download FileStatx --all --print`
- Publish to hex: `mix hex.publish`
