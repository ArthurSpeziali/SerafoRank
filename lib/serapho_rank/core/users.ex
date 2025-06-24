defmodule SeraphoRank.Core.Users do
    use Ecto.Schema

    schema "users" do
        field :name, :string
        field :waves, :integer
        field :minutes, :integer
        field :bot, :boolean
        field :email, :string
    end


    def changeset(model, params) do
        Ecto.Changeset.cast(model, params, fields())
    end

    def fields() do
        [
            :name,
            :waves,
            :minutes,
            :bot,
            :email
        ]
    end
end
