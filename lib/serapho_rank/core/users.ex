defmodule SeraphoRank.Core.Users do
    use Ecto.Schema

    schema "users" do
        field :name, :string
        field :points, :integer
        field :email, :string
    end


    def changeset(model, params) do
        Ecto.Changeset.cast(model, params, fields())
    end

    def fields() do
        [
            :name,
            :points,
            :email
        ]
    end
end
