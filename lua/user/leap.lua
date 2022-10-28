local leap_ok, leap = pcall(require, "leap")

if not leap_ok then
  return
end

leap.add_default_mappings()
