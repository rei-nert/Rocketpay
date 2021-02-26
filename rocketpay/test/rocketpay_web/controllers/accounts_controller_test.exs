defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do 
      user_params = %{ 
        name: "Gabriel",
        password: "123456",
        nickname: "reinert",
        email: "gabriel@gabriel.com",
        age: 20
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(user_params)
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYTEyMw==")
      {:ok, conn: conn, account_id: account_id}
    end

    test "Make a deposit if all params are valid", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.0"}
      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |>json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Balance changed successfully"
      } = response
    end
    
    test "Params are invalid in a deposit operation, giving an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}
      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |>json_response(:bad_request)
      
      expected = %{"message" => "Invalid deposit value"}
      assert expected == response
    end
  end
end
