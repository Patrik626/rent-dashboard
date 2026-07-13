param(
  [Parameter(Mandatory=$true)]
  [string]$RemoteUrl
)

git init
git add .
git commit -m "Initial rent dashboard"
git branch -M main
git remote add origin $RemoteUrl
git push -u origin main
