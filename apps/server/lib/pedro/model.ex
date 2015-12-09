defmodule Pedro.Model do
  defmacro __using__ options do
    quote do
      use Ecto.Model
      alias unquote(__MODULE__)
    end
  end

end
