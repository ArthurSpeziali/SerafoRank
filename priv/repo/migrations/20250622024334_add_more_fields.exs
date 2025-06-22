defmodule SeraphoRank.Repo.Migrations.AddMoreFields do
    use Ecto.Migration

    def change() do
        alter table("users") do
            remove :points

            add :waves, :int, null: false
            add :minutes, :int, null: false
            add :bot, :boolean, null: false, default: true
        end
    end
end
