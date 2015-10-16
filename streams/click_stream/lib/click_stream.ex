defmodule ClickStream do
  require Record
  Record.defrecordp :wx, Record.extract(:wx, from_lib: "wx/include/wx.hrl")

  @title 'Click Stream'

  def create_stream_x do
    Stream.resource(fn -> create_frame end,
                    fn(frame) -> loop_x(frame) end,
                    fn(frame) -> destroy_frame(frame) end)
  end 

  def create_stream_y do
    Stream.resource(fn -> create_frame end,
                    fn(frame) -> loop_y(frame) end,
                    fn(frame) -> destroy_frame(frame) end)
  end 

  def create_frame do
    wx    = :wx.new
    frame = :wxFrame.new(wx, -1, @title)
    :wxWindow.connect(frame, :close_window)
    :wxWindow.connect(frame, :motion)
    :wxFrame.show(frame)
    frame
  end

  def loop_x(frame) do
    receive do
      {:wx, _, _, _, {:wxMouse, :motion, x, _y, _, _, _, _, _, _, _, _, _, _}} ->
        IO.puts "x: #{x}"
        {[x], frame}
      {:wx, _, {:wx_ref, _, :wxFrame, []}, [], {:wxClose, :close_window}} ->
        {:halt, frame}
      _ ->
        {:halt, frame}
    end
  end

  def loop_y(frame) do
    receive do
      {:wx, _, _, _, {:wxMouse, :motion, _x, y, _, _, _, _, _, _, _, _, _, _}} ->
        IO.puts "y: #{y}"
        {[y], frame}
      {:wx, _, {:wx_ref, _, :wxFrame, []}, [], {:wxClose, :close_window}} ->
        {:halt, frame}
      _ ->
        {:halt, frame}
    end
  end

  def destroy_frame(frame) do
    :wxFrame.destroy(frame)
  end
end
