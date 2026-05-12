# dilmun-reading-coach

## Upload local project folder

To upload your local folder into this repository (for example, `C:\Users\zaina\Desktop\DilmunReading`):

1. Open Git Bash (or Command Prompt).
2. Run:

```bash
cd /c/Users/zaina/Desktop/DilmunReading
git init
git branch -M main
git remote add origin https://github.com/zuzu1022/dilmun-reading-coach.git
git add .
git commit -m "Initial upload"
git push -u origin main
```

If `git push` is rejected because remote `main` already has commits, run:

```bash
git pull --rebase origin main
git push -u origin main
```

If rebase conflicts appear, resolve them, then continue with:

```bash
git add .
git rebase --continue
git push -u origin main
```

If the remote already exists, use:

```bash
git remote set-url origin https://github.com/zuzu1022/dilmun-reading-coach.git
```
