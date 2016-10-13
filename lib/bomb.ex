defmodule Bomb do
  use Application
  use Bitwise

  def start(_, _) do
    {:ok, pid} = setup_MCP 
    spawn(fn -> loop(pid, 1) end)
    
    {:ok, self}
  end

  def setup_MCP do
    {:ok, pid} = I2c.start_link("i2c-0", 0x20)
    Bomb.Led.write(pid, 0)
    {:ok, pid}
  end

  def loop(pid, val) when val > 4, do: loop(pid, 1)

  def loop(pid, val) do
    Bomb.Led.write(pid, val)
    :timer.sleep(200)
    loop(pid, val <<< 1)
  end

end
