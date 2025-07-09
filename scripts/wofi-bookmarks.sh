PROFILE_DIR=~/.mozilla/firefox/z34ufndn.default
TMP_DB=/tmp/places.sqlite

cp "$PROFILE_DIR/places.sqlite" "$TMP_DB"

sqlite3 "$TMP_DB" "
  SELECT b.title || ' — ' || p.url
  FROM moz_bookmarks b
  JOIN moz_places p ON b.fk = p.id
  WHERE b.type = 1 AND p.url LIKE 'http%'
  ORDER BY b.dateAdded DESC
  LIMIT 100;
" | wofi --dmenu --prompt="Bookmarks" | awk -F ' — ' '{print $NF}' | xargs -r firefox
