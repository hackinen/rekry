defmodule RekryTest do
  use ExUnit.Case
  doctest Rekry

  test "Parse mpegts file" do
    assert Rekry.parse_file("test.ts") == [17, 0, 4096, 256, 256, 256, 256, 256, 256, 256]
  end
end
