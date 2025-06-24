defmodule SeraphoRank.Repo.Migrations.CreateUsers do
    use Ecto.Migration

    def change() do
        create table("users") do
            add :name, :string, size: 32, null: false
            add :waves, :int, null: false
            add :minutes, :int, null: false
            add :bot, :boolean, null: false 
            add :email, :string
        end

        create unique_index("users", [:email])
    end
end
