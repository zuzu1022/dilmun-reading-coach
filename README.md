# dilmun-reading-coach

## Upload local project folder

To upload your local folder into this repository (replace `<username>` with your Windows username; for example, `C:\Users\<username>\Desktop\DilmunReading`, which is `/c/Users/<username>/Desktop/DilmunReading` in Git Bash):

1. Open Git Bash.
2. Run:

```bash
cd /c/Users/<username>/Desktop/DilmunReading
git init
git branch -M main
git remote add origin https://github.com/zuzu1022/dilmun-reading-coach.git
git add .
git commit -m "Initial upload"
git push -u origin main
```

If `git remote add origin ...` fails with `remote origin already exists`, run:

```bash
git remote set-url origin https://github.com/zuzu1022/dilmun-reading-coach.git
```

If `git push` is rejected because remote `main` already has commits, run:

```bash
git fetch origin
git pull --rebase origin main
git push -u origin main
```

If rebase conflicts appear, resolve them, then continue with:

```bash
git status
git add .
git rebase --continue
git push -u origin main
```
