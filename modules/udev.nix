{ config, lib, pkgs, ... }:

{
  # Create CPU hotplug scripts
  environment.etc = {
    "/nixos/scripts/disable_cores.sh" = {
      text = ''
        echo 0 > /sys/devices/system/cpu/cpu8/online
        echo 0 > /sys/devices/system/cpu/cpu9/online
        echo 0 > /sys/devices/system/cpu/cpu10/online
        echo 0 > /sys/devices/system/cpu/cpu11/online
        echo 0 > /sys/devices/system/cpu/cpu12/online
        echo 0 > /sys/devices/system/cpu/cpu13/online
        echo 0 > /sys/devices/system/cpu/cpu14/online
        echo 0 > /sys/devices/system/cpu/cpu15/online
      '';
      mode = "0555";
    };
    "/nixos/scripts/enable_cores.sh" = {
      text = ''
        echo 1 > /sys/devices/system/cpu/cpu8/online
        echo 1 > /sys/devices/system/cpu/cpu9/online
        echo 1 > /sys/devices/system/cpu/cpu10/online
        echo 1 > /sys/devices/system/cpu/cpu11/online
        echo 1 > /sys/devices/system/cpu/cpu12/online
        echo 1 > /sys/devices/system/cpu/cpu13/online
        echo 1 > /sys/devices/system/cpu/cpu14/online
        echo 1 > /sys/devices/system/cpu/cpu15/online
      '';
      mode = "0555";
    };
  };

  # Charge control
  # iGPU battery
  # Disable dGPU
  # CPU hotplug
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", KERNEL=="BAT0", ATTR{charge_control_end_threshold}="80"
    SUBSYSTEM=="drm", KERNEL=="card1", DRIVERS=="amdgpu", ATTR{device/power_dpm_state}="balanced"
    ACTION=="add", KERNEL=="0000:03:00.0", SUBSYSTEM=="pci", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    SUBSYSTEM=="power_supply", ACTION=="change", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.bash}/bin/bash /etc/nixos/scripts/enable_cores.sh"
    SUBSYSTEM=="power_supply", ACTION=="change", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.bash}/bin/bash /etc/nixos/scripts/disable_cores.sh"
  '';

  # Left Win(scancode db -> leftalt)
  # Left Alt(scancode 38 -> leftctrl)
  # Right Alt(scancode b8 -> rightctrl)
  # Right Ctrl(scancode 9d -> rightalt)
  services.udev.extraHwdb = ''
    evdev:input:b0011v0001p*
     KEYBOARD_KEY_db=leftalt
     KEYBOARD_KEY_38=leftctrl
     KEYBOARD_KEY_b8=rightctrl
     KEYBOARD_KEY_9d=rightalt
  '';
}
