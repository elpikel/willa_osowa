defmodule WillaOsowaWeb.ErrorJSON do
  # Renders "404.json", "500.json", etc. from the status message.
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
