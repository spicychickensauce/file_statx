defmodule FileStatx do
  @external_resource "README.md"
  @moduledoc File.read!("README.md")

  use Rustler, otp_app: :file_statx, crate: :filestatx

  @doc """
  All timestamps are in nanoseconds since unix epoch.
  You can convert them to datetime via e.g: `DateTime.from_unix(stat.ctime, :nanosecond)`
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

   See the rust docs https://doc.rust-lang.org/std/fs/struct.Metadata.html#method.created
  """
  @spec stat(Path.t()) :: {:ok, FileStatx.t()} | {:error, :file.posix()}
  def stat(_path), do: :erlang.nif_error(:nif_not_loaded)
end
