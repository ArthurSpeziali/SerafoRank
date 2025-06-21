defmodule SeraphoRank.Context do
    alias SeraphoRank.Core.Users.Api



    def all(params) do
        size = Map.get(params, "size") || "100"
            |> valid_int()

        if size do
            cond do
                size < 1 ->
                    {:error, "the entrie cannot be negative or zero! (#{size})"}

                size > 100 ->
                    {:error, "the entrie's limit is 100! (#{size})"}

                true -> 
                    Api.all_limit(size)
            end
        end

    end


    defp valid_int(str) do
        case Integer.parse(str) do
            {int, ""} -> int
            _ -> false
        end
    end
end
