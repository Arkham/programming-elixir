defmodule Everything do
  def ok!(result) do
    case result do
      { :ok, data } ->
        data
      { :error, _reason } ->
        raise RuntimeError
    end
  end
end
