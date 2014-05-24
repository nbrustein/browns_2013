module PlayByPlay
    class Play
        
        def initialize(attrs)
           @attrs = attrs 
        end
        
        def method_missing(meth, *args, &block)
            if @attrs.key?(meth.to_s)
               return @attrs[meth.to_s] 
            end
            
            super
        end
        
        def date
            return @date if defined? @date
            
            string = @attrs['Date']
            month, date, year = string.match(/(\d+)\/(\d+)\/(\d+)/).to_a.slice(1, 4)
            year = "20#{year}"
            @date = Date.new(year.to_i, month.to_i, date.to_i)
        end
        
        def teams
            @teams ||= [@attrs['Tm'], @attrs['Opp']].sort
        end
        
    end
end