#!/bin/bash

set -e

# =========================================================
# GENERATE DARK / PLAIN VERSIONS
#
# Source:
#     index.html
#     about/index.html
#     articles/index.html
#     ...
#
# Output:
#     d/index.html
#     d/about/index.html
#     ...
#
#     txt/index.html
#     txt/about/index.html
#     ...
#
# The nav3 theme block is replaced completely, so this does
# not depend on what links currently exist in the source file.
# =========================================================

PAGES=(
    ""
    "about"
    "articles"
    "bookmarks"
    "projects"
    "work"
    "visual"
    "resume"
)


# =========================================================
# Generate one page
# =========================================================

generate_page() {

    SOURCE="$1"
    OUTPUT="$2"
    MODE="$3"
    PAGE="$4"

    # -----------------------------------------------------
    # Determine paths
    # -----------------------------------------------------

    if [ -z "$PAGE" ]; then
        PREFIX="../"
    else
        PREFIX="../../"
    fi


    # -----------------------------------------------------
    # Theme links
    # -----------------------------------------------------

    if [ -z "$PAGE" ]; then

        if [ "$MODE" = "dark" ]; then
            THEME1="${PREFIX}txt/"
            TEXT1="plain HTML"

            THEME2="${PREFIX}"
            TEXT2="Light Mode"
        else
            THEME1="${PREFIX}"
            TEXT1="Light Mode"

            THEME2="${PREFIX}d/"
            TEXT2="Dark Mode"
        fi

    else

        if [ "$MODE" = "dark" ]; then
            THEME1="${PREFIX}txt/${PAGE}/"
            TEXT1="plain HTML"

            THEME2="${PREFIX}${PAGE}/"
            TEXT2="Light Mode"
        else
            THEME1="${PREFIX}${PAGE}/"
            TEXT1="Light Mode"

            THEME2="${PREFIX}d/${PAGE}/"
            TEXT2="Dark Mode"
        fi

    fi


    # -----------------------------------------------------
    # Replace ONLY nav3
    # -----------------------------------------------------

    sed \
        -e "/<nav3>/,/<\/nav3>/c\\
    <nav3>\\
        <details>\\
            <summary><a>Themes&ensp;&ensp;&ensp;&ensp;&ensp;</a></summary>\\
            <li><a href=\"${THEME1}\">${TEXT1}</a></li>\\
            <li><a href=\"${THEME2}\">${TEXT2}</a></li>\\
        </details>\\
    </nav3>" \
        "$SOURCE" > "$OUTPUT"

    echo "Generated: $OUTPUT"
}


# =========================================================
# Process all pages
# =========================================================

for PAGE in "${PAGES[@]}"; do

    if [ -z "$PAGE" ]; then

        SOURCE="index.html"

        DARK_FILE="d/index.html"
        TXT_FILE="txt/index.html"

    else

        SOURCE="$PAGE/index.html"

        DARK_FILE="d/$PAGE/index.html"
        TXT_FILE="txt/$PAGE/index.html"

    fi


    # -----------------------------------------------------
    # Check source
    # -----------------------------------------------------

    if [ ! -f "$SOURCE" ]; then
        echo "WARNING: $SOURCE not found - skipping"
        continue
    fi


    # -----------------------------------------------------
    # Create directories
    # -----------------------------------------------------

    mkdir -p "$(dirname "$DARK_FILE")"
    mkdir -p "$(dirname "$TXT_FILE")"


    # -----------------------------------------------------
    # Dark version
    # -----------------------------------------------------

    generate_page \
        "$SOURCE" \
        "$DARK_FILE" \
        "dark" \
        "$PAGE"


    # -----------------------------------------------------
    # Plain version
    # -----------------------------------------------------

    generate_page \
        "$SOURCE" \
        "$TXT_FILE" \
        "plain" \
        "$PAGE"

done


echo
echo "=========================================="
echo "Generation complete."
echo "=========================================="
