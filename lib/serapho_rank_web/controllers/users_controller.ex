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
        response(conn, Context.get(params))
    end

    def submit(conn, params) do
        response(conn, Context.post(params))
    end


    def error(conn, _params) do
        put_status(conn, 404)
        |> text("Operation is not valid!")
    end
end
