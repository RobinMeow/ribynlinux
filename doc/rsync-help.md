# rsync help

just aquick ai prompt on what --archive does

---

It tells `rsync` to copy files **recursively** while preserving almost all file attributes, metadata, and symbolic links.

Using `--archive` is equivalent to combining these individual flags: **`-rlptgoD`**.

## Breakdown of What `--archive` Enables

* **`-r` (Recursive):** Traverses and copies directories and their contents subfolder by subfolder.
* **`-l` (Links):** Copies symbolic links as symbolic links rather than dereferencing them (i.e., it copies the shortcut itself, not the file the shortcut points to).
* **`-p` (Permissions):** Preserves the original file permissions (e.g., `755`, `644`), ensuring executable scripts retain their execute bits.
* **`-t` (Times):** Preserves modification times (`mtime`). This is crucial because it allows `rsync` to compare source and destination files accurately on subsequent runs without re-transferring files that haven't changed.
* **`-g` (Group):** Preserves the group ownership of the files.
* **`-o` (Owner):** Preserves the user ownership of the files (note: this typically requires running `rsync` with root/sudo privileges to take effect).
* **`-D` (Devices / Specials):** Preserves device files and special system files (equivalent to `--devices --specials`).

## Important Exception

While `--archive` covers almost everything needed for typical file syncing, it **does not** include **`-H` (hard links)**. If your source files use hard links that you need to preserve, you must append `--hard-links` or `-H` manually. For standard dotfiles and configuration directories (like your Hyprland setup), `--archive` is the gold standard because it keeps your script permissions and file structures intact.

---

so for syncing dotfiles this one is the goto:
`-rlpt`
