#!/bin/bash

echo "🔧 Починаємо встановлення dotfiles..."

# 0. Змінна для плагінів і тем
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# 1. Встановлюємо необхідне
sudo apt update
sudo apt install -y git zsh curl

# 2. Встановлюємо oh-my-zsh, якщо ще не встановлено
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "⚙️  Встановлюємо Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh вже встановлено."
fi

# 3. Копіюємо конфіг-файли
echo "📁 Копіюємо .zshrc, .p10k.zsh, .aliases.zsh..."
cp "$PWD/.zshrc" ~/
cp "$PWD/.p10k.zsh" ~/
cp "$PWD/.aliases.zsh" ~/

# 4. Тема Powerlevel10k
echo "🎨 Встановлюємо Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# 5. Плагіни
echo "🔌 Встановлюємо плагіни..."
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"
git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# 6. VS Code settings
echo "🧠 Копіюємо VS Code settings.json..."
mkdir -p ~/.config/Code/User
cp "$PWD/vscode/settings.json" ~/.config/Code/User/

# 7. Робимо zsh основною оболонкою
chsh -s $(which zsh)

echo "✅ Усе встановлено! Перезапусти термінал або введи: exec zsh"

# 8. Встановлюємо VS Code розширення
echo "🧩 Встановлюємо VS Code extensions..."
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension ritwickdey.liveserver
code --install-extension glenn2223.live-sass
code --install-extension pkief.material-icon-theme

