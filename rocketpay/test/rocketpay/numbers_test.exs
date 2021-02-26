defmodule Rocketpay.NumbersTest do
  use ExUnit.Case, async: true
  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "Sum the of the given file, when there's a file with that name" do
      response = Numbers.sum_from_file("numbers")
      expect_response = {:ok, %{result: 37}}

      assert response == expect_response
    end

    test "When there's no file with the given name, returns an error" do
      response = Numbers.sum_from_file("banana")
      expect_response = {:error, %{message: "Invalid file!"}}

      assert response == expect_response
    end

  end

end
