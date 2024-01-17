defmodule HanziHeroWeb.HTMXRedirect do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _opts) do
    register_before_send(conn, fn conn ->
      if conn.status == 302 do
        put_status(conn, :see_other)
      else
        conn
      end
    end)
  end
end
