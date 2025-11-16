{ config, lib, pkgs, ... }:

{
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
