defmodule ExIcal.Mixfile do
  use Mix.Project

  def project do
    [app: :ex_ical,
      version: "0.0.3",
      elixir: "~> 1.2",
      description: "ICalendar parser.",
      package: package,
      deps: deps,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod
    ]
  end

  def package do
    [
      maintainers: ["Michał Kalbarczyk"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/fazibear/ex_ical"}
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:timex]]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:timex, "~> 1.0"}
    ]
  end
end
