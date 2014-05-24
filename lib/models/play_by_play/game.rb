require 'csv'

module PlayByPlay
    class Game
        
        cattr_accessor :games_map
        attr_accessor :game_id
        attr_reader :plays
        
        def self.data_path
            File.join(ROOT_PATH, 'data', '2013 NFL Play-by-Play Data.csv')
        end
        
        def self.all
            return self.games_map.values unless self.games_map.nil?
            self.games_map = Hash.new do |hash, game_id|
                hash[game_id] = self.new(game_id)
            end
            CSV::foreach(data_path, headers: true) do |row|
               game_id = row['game-id']
               game = games_map[game_id]
               game.plays << PlayByPlay::Play.new(row.to_hash)
            end
            
            return self.games_map.values
        end
        
        def self.by_date
           @map = Hash.new { |h, d| h[d] = [] }
           self.all.each do |game|
               @map[game.date] << game
           end 
           return @map
        end
        
        def initialize(game_id)
            self.game_id = game_id
            @plays = Plays.new
        end
        
        def date
            plays[0].date 
        end
        
        def teams
            plays[0].teams
        end
        
        def method_missing(meth, *args, &block)
           if @plays.respond_to?(meth)
               return @plays.send(meth, *args, &block)
           end
           
           super
        end
        
        class Plays
            
            def initialize
               @list = []
               @sorted = false
            end
            
            def <<(play)
                @sorted = false
                @list << play
            end
            
            def method_missing(meth, *args, &block)
               if @list.respond_to?(meth)
                   return @list.send(meth, *args, &block)
               end
               
               super
            end
            
            def respond_to?(meth)
                default = super
                return default || @list.respond_to?(meth)
            end
            
        end
        
    end
end