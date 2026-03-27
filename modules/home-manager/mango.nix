{ ... }:

{
  wayland.windowManager.mango = {
    enable = true;
    settings = ''
      # Monitor layout
      # DP-1 (ASUS VG249, 144Hz) on the right, HDMI-A-1 (LG FULL HD, 75Hz) on the left
      monitorrule=name:^DP-1$,width:1920,height:1080,refresh:144,x:1920,y:0,scale:1,vrr:0,rr:0
      monitorrule=name:^HDMI-A-1$,width:1920,height:1080,refresh:75,x:0,y:0,scale:1,vrr:0,rr:0

      bind=SUPER+Shift,r,reload-config
      bind=SUPER,q,killclient
      bind=SUPER,Return,spawn,ghostty
      bind=SUPER,z,spawn,zeditor
      bind=SUPER,f,spawn,firefox
      bind=SUPER,d,spawn,dolphin
      bind=SUPER,v,spawn,vesktop
      bind=SUPER,s,spawn,steam
      bind=SUPER+Shift,s,spawn,~/.config/mango/snip.sh

      exec-once=~/.config/mango/autostart.sh
    '';
    autostart_sh = ''
      swaybg -i ~/wallpapers/10.png > /dev/null 2>&1 &
      zeditor ~/nixos &
      ghostty &
    '';
  };
}
