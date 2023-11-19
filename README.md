# Repro

## Demonstration of the failure

### Steps

1. `make VIM=$path_to_vim9`.  This starts Vim.
2. `:let g:REPRO=1`
3. `lllll` to move the cursor to the `u` in line 1
4. `:FZF`
5. Hit Esc in the FZF popup.

### Expected

The cursor stays on the `u` in line 1.

### Observed

When the FZF popup closes, the cursor is back at column 1 of line 1 (`#`).

## Demonstration of a workaround

Exactly as above, but `:let g:REPRO=2` instead of `1`.  This uses
`let &l:tabstop` instead of `setbufvar(,'&tabstop')`.

### Observed

The cursor stays on the `u` in line 1.
