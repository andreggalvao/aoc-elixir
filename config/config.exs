import Config

config :elixir, :time_zone_database, Tz.TimeZoneDatabase

config :advent_of_code, AdventOfCode.Input,
  allow_network?: true,
  session_cookie: "53616c7465645f5fbe4c0404f3cf7bb0590a4c3ccec6852b81e35bc958b51afb55a156887053f8497aeef8caf3729e22cf4ce88591b67abe1326bee8ecee252b"

try do
  import_config "secrets.exs"
rescue
  _ -> :ok
end
