defmodule FileStatx.MixProject do
  use Mix.Project

  @version "1.0.1"

  def project do
    [
      app: :file_statx,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      package: package(),
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

  defp package do
    [
      files: [
        "lib",
        "native",
        "checksum-*.exs",
        "mix.exs",
        "README.md",
        "LICENSE"
      ],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/spicychickensauce/file_statx"
      },
      maintainers: ["spicychickensauce"]
    ]
  end
end
