defmodule FileStatx do
  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]
  env_config = Application.compile_env(:rustler_precompiled, :force_build, [])

  @external_resource "README.md"
  @moduledoc File.read!("README.md")

  use RustlerPrecompiled,
    otp_app: :file_statx,
    crate: :filestatx,
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_BUILD") in ["1", "true"] or env_config[:file_statx],
    version: version,
    targets: [
      "aarch64-apple-darwin",
      "aarch64-unknown-linux-gnu",
      "aarch64-unknown-linux-musl",
      "x86_64-apple-darwin",
      "x86_64-unknown-linux-gnu",
      "x86_64-unknown-linux-musl",
      "arm-unknown-linux-gnueabihf",
      "riscv64gc-unknown-linux-gnu"
    ]

  @doc """
  All timestamps are in nanoseconds since unix epoch.
  They can be converted to datetime via e.g: `DateTime.from_unix(stat.ctime, :nanosecond)`
  """
  @type t() :: %FileStatx{
          atime: integer() | nil,
          ctime: integer() | nil,
          mtime: integer() | nil,
          mode: non_neg_integer() | nil,
          size: non_neg_integer() | nil,
          type: :directory | :regular | :symlink
        }
  defstruct type: :regular, ctime: nil, atime: nil, mtime: nil, size: 0, mode: 1

  @doc """
  Returns information about the path. If it exists, it returns a `{:ok, info}` tuple,
  where info is a `FileStatx` struct. Returns `{:error, reason}` with the same reasons as `File.read/1` if a failure occurs.

  See the [rust docs](https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.created) on e.g.
  how the ctime timestamp is obtained on different platforms.
  """
  @spec stat(Path.t()) :: {:ok, FileStatx.t()} | {:error, :file.posix()}
  def stat(_path), do: :erlang.nif_error(:nif_not_loaded)
end
