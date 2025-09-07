PROFILE_DIR=~/.mozilla/firefox/z34ufndn.default
TMP_DB=/tmp/places.sqlite

cp "$PROFILE_DIR/places.sqlite" "$TMP_DB"

# Generate a temporary list of titles and matching URLs
sqlite3 "$TMP_DB" "
  SELECT REPLACE(b.title, '|', '¦') || '|' || p.url
  FROM moz_bookmarks b
  JOIN moz_places p ON b.fk = p.id
  WHERE b.type = 1 AND p.url LIKE 'http%'
  ORDER BY b.dateAdded DESC
  LIMIT 100;
" > /tmp/bookmark_list.txt

# Show titles in wofi, get user's selection
SELECTION=$(cut -d'|' -f1 /tmp/bookmark_list.txt | wofi --dmenu --prompt="Bookmarks" -c /home/simon/nixos-dotfiles/home/configfiles/wofi/config/config -s /home/simon/nixos-dotfiles/home/configfiles/wofi/src/mocha/style.css)

# Find the corresponding URL
URL=$(grep "^$SELECTION|" /tmp/bookmark_list.txt | cut -d'|' -f2-)

# Open the URL
[ -n "$URL" ] && firefox "$URL"
