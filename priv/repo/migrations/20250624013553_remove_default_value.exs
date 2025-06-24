defmodule SeraphoRank.Repo.Migrations.RemoveDefaultValue do
    use Ecto.Migration

    def change() do
        alter table("users") do
            modify :bot, :boolean, null: false
        end
    end
end
