# vim-open-explorer
A plugin for Windows that opens windows explorer with the current file focused

## Requirements

- Windows OS
- `cygpath` utility (usually included with Git for Windows or Cygwin)

The plugin uses `cygpath` to convert Unix-style or Windows paths to a format suitable for Windows Explorer. It will attempt to use `cygpath` from your system `PATH`, and if not found, will try `C:/Program Files/Git/usr/bin/cygpath.exe` (the default location for Git Bash).

## Usage

    :Explorer           " Opens Explorer with the current file focused
    :Explorer <folder>  " Opens Explorer at the specified folder (any path style)

## Troubleshooting

- **Explorer does not open or errors about cygpath:**
  - Ensure `cygpath` is installed. It comes with Git for Windows (Git Bash) and Cygwin.
  - Make sure `cygpath.exe` is in your system `PATH`, or is located at `C:/Program Files/Git/usr/bin/cygpath.exe`.
  - You can test by running `cygpath -wa /tmp` in a terminal. It should output a Windows path.
- **Explorer opens but not at the expected location:**
  - Check that the path you provide is valid and accessible.
  - Try using an absolute path or a path style compatible with your environment.
- **Still having issues?**
  - Open an issue on the GitHub repository with details about your OS, Vim version, and any error messages.

## License
MIT
