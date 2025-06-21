defmodule SeraphoRank.Repo.Migrations.CreateTable do
    use Ecto.Migration

    def change() do
        create table("users") do
            add :name, :string, size: 32, null: false
            add :points, :int, null: false
            add :email, :string
        end
    end
end
