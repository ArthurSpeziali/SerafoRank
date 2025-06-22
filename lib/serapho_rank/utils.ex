defmodule SeraphoRank.Utils do
    alias SeraphoRank.Core.Users



    def json!(querry) do
        Map.take(querry, Users.fields())
    end
end
