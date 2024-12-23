{
  # Enable virtual input devices support
  hardware.uinput.enable = true;

  # Add user 'simon' to groups for uinput and input device access
  users.groups.uinput.members = ["simon"];
  users.groups.input.members = ["simon"];
}
