defmodule RocketpayWeb.UsersViewTest do
  use RocketpayWeb.ConnCase, async: true
  import Phoenix.View

  alias Rocketpay.{Account, User}
  alias RocketpayWeb.UsersView
  
  test "renders create.json" do
    params = %{
        name: "Gabriel",
        password: "123456",
        nickname: "reinert",
        email: "gabriel@gabriel.com",
        age: 20
      }
    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Rocketpay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected = %{
      message: "User created", 
      user: %{
        account: %{
          balance: Decimal.new("0.00"), 
          id: account_id
        }, 
        id: user_id, 
        name: "Gabriel", 
        nickname: "reinert"
      }
    } 
    assert expected == response

    end
end
