#!/usr/bin/env ruby

  require File.expand_path(File.join(File.dirname(__FILE__), 'class/PurpleCarbon'))

  carbon = PurpleCarbon.new

  if ARGV[0] == "-c"

    carbon.CreateConfig(ARGV[1])

  end

# $?.exitstatus
