defmodule ExIcal.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_ical,
      version: "0.1.0",
      elixir: "~> 1.2",
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
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:credo, "~> 0.5.0", only: :dev},
      {:timex, "~> 1.0"}
    ]
  end
end
