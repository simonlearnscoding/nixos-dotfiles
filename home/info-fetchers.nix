{pkgs, ...}: {
  home.packages = with pkgs; [
    neofetch # System information tool with visual output
    onefetch # Git repository information tool with visual output
    ipfetch # Displays public IP information
    powertop # Power consumption and system diagnostics tool
    cpufetch # CPU information fetcher
    ramfetch # RAM usage fetcher
    starfetch # System information with customizable star-shaped ASCII art
    octofetch # System information tool with Octocat-themed output
    htop # Interactive process viewer
    bottom # Resource monitor with an interactive UI
    btop # Modern resource monitor with TUI
    zfxtop # Command-line resource monitor for systems with ZFS
    # kmon          # Kernel module manager and monitor (requires root access)

    # GPU and compute information tools (may require root access)
    # vulkan-tools  # Vulkan utilities for inspecting Vulkan support
    # opencl-info   # Tool to query OpenCL platform and device capabilities
    # clinfo        # OpenCL device and platform information tool
    # vdpauinfo     # VDPAU (Video Decode and Presentation API) capabilities
    # libva-utils   # VA-API utilities for video acceleration
    # nvtop         # NVIDIA GPU resource monitor

    wlr-randr # Wayland display output management tool
    gpu-viewer # GPU information tool with graphical interface
    dig # DNS lookup tool
    speedtest-rs # Speed test utility for measuring network speed
  ];
}
