defmodule FileStatx do
  version = Mix.Project.config()[:version]
  env_config = Application.compile_env(:rustler_precompiled, :force_build, [])

  @external_resource "README.md"
  @moduledoc File.read!("README.md")

  use RustlerPrecompiled,
    otp_app: :file_statx,
    crate: :filestatx,
    base_url: "https://github.com/spicychickensauce/file_statx/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_BUILD") in ["1", "true"] or env_config[:file_statx],
    version: version

  @doc """
  All timestamps are in nanoseconds since unix epoch.
  They can be converted to datetime via e.g: `DateTime.from_unix(stat.ctime, :nanosecond)`
  """
  @type t() :: %FileStatx{
          atime: integer() | :undefined,
          ctime: integer() | :undefined,
          mtime: integer() | :undefined,
          mode: non_neg_integer() | :undefined,
          size: non_neg_integer() | :undefined,
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
