defmodule SeraphoRank.Encrypter do
    def decrypt(cypher_data, size, key) do
        [base_iv, base_cypher] = String.split(cypher_data, ":")

        iv = Base.decode64!(base_iv)
        cypher = Base.decode64!(base_cypher)

        hash_key = hash(key)
        :crypto.crypto_one_time(:aes_256_cbc, hash_key, iv, cypher, false)
        |> binary_part(0, size)
    end

    def hash(key) do
        :crypto.hash(:sha256, key)
    end
end
