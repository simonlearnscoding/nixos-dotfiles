{
  # Enable virtual input devices support
  hardware.uinput.enable = true;

  # Add user 'simon' to groups for uinput and input device access
  users.groups.uinput.members = ["simon"];
  users.groups.input.members = ["simon"];

  hardware = {
    opengl = {
      enable = true;             # Enable OpenGL for graphics rendering
      driSupport32Bit = true;    # Enable 32-bit DRI support for compatibility with certain applications
    };
  };
}
