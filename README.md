# wpm
Package Manager for Windows OS, like apt-get

**WARNING: version 0.1.0~0.1.2 not works because package modification on 2021/12/05.**

**Using latest versions are always recommended.**

**You SHOULD execute wpm as ADMIN (like apt-get only works in root).**

## Installation
1. Download wpm on Release tab
2. Make directory C:\wpm.
3. Type ``setx path "%PATH%;C:\wpm"`` on cmd.
4. Open cmd **as ADMIN** and type ``wpm /us`` (Do NOT type these on the directory C:\wpm in %PATH% testing).
5. If you see usages for wpm, installation was successful.
