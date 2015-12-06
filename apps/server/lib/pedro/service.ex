defmodule Pedro.Service do
  defmacro __using__ _params do
    quote do
      import Pedro.Command, only: [command: 1]
      import Pedro.Query,   only: [query: 1]
      require Logger
    end
  end
end
