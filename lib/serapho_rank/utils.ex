defmodule SeraphoRank.Utils do
    alias SeraphoRank.Core.Users


    def json!(querry) do
        Map.take(querry, Users.fields())
    end

    def get_sha256() do
        "e43c7b56f6397a8622caeeb9b21689f1424d51353ae7eb205f573cccf07ce157"
    end
end
