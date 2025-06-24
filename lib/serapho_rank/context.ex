defmodule SeraphoRank.Context do
    alias SeraphoRank.Core.Users.Api
    alias SeraphoRank.Validate
    alias SeraphoRank.Utils
    alias SeraphoRank.Encrypter


    def get(params) do
        size = (Map.get(params, "size") || "100")
            |> Validate.int()

        if size do
            cond do
                size < 1 ->
                    {:error, "the entrie cannot be negative or zero! (#{size})"}

                size > 100 ->
                    {:error, "the entrie's limit is 100! (#{size})"}

                true -> 
                    {:ok, querry} = Api.all_limit(size)
                    {:ok, 
                        Enum.map(querry, &(Utils.json!(&1) |> Map.delete(:email)))
                    }
            end
        else
            {:error, "the entrie must be an integer! #{size}"}
        end

    end

    def post(params) do
        fields? = Validate.fields(params)
        if fields? && Validate.required(params) do
            %{"name" => name, "waves" => waves, "minutes" => minutes,  "bot" => bot, "cipher" => cipher} = params
            email = Map.get(params, "email")

            key = name <> Integer.to_string(waves) <> Integer.to_string(minutes) <> Atom.to_string(bot)

            if Encrypter.decrypt(cipher, key) == Utils.get_sha256() do
                if String.length(name) > 32 do
                    {:error, "the name cannot contain more than 32 characters!"}
                else
                    {:ok, querry} = insert_or_update(%{name: name, waves: waves, minutes: minutes, bot: bot, email: email})
                    {:ok, %{id: querry.id}}
                end
            else
                {:error, "the encryption is invalid or has been compromised!"}
            end
        else 
            if fields? do
                {:error, "the body needs to have entire valid params! (#{Api.fields() |> Enum.join(", ")})"}
            else
                {:error, "some field is invalid!"}
            end
        end
    end


    def insert_or_update(params) do
        querry = Api.get_email(params[:email] || "noone@nohost.com")

        case querry do  
            {:ok, item} ->
                Api.update(item.id, params)

            {:error, _reason} ->
                Api.insert(params)
        end
    end
end
