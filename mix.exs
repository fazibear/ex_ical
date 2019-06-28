defmodule ExIcal.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_ical,
      version: "0.2.0",
      elixir: "~> 1.4",
      description: "ICalendar parser.",
      package: package(),
      deps: deps(),
      dialyzer: [plt_add_deps: true],
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      docs: [
        main: ExIcal,
        source_url: "https://github.com/fazibear/export"
      ]
    ]
  end

  def package() do
    [
      maintainers: ["Michał Kalbarczyk"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/fazibear/ex_ical"}
   ]
  end

  def application() do
    [applications: [:timex]]
  end

  defp deps() do
    [
      {:ex_doc, "~> 0.20", only: :dev, runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:timex, "~> 3.6"}
    ]
  end
end
