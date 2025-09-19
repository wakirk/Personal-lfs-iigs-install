#!/bin/bash

MENU_COUNT=0

# Arrays, indexed 0..MENU_COUNT-1
#   MENU_FUNCS[i]  => function name (string)
#   MENU_FILES[i]  => file (string, may be "")
#   MENU_NAMES[i]  => display label (string)
#   MENU_STATE[i]  => status char: ' ', '*', or 'E'
declare -a MENU_FUNCS
declare -a MENU_FILES
declare -a MENU_NAMES
declare -a MENU_STATE



# ---------------------------------------
# Utility: print error messages to stderr
# ---------------------------------------
_menu_err() {
    local msg="$1"
    >&2 echo "$msg"
}

# ------------------------------------------------------
# TSV parsing helpers (strict format, clear error text)
# ------------------------------------------------------

_menu_is_valid_identifier() {
    local name="$1"
    # Bash identifier: start with letter or underscore, then letters/digits/underscore
    case "$name" in
        [A-Za-z_][A-Za-z0-9_]*) return 0 ;;
        *) return 1 ;;
    esac
}

# Strictly split a line into exactly 3 tab-separated fields.
# Returns 0 on success, non-zero on any format violation.
# Sets out variables by name (passed as $2, $3, $4).
_menu_split_tsv_line() {
    local line="$1"
    local __out_fn="$2"
    local __out_file="$3"
    local __out_label="$4"

    # Count tabs; there must be exactly 2.
    local tab_count=0
    local tmp="$line"
    # Count manually to keep the code obvious.
    while : ; do
        case "$tmp" in
            *$'\t'*) tab_count=$((tab_count + 1)); tmp="${tmp#*$'\t'}" ;;
            *) break ;;
        esac
    done
    if [ "$tab_count" -ne 2 ]; then
        return 1
    fi

    # Extract fields
    local f1="${line%%$'\t'*}"
    local rest="${line#*$'\t'}"
    local f2="${rest%%$'\t'*}"
    local f3="${rest#*$'\t'}"

    # Assign by indirection
    printf -v "$__out_fn"   "%s" "$f1"
    printf -v "$__out_file" "%s" "$f2"
    printf -v "$__out_label" "%s" "$f3"

    return 0
}

_menu_fn_already_seen() {
    local name="$1"
    local i=0
    while [ "$i" -lt "$MENU_COUNT" ]; do
        if [ "${MENU_FUNCS[$i]}" = "$name" ]; then
            return 0
        fi
        i=$((i + 1))
    done
    return 1
}

# ----------------------------------------------
# Parse the TSV into arrays; enforce strictness.
# Stops the program for fatal errors per spec.
# ----------------------------------------------
_menu_parse_tsv() {
    local path="$1"
    local line_no=0
    local fn=""
    local file=""
    local label=""

    MENU_COUNT=0
    unset MENU_FUNCS MENU_FILES MENU_NAMES MENU_STATE
    declare -a MENU_FUNCS
    declare -a MENU_FILES
    declare -a MENU_NAMES
    declare -a MENU_STATE

    if [ ! -f "$path" ]; then
        _menu_err "TSV File Error: cannot open '$path'"
        # Return code handled by caller (menu_setup -> exit or return code 2)
        return 2
    fi

    # Read file line-by-line, no tolerance for blanks/comments.
    # We intentionally do not ignore spaces; the format is strict.
    while IFS= read -r line; do
        line_no=$((line_no + 1))

        # Disallow completely empty lines
        if [ -z "$line" ]; then
            _menu_err "Format Error (line $line_no): empty line is not allowed."
            return 3
        fi

        # Split into exactly 3 fields
        if ! _menu_split_tsv_line "$line" fn file label; then
            _menu_err "Format Error (line $line_no): expected exactly 3 tab-separated fields."
            return 3
        fi

        # Validate function name field
        if [ -z "$fn" ]; then
            _menu_err "Format Error (line $line_no): missing Function_name."
            return 3
        fi
        if ! _menu_is_valid_identifier "$fn"; then
            _menu_err "Format Error (line $line_no): invalid Function_name '$fn'."
            return 3
        fi

        # Validate display name (required, must not contain tabs, already split)
        if [ -z "$label" ]; then
            _menu_err "Format Error (line $line_no): Display_Name is required."
            return 3
        fi

        # File_name may be empty (no further validation here)

        # Enforce uniqueness on function name
        if _menu_fn_already_seen "$fn"; then
            _menu_err "Format Error (line $line_no): duplicate Function_name '$fn'."
            return 3
        fi

        MENU_FUNCS+=("$fn")
        MENU_FILES+=("$file")
        MENU_NAMES+=("$label")
        MENU_STATE+=(" ")    # default: incomplete
        MENU_COUNT=$((MENU_COUNT + 1))
    done < "$path"

    return 0
}

# --------------------------------------------
# Validate that required callbacks exist now.
# Stop at the first missing and HALT per spec.
# --------------------------------------------
_menu_validate_callbacks_or_halt() {
    local i=0
    while [ "$i" -lt "$MENU_COUNT" ]; do
        local fn="${MENU_FUNCS[$i]}"
        if ! declare -F -- "$fn" >/dev/null 2>&1; then
            _menu_err "Menu System Load Error: Function [$fn] is missing in the host, please correct and restart."
            read     # DEBUG
            exit 1
        fi
        i=$((i + 1))
    done
}


# 0) define the two callbacks the TSV mentions
test_func()  { 
  echo "test_func ok";
  return 1; 
}

test_func2() { 
  echo "test_func2 ok"; 
  return 1; 
}

# 1) paste in (only) the functions listed above + the array declarations

# 2) parse and validate
_menu_parse_tsv "/root/lfs/mainmenu.tsv" || exit $?
_menu_validate_callbacks_or_halt
echo "Parser+validator: OK (MENU_COUNT=$MENU_COUNT)"
printf 'Row1: fn=%s file=%s label=%s\n' "${MENU_FUNCS[0]}" "${MENU_FILES[0]}" "${MENU_NAMES[0]}"
printf 'Row2: fn=%s file=%s label=%s\n' "${MENU_FUNCS[1]}" "${MENU_FILES[1]}" "${MENU_NAMES[1]}"


