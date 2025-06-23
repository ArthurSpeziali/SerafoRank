defmodule SeraphoRank.Utils do
    alias SeraphoRank.Core.Users


    def json!(querry) do
        Map.take(querry, Users.fields())
    end

    def get_sha256() do
        <<220, 13, 119, 70, 43, 207, 190, 243, 55, 201, 243, 148, 58, 179, 63, 1, 248,147, 187, 94, 9, 117, 91, 207, 214, 158, 225, 23, 139, 164, 132, 210>>
    end
end
