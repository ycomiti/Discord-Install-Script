#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

userHome="/home/${USER}"
installDir="${userHome}/opt/discord"
discordBin="${installDir}/Discord/Discord"
discordIcon="${installDir}/Discord/discord.png"
desktopDir=$(xdg-user-dir DESKTOP 2>/dev/null || echo "${HOME}/Desktop")
discordDownloadPage="https://discord.com/api/download?platform=linux&format=tar.gz"

originalPwd=$(pwd)

getDownloadUrl() {
    curl -sI "${discordDownloadPage}" | awk -F': ' '/^location:/ {gsub("\r",""); print $2}'
}

createDesktopFile() {
    local targetDir="${1}"
    local desktopFilePath="${targetDir}/discord.desktop"

    if [[ -d "${targetDir}" && ! -f "${desktopFilePath}" ]]; then
        cat > "${desktopFilePath}" << EOF
[Desktop Entry]
Name=Discord
StartupWMClass=discord
Comment=All-in-one voice and text chat for gamers that's free, secure, and works on both your desktop and phone.
GenericName=Internet Messenger
Exec=env DISCORD_DISABLE_SENTRY=1 DISCORD_DISABLE_CRASH_REPORTING=1 DISCORD_DISABLE_UPDATES=1 DISCORD_ENABLE_CRASH_CONTEXT=0 ${discordBin}
Icon=${discordIcon}
Type=Application
Categories=Network;InstantMessaging;
EOF
        chmod 644 "${desktopFilePath}"
        echo "Created desktop entry at ${desktopFilePath}"
    fi
}

downloadDiscord() {
    if [[ -d "${installDir}" ]]; then
        echo "Removing existing Discord installation..."
        rm -rf "${installDir}"
    fi

    mkdir -p "${installDir}"
    cd "${installDir}"

    echo "Fetching latest Discord download URL..."
    local downloadUrl
    downloadUrl=$(getDownloadUrl)
    if [[ -z "${downloadUrl}" ]]; then
        echo "Error: Unable to get Discord download URL."
        exit 1
    fi

    local fileName="${downloadUrl##*/}"

    echo "Downloading ${fileName}..."
    curl -L --fail --progress-bar -o "${fileName}" "${downloadUrl}"

    echo "Extracting ${fileName}..."
    tar -xzf "${fileName}"

    rm -f "${fileName}"

    if [[ ! -x "${discordBin}" ]]; then
        echo "Error: Discord binary not found or not executable after extraction."
        exit 1
    fi

    createDesktopFile "${userHome}/.local/share/applications"
    createDesktopFile "${desktopDir}"

    echo "Discord installation completed successfully."
}

downloadDiscord

cd "${originalPwd}"
