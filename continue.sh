
mkdir -p $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/home/$username/.config/

# Download proot starship theme
curl -o $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/home/$username/.config/starship.toml https://raw.githubusercontent.com/roygoraposonjr/Termux_XFCE/refs/heads/main/starship_proot.toml
sed -i "s/phoenixbyrd/$username/" $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/home/$username/.config/starship.toml

# Apply cursor theme
cp -r $PREFIX/share/icons/dist-dark $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/usr/share/icons/dist-dark
cat <<'EOF' > $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/home/$username/.Xresources
Xcursor.theme: dist-dark
EOF

wget https://github.com/roygoraposonjr/Termux_XFCE/raw/main/conky.tar.gz
tar -xvzf conky.tar.gz
rm conky.tar.gz
mv $HOME/.config/conky/ $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/home/$username/.config/

# Conky
cp $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/usr/share/applications/conky.desktop $HOME/.config/autostart/
sed -i 's|^Exec=.*$|Exec=prun conky -c .config/conky/Alterf/Alterf.conf|' $HOME/.config/autostart/conky.desktop

# Flameshot
cp $PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu/usr/share/applications/org.flameshot.Flameshot.desktop $HOME/.config/autostart/
sed -i 's|^Exec=.*$|Exec=prun flameshot|' $HOME/.config/autostart/org.flameshot.Flameshot.desktop

chmod +x $HOME/.config/autostart/*.desktop

}

# Start installation
main

clear
# Display usage instructions
echo -e "\n${BLUE}╔════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Setup Complete!            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════╝${NC}\n"

echo -e "${GREEN}Available Commands:${NC}"
echo -e "${YELLOW}start${NC}"
echo -e "Launches the XFCE desktop environment with hardware acceleration enabled\n"

echo -e "${YELLOW}ubuntu${NC}"
echo -e "Enters the Ubuntu proot environment for installing additional aarch64 packages\n"

echo -e "${YELLOW}prun${NC}"
echo -e "Executes Ubuntu proot applications directly from Termux\n"

echo -e "${YELLOW}zrun${NC}"
echo -e "Runs Ubuntu applications with hardware acceleration enabled\n"

echo -e "${YELLOW}zrunhud${NC}"
echo -e "Same as zrun but includes an FPS overlay for performance monitoring\n"

echo -e "${GREEN}Note:${NC} For Firefox hardware acceleration:"
echo -e "1. Open Firefox settings"
echo -e "2. Search for 'performance'"
echo -e "3. Uncheck the hardware acceleration option\n"

echo -e "${YELLOW}Installation complete! Use 'start' to launch your desktop environment.${NC}\n"


source $PREFIX/etc/bash.bashrc
termux-reload-settings
rm install_xfce_native.sh
