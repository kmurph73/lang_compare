#!/usr/bin/env ruby

hosts = '/etc/hosts'

lines = []

blocked_sites_section = false

File.open(hosts, 'r') do |f|
  while line = f.gets
    blocked_sites_section = true if line =~ /blocked\ssites/
    blocked_sites_section = false if line =~ /blocked\ssites\send/

    if blocked_sites_section && line =~  /^\s*#+\s*127\.0\.0\.1/
      line.gsub!(/^\s*#+\s*/, '')
    end

    lines << line
  end
end

File.open(hosts, 'w') do |f|
  f.puts lines
end