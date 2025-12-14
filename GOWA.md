GOWA – Custom Workflow Guide (Tokawa / WuzAPI Fork)

Dokumen ini menjelaskan alur kerja resmi branch `gowa`
untuk fork `tokalink/tokawa` dari upstream `asternic/wuzapi`.

Tujuan:
- Aman update dari upstream
- Custom tetap terjaga
- Minim konflik
- Cukup 1 perintah untuk update

==================================================

1. STRUKTUR BRANCH

main  : mirror upstream (asternic/wuzapi)
gowa  : branch custom (branding, config, patch)

JANGAN lakukan custom langsung di branch main.

==================================================

2. CLONE REPO PERTAMA KALI (DEVELOPER)

git clone https://github.com/tokalink/tokawa.git
cd tokawa

Tambahkan upstream (sekali saja):

git remote add upstream https://github.com/asternic/wuzapi.git
git fetch upstream

Cek remote:
git remote -v

==================================================

3. BUAT BRANCH CUSTOM GOWA

git checkout -b gowa

==================================================

4. ATURAN CUSTOM (WAJIB)

JANGAN DI-COMMIT:
.env
.env.*
docker-compose.override.yml (jika berisi secret)

BOLEH & DISARANKAN:
push.sh
deploy.sh
GOWA.md
custom-static/

==================================================

5. SCRIPT push.sh

push.sh melakukan:
- git status
- git add .
- git commit otomatis (pakai tanggal)
- sync upstream ke main
- rebase gowa
- push ke origin

Cara pakai:
./push.sh

==================================================

6. WORKFLOW HARIAN (DEVELOPER)

Setiap ada perubahan:
./push.sh

==================================================

7. CLONE DI SERVER LAIN (DEPLOY)

Disarankan (branch gowa saja):

git clone -b gowa --single-branch https://github.com/tokalink/tokawa.git
cd tokawa

Jika repo sudah ada:
git fetch origin
git checkout -b gowa origin/gowa

==================================================

8. UPDATE DI SERVER

git pull --rebase origin gowa

Jika pakai Docker:
docker compose up -d --build

==================================================

9. OPSIONAL: UPSTREAM DI SERVER

git remote add upstream https://github.com/asternic/wuzapi.git
git fetch upstream

==================================================

10. RINGKASAN ALUR

Developer:
edit -> ./push.sh -> selesai

Server:
git pull -> docker compose up -d

==================================================

11. CATATAN PENTING

- git push -f AMAN untuk branch gowa
- Jangan gunakan workflow ini di main
- Semua custom HARUS di gowa

==================================================

12. TROUBLESHOOTING

Jika working tree tidak bersih:
git status

Jika rebase conflict:
git rebase --continue

==================================================

Maintained by Tokalink
Custom branch: gowa
Upstream: asternic/wuzapi
