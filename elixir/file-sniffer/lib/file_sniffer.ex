defmodule FileSniffer do
  def type_from_extension("exe"), do: "application/octet-stream"
  def type_from_extension(extension), do: "image/#{extension}"

  def type_from_binary(<<0x42, 0x4D, _rest::binary>>), do: type_from_extension("bmp")
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _rest::binary>>), do: type_from_extension("jpg")
  def type_from_binary(<<0x47, 0x49, 0x46, _rest::binary>>), do: type_from_extension("gif")
  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>>), do: type_from_extension("exe")

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>>),
    do: type_from_extension("png")

  def verify(file_binary, extension) do
    type = type_from_extension(extension)

    if type == type_from_binary(file_binary),
      do: {:ok, type},
      else: {:error, "Warning, file format and file extension do not match."}
  end
end
