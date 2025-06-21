defmodule SeraphoRankWeb.UsersController do
    use SeraphoRankWeb, :controller


    def response(conn, result) do
        case result do
            {:ok, querry} -> 
                put_status(200)
                json(%{status: :ok, querry: querry})


            {:error, "user not found" = reason} -> 
                put_status(404)
                json(%{status: :error, reason: reason})

            {:error, reason} -> 
                put_status(400)
                json(%{status: :error, reason: reason})
        end
    end


    def rank(conn, params) do
        response(conn, Context.get(params))
    end
end
