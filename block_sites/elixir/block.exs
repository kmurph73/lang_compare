#! /usr/bin/env elixir

filename = "/etc/hosts"

File.stream!(filename)
|> Stream.map(&String.trim_leading/1)
|> Stream.transform(false, fn line, blocked_sites_section ->
  if blocked_sites_section do
    line =
      if String.match?(line, ~r/^#+\s*127\.0\.0\.1/) do
        String.replace(line, ~r/^#+\s*/, "")
      else
        line
      end

    blocked_sites_section = !String.match?(line, ~r/blocked sites end/)

    {[line], blocked_sites_section}
  else
    blocked_sites_section = String.match?(line, ~r/blocked sites start/)

    {[line], blocked_sites_section}
  end
end)
|> Enum.to_list()
|> (fn list ->
      file = File.open!(filename, [:write])
      IO.write(file, list)
    end).()
