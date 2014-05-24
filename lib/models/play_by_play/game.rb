require 'csv'

module PlayByPlay
    class Game
        
        def self.data_path
            File.join(ROOT_PATH, 'data', '2013 NFL Play-by-Play Data.csv')
        end
        
        def self.all
            CSV::open(data_path, 'r', headers: true) do |csv|
               pp csv.read[0] 
            end
        end
        
    end
end