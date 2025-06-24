defmodule SeraphoRank.Validate do
    alias SeraphoRank.Core.Users.Api

    
    def int(str) do
        case Integer.parse(str) do
            {int, ""} -> int
            _ -> false
        end
    end

    def fields(map) do
        case Api.fields() -- Map.keys(map) do
            [] -> true
            _ -> false 
        end
    end

    def required(map) do
        with true <- String.printable?(map["name"]),
             true <- is_integer(map["waves"]),
             true <- is_integer(map["minutes"]),
             true <- is_boolean(map["bot"]),
             true <- is_binary(map["cipher"]),
             email <- map["email"] || "noone@nohost.com",
             true <- String.printable?(email) do

            true
        else
            _error -> 
                false
        end
    end
end
