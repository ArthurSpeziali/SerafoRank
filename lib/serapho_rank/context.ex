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
        if Validate.fields(params) && Validate.required(params) do
            %{"name" => name, "waves" => waves, "minutes" => minutes,  "bot" => bot, "cipher" => cipher, "part" => part} = params
            email = Map.get(params, "email")

            key = name <> Integer.to_string(waves) <> Integer.to_string(minutes) <> Atom.to_string(bot)
                  |> Encrypter.hash()

            if Encrypter.decrypt(cipher, part, key) == Utils.get_sha256() do
                {:ok, querry} = Api.insert(%{name: name, waves: waves, minutes: minutes, email: email})
                {:ok, %{id: querry.id}}
            else
                {:error, "the encryption is invalid or has been compromised!"}
            end
        else 
            {:error, "the body needs to have entire required params! (#{Api.fields() |> Enum.join(", ")})"}
        end
    end

end
