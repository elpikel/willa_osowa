defmodule WillaOsowa.Leads do
  @moduledoc """
  Handles contact-form submissions from the landing page and delivers them as
  transactional email through `WillaOsowa.Mailer` (Brevo in prod, a local
  mailbox in dev, the test adapter in tests).
  """

  import Swoosh.Email

  require Logger

  alias WillaOsowa.Mailer

  @subject "Zapytanie — Willowa Osowa"

  @type lead :: %{
          name: String.t(),
          email: String.t(),
          phone: String.t(),
          message: String.t()
        }

  @doc """
  Validate the incoming params and send the lead by email.

  Returns `{:ok, :sent}` on success or `{:error, reason}`.
  """
  @spec submit(map()) :: {:ok, :sent} | {:error, atom()}
  def submit(params) do
    with {:ok, lead} <- validate(params) do
      deliver(lead)
    end
  end

  defp validate(params) do
    name = params |> get("name") |> String.trim()
    email = params |> get("email") |> String.trim()
    phone = params |> get("phone") |> String.trim()
    message = params |> get("message") |> String.trim()

    cond do
      name == "" -> {:error, :name_required}
      not valid_email?(email) -> {:error, :invalid_email}
      true -> {:ok, %{name: name, email: email, phone: phone, message: message}}
    end
  end

  defp deliver(lead) do
    email =
      new()
      |> to({recipient_name(), recipient()})
      |> from(from_address())
      |> reply_to({lead.name, lead.email})
      |> subject(@subject)
      |> text_body(text_content(lead))
      |> html_body(html_content(lead))

    case Mailer.deliver(email) do
      {:ok, _metadata} ->
        {:ok, :sent}

      {:error, reason} ->
        Logger.error("[lead] delivery failed: #{inspect(reason)}")
        {:error, :delivery_failed}
    end
  end

  defp text_content(lead) do
    """
    Nowe zapytanie z osiedla Willowa Osowa.

    Imię i nazwisko: #{lead.name}
    Telefon: #{blank_to_dash(lead.phone)}
    E-mail: #{lead.email}

    Wiadomość:
    #{blank_to_dash(lead.message)}
    """
  end

  defp html_content(lead) do
    """
    <h2>Nowe zapytanie — Willowa Osowa</h2>
    <p><strong>Imię i nazwisko:</strong> #{esc(lead.name)}</p>
    <p><strong>Telefon:</strong> #{esc(blank_to_dash(lead.phone))}</p>
    <p><strong>E-mail:</strong> #{esc(lead.email)}</p>
    <p><strong>Wiadomość:</strong><br>#{esc(blank_to_dash(lead.message))}</p>
    """
  end

  defp valid_email?(email), do: email =~ ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/

  defp get(params, key), do: to_string(params[key] || params[String.to_atom(key)] || "")

  defp blank_to_dash(str) when str in ["", nil], do: "—"
  defp blank_to_dash(str), do: str

  defp esc(str) do
    str
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\n", "<br>")
  end

  # The sender must be a verified sender/domain on Brevo. Set via
  # `config :willa_osowa, :mail_from, {"Name", "addr"}` (MAIL_FROM in prod).
  defp from_address do
    Application.get_env(:willa_osowa, :mail_from, {"Willowa Osowa", "noreply@przetargowi.pl"})
  end

  defp recipient, do: Application.get_env(:willa_osowa, :lead_recipient)
  defp recipient_name, do: Application.get_env(:willa_osowa, :lead_recipient_name)
end
