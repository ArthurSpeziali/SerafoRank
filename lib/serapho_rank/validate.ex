defmodule SeraphoRank.Validate do
    alias SeraphoRank.Core.Users

    
    def int(str) do
        case Integer.parse(str) do
            {int, ""} -> int
            _ -> false
        end
    end

    def fields(map) do
        case Map.keys(map) -- Users.fields do
            [] -> true
            _ -> false 
        end
    end
end
