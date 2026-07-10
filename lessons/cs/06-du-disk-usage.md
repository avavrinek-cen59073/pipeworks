# Lekce 06: du: využití disku

## Cíl

Použít `du` k odpovědi na otázku „kolik místa to zabírá?“ u souborů a adresářů.

## Proč na tom záleží

Když na počítači nebo v projektu dojde místo, potřebujete klidný způsob, jak problém zužovat: nejdřív celý adresář, potom adresáře nejvyšší úrovně a nakonec jednotlivé soubory.

## Než začnete

Spusťte:

```sh
cd sandbox
```

## Mentální model

`du` hlásí využití disku: kolik místa v souborovém systému dané cesty spotřebují. Souvisí to s velikostí souboru, ale není to vždy totéž, protože souborové systémy přidělují místo po blocích.

Začněte zeširoka a pak zužujte:

```text
all sandbox -> top-level directories -> files in one directory
```

## Představené příkazy

```sh
du -sh PATH
du -h PATH
du -a PATH
du --max-depth=1 PATH
du -d 1 PATH
sort -h
```

Význam voleb:

- `-s`: shrne každý argument místo vypisování všech potomků.
- `-h`: jednotky čitelné pro člověka, například `K`, `M` nebo `G`.
- `-a`: zahrne soubory i adresáře.
- `--max-depth=1`: volba GNU/Linux pro jednu úroveň pod počáteční cestou.
- `-d 1`: volba macOS/BSD pro jednu úroveň pod počáteční cestou.
- `sort -h`: seřadí velikosti čitelné pro člověka.

## Cvičení 1: Změřte velikost sandboxu

Spusťte:

```sh
du -sh . > out/sandbox-size.txt
cat out/sandbox-size.txt
```

Co dělají jednotlivé části:

- `.` znamená aktuální adresář: `sandbox`.
- `-s` dá jeden souhrnný řádek.
- `-h` udělá velikost čitelnou pro člověka.

## Cvičení 2: Porovnejte adresáře nejvyšší úrovně

Použijte příkaz pro svůj systém.

GNU/Linux:

```sh
du -h --max-depth=1 . | sort -h > out/top-level-sizes.txt
```

macOS:

```sh
du -h -d 1 . | sort -h > out/top-level-sizes.txt
```

Potom výsledek prohlédněte:

```sh
cat out/top-level-sizes.txt
```

Důležitá myšlenka není přesná velikost. Jde o to naučit se poznat, který adresář je větší než ostatní.

## Cvičení 3: Najděte největší cesty v logách

Spusťte:

```sh
du -ah logs | sort -h | tail -n 5 > out/biggest-log-paths.txt
cat out/biggest-log-paths.txt
```

Význam pipeline:

- `du -ah logs` vypíše velikosti souborů a adresářů pod `logs`.
- `sort -h` seřadí od nejmenšího po největší.
- `tail -n 5` ponechá pět největších řádků.

## Cvičení 4: Porovnejte dvě oblasti

Spusťte:

```sh
du -sh reports logs > out/report-vs-log-size.txt
cat out/report-vs-log-size.txt
```

Tady `du` dostane dva argumenty: `reports` a `logs`. Pro každý argument vypíše jeden souhrn.

## Výzva

Vytvořte `out/data-size-summary.txt` s velikostmi pro `csv`, `json`, `configs` a `reports`.

## Když se něco pokazí

- Pokud `--max-depth` selže na macOS, použijte `-d 1`.
- Pokud `sort -h` není na starším systému dostupné, seřaďte bez `-h` a v této lekci berte výsledek jako přibližný.
- Pokud jsou velikosti drobné, je to v pořádku. Sandbox je záměrně malý; důležitý je pracovní postup.

## Poznámky ke kompatibilitě

`du` je jeden z příkazů, kde se GNU/Linux a macOS liší. Tato lekce ukazuje obě varianty pro hloubku na nejvyšší úrovni, protože v reálné práci jsou běžné obě.

## Zkontrolujte si

Ověřte, že `out/top-level-sizes.txt` obsahuje několik adresářů ze sandboxu.

## Další lekce

Příště propojíte příkazy pomocí rour a přesměrování.
