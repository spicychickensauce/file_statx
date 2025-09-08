defmodule FileStat do
  use Rustler, otp_app: :file_stat, crate: :filestat

  defstruct type: :regular, ctime: nil, atime: nil, mtime: nil, size: 0, mode: 1

  def stat(_path), do: :erlang.nif_error(:nif_not_loaded)
end
