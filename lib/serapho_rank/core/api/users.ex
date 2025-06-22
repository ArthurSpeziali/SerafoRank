defmodule SeraphoRank.Core.Users.Api do
    alias SeraphoRank.Core.Users
    alias SeraphoRank.Repo
    import Ecto.Query

    def insert(params) do
        struct(Users, params)
        |> Repo.insert()
    end

    def get(id) do
        Repo.get(Users, id)
        |> case do
            nil -> {:error, :not_found}
            querry -> {:ok, querry}
        end
    end

    def all() do
        {:ok, Repo.all(Users)}
    end

    def delete(id) do
        case get(id) do
            {:ok, querry} -> Repo.delete(querry)
            error -> error
        end
    end

    def update(id, params) do
        with {:ok, querry} <- get(id),
             changeset <- Users.changeset(querry, params),
             new_querry <- Repo.update(changeset) do

            {:ok, new_querry}
        else
            error -> error
        end
    end

    def all_limit(limit) do
        from(Users)
        |> order_by(desc: :waves)
        |> limit(^limit)
        |> Repo.all()

        |> case do
            querry -> {:ok, querry}
        end
    end
end
