defmodule FileStatx.MixProject do
  use Mix.Project

  def project do
    [
      app: :file_statx,
      version: "1.0.0",
      elixir: "~> 1.18",
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
      {:rustler, "~> 0.36.2", runtime: false, optional: true},
      {:rustler_precompiled, "~> 0.8"}
    ]
  end
end
