[_, version] =
  File.read!("mix.exs")
  |> then(&Regex.run(~r/@version "(.*)"/, &1))

Mix.install([
  {:file_statx, path: "file_statx-#{version}"}
])

FileStatx.stat("README.md") |> dbg()
