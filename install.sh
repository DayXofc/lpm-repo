#!/bin/bash
# Скрипт установки lpm напрямую из корня репозитория GitHub

set -e

# --- КОНФИГУРАЦИЯ ---
# ЗАМЕНИ НА СВОЙ НИК И ИМЯ РЕПОЗИТОРИЯ:
GITHUB_USER="D"
REPO_NAME="lpm"
BINARY_NAME="lpm"
INSTALL_DIR="$HOME/.local/bin"

# Ссылка на raw-версию файла в ветке main
RAW_URL="https://raw.githubusercontent.com/DayXofc/lpm-repo/refs/heads/main"

echo "=== Установка $BINARY_NAME напрямую из GitHub ==="

# 1. Создаем папку ~/.local/bin, если её еще нет
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Создаем директорию $INSTALL_DIR..."
    mkdir -p "$INSTALL_DIR"
fi

# 2. Скачиваем бинарник прямо из корня ветки main
echo "Скачивание бинарника..."
curl -L -# -o "$INSTALL_DIR/$BINARY_NAME" "$RAW_URL/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"

# 3. Проверяем PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "--------------------------------------------------------"
    echo "⚠️ Внимание: Папка $INSTALL_DIR не добавлена в твой PATH."
    
    # Автодобавление для zsh/bash
    if [ -f "$HOME/.zshrc" ]; then
        echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$HOME/.zshrc"
        echo "Путь добавлен в ~/.zshrc. Перезапусти терминал."
    elif [ -f "$HOME/.bashrc" ]; then
        echo "export PATH=\$PATH:\$HOME/.local/bin" >> "$HOME/.bashrc"
        echo "Путь добавлен в ~/.bashrc. Перезапусти терминал."
    fi
    echo "--------------------------------------------------------"
fi

echo "✅ Готово! Запускай команду: $BINARY_NAME"
