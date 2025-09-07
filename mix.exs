defmodule FileStat.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_stat,
      version: "0.1.0",
      elixir: "~> 1.19-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.36.2", runtime: false}
    ]
  end
end
