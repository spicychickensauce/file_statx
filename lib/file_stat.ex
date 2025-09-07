defmodule FileStat do
  use Rustler, otp_app: :file_stat, crate: :filestat

  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)

  @moduledoc """
  Documentation for `FileStat`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FileStat.hello()
      :world

  """
  def hello do
    :world
  end
end
