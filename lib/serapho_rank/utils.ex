defmodule SeraphoRank.Utils do
    alias SeraphoRank.Core.Users


    def json!(querry) do
        Map.take(querry, Users.fields())
    end

    def get_sha256() do
        "4608529b6779db8fa72f3e33c59b3f17a6a11d1e3bec16b349cf88874f1de0f6"
    end
end
