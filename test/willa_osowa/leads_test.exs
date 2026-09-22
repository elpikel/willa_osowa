defmodule WillaOsowa.LeadsTest do
  use ExUnit.Case, async: true

  import Swoosh.TestAssertions

  alias WillaOsowa.Leads

  describe "submit/1" do
    test "sends an email to the fixed recipient with the lead as reply-to" do
      params = %{
        "name" => "Jan Kowalski",
        "email" => "jan@example.com",
        "phone" => "600100200",
        "message" => "Proszę o ofertę domu F"
      }

      assert {:ok, :sent} = Leads.submit(params)

      assert_email_sent(fn email ->
        assert email.from == {"Willowa Osowa", "noreply@przetargowi.pl"}
        assert {"Willowa Osowa", "macrac@gmail.com"} in email.to
        assert email.reply_to == {"Jan Kowalski", "jan@example.com"}
        assert email.subject == "Zapytanie — Willowa Osowa"
        assert email.text_body =~ "Jan Kowalski"
        assert email.text_body =~ "600100200"
        assert email.html_body =~ "Proszę o ofertę domu F"
      end)
    end

    test "trims whitespace and fills missing optional fields with a dash" do
      assert {:ok, :sent} =
               Leads.submit(%{"name" => "  Anna  ", "email" => " anna@example.com "})

      assert_email_sent(fn email ->
        assert email.reply_to == {"Anna", "anna@example.com"}
        assert email.text_body =~ "Telefon: —"
      end)
    end

    test "rejects a blank name and sends nothing" do
      assert {:error, :name_required} =
               Leads.submit(%{"name" => "   ", "email" => "jan@example.com"})

      assert_no_email_sent()
    end

    test "rejects an invalid email and sends nothing" do
      assert {:error, :invalid_email} = Leads.submit(%{"name" => "Jan", "email" => "nope"})
      assert_no_email_sent()
    end
  end
end
