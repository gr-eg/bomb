defmodule Bomb.Led do
  def write(pid, pattern) do
    I2c.write(pid, <<0x14, pattern>>)
  end
end
