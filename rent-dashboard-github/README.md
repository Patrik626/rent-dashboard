[README.md](https://github.com/user-attachments/files/29962120/README.md)
# Rent Intelligence Dashboard - Slovakia

Interaktivny HTML dashboard pre prenajmy bytov zo stranky Nehnutelnosti.sk.

Projekt je pripraveny na GitHub Pages:

- `index.html` - samotny dashboard
- `data/offers.json` - data, ktore dashboard cita
- `scripts/scraper.py` - scraper, ktory prejde vsetky stranky pre dane mesto/stvrt/izbovost
- `config/locations.json` - mesta a stvrte, ktore sa maju scrapovat
- `.github/workflows/update-data.yml` - GitHub Actions workflow na automaticku aktualizaciu dat

## Ako to spustit lokalne

```bash
python -m http.server 8000
```

Potom otvor:

```text
http://localhost:8000
```

## Ako spustit scraper lokalne

```bash
pip install -r requirements.txt
python scripts/scraper.py --locations-file config/locations.json --rooms 1,2,3 --output data/offers.json --delay 1.5 --max-pages 50
```

Priklady:

```bash
# Len Bratislava + vsetky izbovosti
python scripts/scraper.py --cities Bratislava --rooms garsonka,1,2,3,4,5+ --output data/offers.json

# Len Ruzinov a Petrzalka, len 3 izbove byty
python scripts/scraper.py --locations bratislava-ruzinov,bratislava-petrzalka --rooms 3 --output data/offers.json

# Len Kosice Stare Mesto, 1 az 3 izbove byty
python scripts/scraper.py --locations kosice-stare-mesto --rooms 1,2,3 --output data/offers.json
```

## Ako upravit mesta a stvrte

Zakladny subor je:

```text
config/locations.json
```

Sirsia verzia s viac ako 100 mestami je v:

```text
config/locations_slovakia_more.json
```

Ak chces pouzit sirsie Slovensko, spusti scraper takto:

```bash
python scripts/scraper.py --locations-file config/locations_slovakia_more.json --rooms 1,2,3 --output data/offers.json
```

Otvor subor:

```text
config/locations.json
```

Kazda lokalita ma tvar:

```json
{"city":"Bratislava","district":"Ruzinov","slug":"bratislava-ruzinov","enabled":true}
```

- `city` je nazov mesta v dashboarde
- `district` je nazov stvrte / mestskej casti v dashboarde
- `slug` je cast URL na Nehnutelnosti.sk
- `enabled` urcuje, ci sa lokalita bude scrapovat

## Ako to dat na GitHub Pages

1. Vytvor nove GitHub repository, napr. `rent-dashboard`.
2. Nahraj vsetky subory z tohto projektu do repository.
3. V repository otvor `Settings` -> `Pages`.
4. Ako source vyber `Deploy from a branch`.
5. Vyber branch `main` a folder `/root`.
6. Uloz nastavenie.
7. Po publikovani bude dashboard dostupny cez GitHub Pages URL.

## Automaticka aktualizacia dat

Workflow je v:

```text
.github/workflows/update-data.yml
```

Da sa spustit manualne cez GitHub:

```text
Actions -> Update rent data -> Run workflow
```

Aktualne je nastavene denne spustenie o 05:00 UTC.

## Dolezite poznamky

- Nehnutelnosti.sk moze menit HTML strukturu. Ak sa data prestanu citat, treba upravit `parse_offers_from_html()` v `scripts/scraper.py`.
- Scraper nepouziva interny API endpoint a neobchadza ochrany webu.
- Nepouzivaj prilis kratky `--delay`. Odporucanie: aspon 1 az 2 sekundy medzi requestmi.
- Pri velkom rozsahu lokalit a izbovosti moze beh trvat dlhsie.
