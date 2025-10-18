# 📤 Как запушить на GitHub

## ✅ Проект готов к push!

Все файлы добавлены в git и закоммичены.

---

## 🚀 Шаг 1: Создайте репозиторий на GitHub

1. Откройте https://github.com/new
2. Название репозитория: `agrosky-insight` (или любое другое)
3. Описание: **"Agricultural field monitoring with Sentinel-2 satellite data"**
4. **НЕ СТАВЬТЕ** галочки на Initialize with README
5. Нажмите **"Create repository"**

---

## 📤 Шаг 2: Запушьте код

После создания репозитория GitHub покажет команды. Выполните:

```bash
# Добавьте remote (замените YOUR_USERNAME на ваш GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/agrosky-insight.git

# Запушьте код
git push -u origin main
```

### Или если репозиторий уже существует:

```bash
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git
git push -u origin main
```

---

## 🔑 Что НЕ попало в Git (защищено .gitignore):

✅ **Ключи и секреты:**
- `.env` - ваши реальные ключи Sentinel Hub и Gemini
- `config.py` - конфигурация с ключами
- `*.db` - база данных SQLite

✅ **Лишние файлы:**
- `node_modules/` - зависимости Node.js
- `venv/` - виртуальное окружение Python
- `__pycache__/` - кеш Python
- `results/` - результаты анализа

---

## 📋 Что попало в Git:

✅ Весь исходный код (backend + frontend)
✅ Документация (все .md файлы)
✅ Docker конфигурация
✅ Зависимости (requirements.txt, package.json)
✅ Пример конфигурации (config.example.py)

---

## ⚠️ ВАЖНО: Перед push проверьте!

```bash
# Убедитесь, что .env не попал в git
git ls-files | grep -E "(\.env|config\.py)$"
```

Если команда ничего не вернула - отлично! Секреты не попадут в GitHub.

---

## 🎯 После push:

### 1. Добавьте описание репозитория:
- Topics: `agriculture`, `satellite-data`, `sentinel-2`, `ndvi`, `fastapi`, `react`, `docker`
- Website: (если есть демо)

### 2. Добавьте README shields:
В начало README.md можно добавить:

```markdown
![GitHub stars](https://img.shields.io/github/stars/YOUR_USERNAME/agrosky-insight)
![GitHub forks](https://img.shields.io/github/forks/YOUR_USERNAME/agrosky-insight)
![License](https://img.shields.io/badge/License-MIT-green)
```

### 3. Настройте GitHub Secrets (для CI/CD):
Если планируете деплой:
- Settings → Secrets → New repository secret
- Добавьте: `SENTINEL_CLIENT_ID`, `SENTINEL_CLIENT_SECRET`, `GEMINI_API_KEY`

---

## 🔄 Следующие изменения:

Когда будете вносить изменения:

```bash
git add .
git commit -m "Описание изменений"
git push
```

---

## 📞 Нужна помощь?

Если возникли проблемы:
- Проверьте SSH ключи: https://docs.github.com/en/authentication/connecting-to-github-with-ssh
- Или используйте HTTPS (GitHub попросит логин/пароль)

---

**Готово! Теперь запушьте командой выше! 🚀**

