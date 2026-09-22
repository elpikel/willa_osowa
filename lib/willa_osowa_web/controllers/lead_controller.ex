defmodule WillaOsowaWeb.LeadController do
  use WillaOsowaWeb, :controller

  alias WillaOsowa.Leads

  def create(conn, params) do
    case Leads.submit(params) do
      {:ok, _} ->
        json(conn, %{ok: true})

      {:error, reason} when reason in [:name_required, :invalid_email] ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{ok: false, error: to_string(reason)})

      {:error, _reason} ->
        conn
        |> put_status(:bad_gateway)
        |> json(%{ok: false, error: "delivery_failed"})
    end
  end
end
