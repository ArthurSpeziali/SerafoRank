defmodule SeraphoRank.Context do
    alias SeraphoRank.Core.Users.Api
    alias SeraphoRank.Validate
    alias SeraphoRank.Utils



    def all(params) do
        size = (Map.get(params, "size") || "100")
            |> Validate.int()

        if size do
            cond do
                size < 1 ->
                    {:error, "the entrie cannot be negative or zero! (#{size})"}

                size > 100 ->
                    {:error, "the entrie's limit is 100! (#{size})"}

                true -> 
                    {:ok, querry} = Api.all_limit(size)
                    {:ok, 
                        Enum.map(querry, &(Utils.json!(&1)))
                    }
            end
        else
            {:error, "the entrie must be an integer! #{size}"}
        end

    end


end
