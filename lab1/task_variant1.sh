#!/usr/bin/env bash

TARGET_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Аналіз директорії: $TARGET_DIR"
echo "--------------------------------------------------"
echo "3 найважчі піддиректорії (у порядку зростання розміру):"

# Алгоритм:
# 1. Знаходимо тільки піддиректорії 1-го рівня у папці скрипта
# 2. Розраховуємо їх розмір у КБ за допомогою du -sk
# 3. Сортуємо за спаданням і вибираємо ТОП-3 найважчих
# 4. Повторно сортуємо отримані 3 елементи за зростанням
find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d -exec du -sk {} + 2>/dev/null | \
sort -rn | \
head -n 3 | \
sort -n | \
while read -r size dir; do
    dirname=$(basename "$dir")
    echo "$size KB - $dirname"
done
