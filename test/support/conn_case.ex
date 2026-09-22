defmodule WillaOsowaWeb.ConnCase do
  @moduledoc """
  Test case for tests that need to build a connection and hit the endpoint.
  """
  use ExUnit.CaseTemplate

  using do
    quote do
      @endpoint WillaOsowaWeb.Endpoint

      import Plug.Conn
      import Phoenix.ConnTest
    end
  end

  setup do
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
