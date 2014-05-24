require 'hpricot'

module WinPercentage
    class Game
        
        cattr_accessor :games
        attr_reader :doc
        
        def self.data_dir
            File.join(ROOT_PATH, 'data', 'game_xmls')
        end
        
        def self.all
            return self.games unless self.games.nil?
            self.games = []
            Dir.glob(File.join(data_dir, '*.xml')).each_with_index do |path, i|
                doc = Hpricot.XML(open(path))
                self.games << new(doc)
            end
            
            return self.games
        end
        
        def self.by_date
           @map = Hash.new { |h, d| h[d] = [] }
           self.all.each do |game|
               @map[game.date] << game
           end 
           
           return @map
        end
        
        def initialize(doc)
            @doc = doc
        end
        
        def date
            return @date if defined? @date
            texts = @doc.search('//text')
            
            # the date is in the second-to-last text node
            node = texts[texts.size - 2]
            month, date, year = node.inner_text.match(/(\d+)\/(\d+)\/(\d+)/).to_a.slice(1, 4)
            @date = Date.new(year.to_i, month.to_i, date.to_i)
        end
        
        def teams
            # the teams are in the first two text nodes
            @teams ||= @doc.search('//text').slice(0, 2).map(&:inner_text).sort
        end
        
    end
end