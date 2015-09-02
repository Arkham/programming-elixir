defmodule Customer do
  defstruct name: "", company: ""
end

defmodule BugReport do
  defstruct owner: %{}, details: "", severity: 1
end

report = %BugReport{owner: %Customer{name: "Dave", company: "AlphaSights"}, details: "broken"}
# %BugReport{details: "broken",
#  owner: %Customer{company: "AlphaSights", name: "Dave"}, severity: 1}
report.owner
# %Customer{company: "AlphaSights", name: "Dave"}
report.owner.name
# "Dave"
report = %BugReport{report | owner: %Customer{report.owner | name: "Ju"}}
# %BugReport{details: "broken",
#  owner: %Customer{company: "AlphaSights", name: "Ju"}, severity: 1}
report.owner.name
# "Ju"
put_in(report.owner.company, "Facebook")
# %BugReport{details: "broken", owner: %Customer{company: "Facebook", name: "Ju"},
#  severity: 1}
update_in(report.owner.name, &("Mr. " <> &1))
# %BugReport{details: "broken",
#  owner: %Customer{company: "AlphaSights", name: "Mr. Ju"}, severity: 1}

report = %{ owner: %{ name: "Ju", company: "Pragmatic" }, severity: 1 }
# %{owner: %{company: "Pragmatic", name: "Ju"}, severity: 1}
put_in(report[:owner][:name], "Judawg")
# %{owner: %{company: "Pragmatic", name: "Judawg"}, severity: 1}
put_in(report[:owner][:company], "AlphaSights")
# %{owner: %{company: "AlphaSights", name: "Ju"}, severity: 1}
update_in(report[:owner][:name], &("Mr. " <> &1))
# %{owner: %{company: "Pragmatic", name: "Mr. Ju"}, severity: 1}
