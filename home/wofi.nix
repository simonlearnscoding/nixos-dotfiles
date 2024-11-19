{ ... }: {
  programs.wofi = {
    enable = true;
    # Define a custom configuration source for Wofi
    config = {
      source = "./configfiles/wofi";
    };
  };

}
