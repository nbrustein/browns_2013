#!/usr/bin/env ruby

require File.expand_path('../../lib/setup.rb', __FILE__)

pbp_games_by_date = PlayByPlay::Game.by_date
wp_games_by_date = WinPercentage::Game.by_date

dates = (pbp_games_by_date.keys + wp_games_by_date.keys).uniq

pairs = []
dates.each do |date|
   pbp_games = pbp_games_by_date[date]
   wp_games = wp_games_by_date[date]
   
   pbp_games.each do |g1|
       found = true
       wp_games.each do |g2|
          t1 = g1.teams.join('-')
          t2 = g2.teams.join('-')
          if t2.match(g1.teams[0]) && t2.match(g1.teams[1])              
              pairs << [g1, g2]
          end
       end
       if !found
           puts "********* No match for #{g1.teams.inspect}"
           wp_games.each do |g2|
               puts " - #{g2.teams.inspect}"
           end
       end
   end
end

# NOTE: there are only 255 games because the Miami/TB game from Mon, 11 Nov 2013 is missing from the 
#       play-by-play spreadsheet. I made a comment on the source site. Waiting for a response.