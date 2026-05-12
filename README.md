# dilmun-reading-coach

## Upload local project folder

To upload `C:\Users\zaina\Desktop\DilmunReading` into this repository:

1. Open Git Bash (or Command Prompt).
2. Run:

```bash
cd C:\Users\zaina\Desktop\DilmunReading
git init
git branch -M main
git remote add origin https://github.com/zuzu1022/dilmun-reading-coach.git
git add .
git commit -m "Initial upload"
git push -u origin main
```

If the remote already exists, use:

```bash
git remote set-url origin https://github.com/zuzu1022/dilmun-reading-coach.git
```
