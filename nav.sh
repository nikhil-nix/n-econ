#!/bin/bash

set -e

# =========================================================
# UPDATE HEADER IN ALL PAGE INDEX FILES
#
# EXCLUDED:
#   ./index.html
#   ./d/index.html
#   ./txt/index.html
#
# ONLY THE HEADER BLOCK IS REPLACED.
# =========================================================

PAGES=(
    "about"
    "articles"
    "bookmarks"
    "project"
    "work"
    "visual"
    "resume"
)

# ---------------------------------------------------------
# Header generator
# ---------------------------------------------------------

update_header() {

    FILE="$1"
    PREFIX="$2"

    sed -i "/<header class=\"ccsticky-nav\">/,/<\/header>/c\\
<header class=\"ccsticky-nav\">\\
\\
    <!-- ================================\\
         DESKTOP NAVIGATION\\
         ================================ -->\\
\\
    <nav class=\"desktop-nav\">\\
        <details open>\\
            <summary><a>Links</a></summary>\\
                ................................\\
            <ul>\\
                <li><a href=\"${PREFIX}\" target=\"_parent\">Home</a></li>\\
                <li><a href=\"${PREFIX}about/\" target=\"_parent\">About Me</a></li>\\
                <li><a href=\"${PREFIX}content\" target=\"_parent\">Visual</a></li>\\
                <li><a href=\"${PREFIX}bookmarks\" target=\"_parent\">Bookmarks</a></li>\\
                    ....................\\
                <li><a href=\"${PREFIX}resume\" target=\"_parent\">Resume</a></li>\\
                <li><a href=\"${PREFIX}work#work\" target=\"_parent\">work with me</a></li>\\
                    ........................\\
                <li><a href=\"https://git.fosscommunity.in/on2\" target=\"_parent\">/git/</a>: packages</li>\\
                <li><a href=\"${PREFIX}project\" target=\"_parent\">Projects/Reports</a></li>\\
            </ul>\\
                ................................\\
        </details>\\
    </nav>\\
\\
\\
    <!-- ================================\\
         DESKTOP THEME NAVIGATION\\
         ================================ -->\\
\\
    <nav3>\\
        <details>\\
            <summary><a>Themes&ensp;&ensp;&ensp;&ensp;&ensp;</a></summary>\\
            <li><a href=\"${PREFIX}txt/\">plain HTML</a></li>\\
            <li><a href=\"${PREFIX}d/\">Dark Mode</a></li>\\
        </details>\\
    </nav3>\\
\\
\\
    <!-- ================================\\
         MOBILE NAVIGATION\\
         ================================ -->\\
\\
    <nav class=\"mobile-nav\">\\
        <ul>\\
            <li><a href=\"${PREFIX}\" target=\"_parent\">Home</a></li>\\
            <li><a href=\"${PREFIX}about/\" target=\"_parent\">About Me</a></li>\\
            <li><a href=\"${PREFIX}content\" target=\"_parent\">Visual</a></li>\\
            <li><a href=\"${PREFIX}bookmarks\" target=\"_parent\">Bookmarks</a></li>\\
            <li><a href=\"${PREFIX}resume\" target=\"_parent\">Resume</a></li>\\
            <li><a href=\"${PREFIX}work#work\" target=\"_parent\">work with me</a></li>\\
            <li><a href=\"https://git.fosscommunity.in/on2\" target=\"_parent\">/git/</a></li>\\
            <li><a href=\"${PREFIX}project\" target=\"_parent\">Projects/Reports</a></li>\\
        </ul>\\
    </nav>\\
\\
</header>" "$FILE"

    echo "Updated: $FILE"
}


# =========================================================
# ROOT PAGES
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../"
    else
        echo "Missing: $FILE"
    fi

done


# =========================================================
# DARK MODE PAGES
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="d/$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../../"
    else
        echo "Missing: $FILE"
    fi

done


# =========================================================
# PLAIN HTML PAGES
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="txt/$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../../"
    else
        echo "Missing: $FILE"
    fi

done


echo
echo "Header update complete."
