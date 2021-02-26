defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true
  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do 
    test "Create a new user if the params are valid" do
      params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "reinert",
        email: "gabriel@gabriel.com",
        age: 20
      }
      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Gabriel", age: 20, id: ^user_id} = user
    end
    test "Return an error when the params are invalid" do
      params = %{
        name: "Gabriel",
        nickname: "reinert",
        email: "gabriel@gabriel.com",
        age: 15
      }
      {:error, changeset} = Create.call(params)

      expected = %{
        age: ["must be greater than or equal to 18"], 
        password: ["can't be blank"]
      }
      assert errors_on(changeset) == expected
    end
  end
end
