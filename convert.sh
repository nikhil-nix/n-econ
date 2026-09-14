#!/bin/bash

set -e

# =========================================================
# UPDATE HEADER IN ALL NESTED INDEX.HTML FILES
#
# EXCLUDED:
#   index.html
#   d/index.html
#   txt/index.html
#
# THEME SWITCHING PRESERVES THE CURRENT PAGE.
# =========================================================

PAGES=(
    "about"
    "articles"
    "bookmarks"
    "projects"
    "work"
    "visual"
    "resume"
)


update_header() {

    FILE="$1"
    PREFIX="$2"
    PAGE="$3"

    # -----------------------------------------------------
    # Theme paths
    # -----------------------------------------------------

    if [ -z "$PAGE" ]; then

        LIGHT="${PREFIX}txt/"
        DARK="${PREFIX}d/"

    else

        LIGHT="${PREFIX}txt/${PAGE}/"
        DARK="${PREFIX}d/${PAGE}/"

    fi


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
                <li><a href=\"${PREFIX}resume\" target=\"_parent\">Resume</a></li>\\
                <li><a href=\"https://git.fosscommunity.in/on2\" target=\"_parent\">/git/</a>: packages</li>\\
                    ........................\\
                <li><a href=\"${PREFIX}projects\" target=\"_parent\">Projects/Reports</a></li>\\
                <li><a href=\"${PREFIX}work#work\" target=\"_parent\">Work with me</a></li>\\
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
            <li><a href=\"${LIGHT}\">plain HTML</a></li>\\
            <li><a href=\"${DARK}\">Dark Mode</a></li>\\
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
            <li><a href=\"${PREFIX}content\" target=\"_parent\">Visuals</a></li>\\
            <li><a href=\"${PREFIX}bookmarks\" target=\"_parent\">Bookmarks</a></li>\\
            <li><a href=\"${PREFIX}resume\" target=\"_parent\">Resume</a></li>\\
            <li><a href=\"https://git.fosscommunity.in/on2\" target=\"_parent\">/git/</a></li>\\
            <li><a href=\"${PREFIX}projects\" target=\"_parent\">Projects/Reports</a></li>\\
            <li><a href=\"${PREFIX}work#work\" target=\"_parent\">Work with me</a></li>\\
        </ul>\\
    </nav>\\
\\
</header>" "$FILE"

    echo "Updated: $FILE"
}


# =========================================================
# NORMAL PAGES
#
# Example:
# about/index.html
#
# PREFIX = ../
# LIGHT  = ../txt/about/
# DARK   = ../d/about/
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../" "$PAGE"
    else
        echo "Missing: $FILE"
    fi

done


# =========================================================
# DARK MODE PAGES
#
# Example:
# d/about/index.html
#
# PREFIX = ../../
# LIGHT  = ../../txt/about/
# DARK   = ../../d/about/
#
# Both links preserve the current page.
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="d/$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../../" "$PAGE"
    else
        echo "Missing: $FILE"
    fi

done


# =========================================================
# PLAIN HTML PAGES
#
# Example:
# txt/about/index.html
#
# PREFIX = ../../
# LIGHT  = ../../txt/about/
# DARK   = ../../d/about/
# =========================================================

for PAGE in "${PAGES[@]}"; do

    FILE="txt/$PAGE/index.html"

    if [ -f "$FILE" ]; then
        update_header "$FILE" "../../" "$PAGE"
    else
        echo "Missing: $FILE"
    fi

done


echo
echo "Header update complete."
