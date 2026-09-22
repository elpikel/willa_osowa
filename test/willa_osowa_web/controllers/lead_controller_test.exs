defmodule WillaOsowaWeb.LeadControllerTest do
  use WillaOsowaWeb.ConnCase, async: true

  import Swoosh.TestAssertions

  test "POST /api/lead delivers an email and returns ok", %{conn: conn} do
    conn =
      post(conn, "/api/lead", %{
        "name" => "Anna Nowak",
        "email" => "anna@example.com",
        "message" => "Zapytanie o dom G"
      })

    assert json_response(conn, 200) == %{"ok" => true}
    assert_email_sent()
  end

  test "POST /api/lead with an invalid email returns 422 and sends nothing", %{conn: conn} do
    conn = post(conn, "/api/lead", %{"name" => "Anna", "email" => "nope"})

    assert json_response(conn, 422) == %{"ok" => false, "error" => "invalid_email"}
    assert_no_email_sent()
  end

  test "POST /api/lead with a blank name returns 422", %{conn: conn} do
    conn = post(conn, "/api/lead", %{"name" => "", "email" => "anna@example.com"})

    assert json_response(conn, 422)["error"] == "name_required"
    assert_no_email_sent()
  end
end
