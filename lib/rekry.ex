defmodule Rekry do
  @moduledoc """
  Documentation for Rekry.
  """

  def parse_file(filename) do
    # assumptions:
    #    file in "filename" exists
    #    the file contains 188 byte packets, i.e. the bitstring is divisible by 188

    # read file (returns a BitStirng)
    file = File.read!(filename)

    # recurse through the 188-byte packets in the bitstring
    get_pids(file, [])

  end

  def get_pids(<<>>, pids) do
    # end the recursion when no packets left
    pids
  end

  def get_pids(file, pids) do
    # get the first packet of the file and store the rest of the packets
    <<packet::binary-size(188), rest::binary>> = file

    # pattern match to get the PID
    # The first 3 bytes of the 188-byte packet are:
    #   Sync byte (1 byte/8 bits),
    #   TEI (1 bit),
    #   PUSI (1 bit),
    #   Trasport priority (1 bit),
    #   and PID (remaining 13 bits)
    #<<sync_byte, tei::1, pusi::1, tp::1, pid::13, _::binary >> = packet
    <<_::11, pid::13, _::binary >> = packet

    get_pids(rest, pids ++ [pid])

  end


end
