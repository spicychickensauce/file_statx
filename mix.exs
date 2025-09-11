defmodule FileStatx.MixProject do
  use Mix.Project

  @version "1.0.1"
  @github_url "https://github.com/spicychickensauce/file_statx"

  def project do
    [
      app: :file_statx,
      version: @version,
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),

      # Docs
      name: "FileStatx",
      source_url: @github_url,
      docs: [
        main: "FileStatx",
        extras: ["README.md"]
      ]
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
      {:rustler_precompiled, "~> 0.8"},
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true}
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
      links: %{"GitHub" => @github_url},
      maintainers: ["spicychickensauce"]
    ]
  end
end
