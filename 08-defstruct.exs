defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end

s1 = %Subscriber{}
IO.inspect s1

s2 = %Subscriber{ name: "Dave" }
IO.inspect s2

s3 = %Subscriber{ name: "Mary", paid: true }
IO.inspect s3

defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}) do
    attendee.paid && attendee.over_18
  end

  def print_vip_badge(%Attendee{name: name}) when name != "" do
    IO.puts "Very cheap badge for #{name}"
  end

  def print_vip_badge(%Attendee{}) do
    raise "Missing name for badge"
  end
end

a1 = %Attendee{name: "Dave", over_18: true}
# %Attendee{name: "Dave", over_18: true, paid: false}
Attendee.may_attend_after_party(a1)
# false
a2 = %Attendee{a1 | paid: true}
# %Attendee{name: "Dave", over_18: true, paid: true}
Attendee.may_attend_after_party(a2)
# true
Attendee.print_vip_badge(a2)
# Very cheap badge for Dave
# :ok
a3 = %Attendee{}
# %Attendee{name: "", over_18: true, paid: false}
# Attendee.print_vip_badge(a3)
# ** (RuntimeError) Missing name for badge
#     08-defstruct.exs:26: Attendee.print_vip_badge/1

defmodule TrendyAttendee do
  @derive Access
  defstruct name: "", over_18: false
end

ta = %TrendyAttendee{name: "Iggy"}
# %TrendyAttendee{name: "Iggy", over_18: false}
ta[:name]
# "Iggy"
