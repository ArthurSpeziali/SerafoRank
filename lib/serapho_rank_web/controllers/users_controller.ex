defmodule SeraphoRankWeb.UsersController do
    use SeraphoRankWeb, :controller
    alias SeraphoRank.Context



    def response(conn, result) do
        case result do
            {:ok, querry} -> 
                put_status(conn, 200)
                |> json(%{status: :ok, body: querry})


            {:error, "user not found" = reason} -> 
                put_status(conn, 404)
                |> json(%{status: :error, reason: reason})

            {:error, reason} -> 
                put_status(conn, 400)
                |> json(%{status: :error, reason: reason})
        end
    end


    def rank(conn, params) do
        response(conn, Context.all(params))
    end
end
