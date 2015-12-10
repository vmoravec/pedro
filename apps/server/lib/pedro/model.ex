defmodule Pedro.Model do
  defmacro __using__ options do
    quote do
      use    Ecto.Model
      import Ecto.Query
      alias __MODULE__
      alias Pedro.Repo

      def repo do
        Pedro.Repo
      end
    end
  end

end
