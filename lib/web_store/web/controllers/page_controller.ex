defmodule WebStore.Web.PageController do
  use WebStore.Web, :controller

  def index(conn, _params) do
    conn = _set_cart_id(conn)

    cart_pid = EcCart.Cache.server_process(Plug.Conn.get_session(conn,:ec_cart_id))
    cart_structure = EcCart.Server.ec_cart(cart_pid) 
    render conn, "index.html"
  end

  def _set_cart_id(conn) do
    ec_cart_id = Plug.Conn.get_session(conn,:ec_cart_id) || :crypto.strong_rand_bytes(32) |> Base.encode64 |> binary_part(0, 32)
    Plug.Conn.put_session(conn,:ec_cart_id, ec_cart_id )
  end
end
