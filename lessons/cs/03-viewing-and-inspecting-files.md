# Lekce 03: Zobrazování a zkoumání souborů

## Cíl

Prohlížet textové soubory, počítat řádky, zobrazit jen část souboru a před zpracováním rozpoznat typy souborů.

## Proč na tom záleží

Dobrá práce v terminálu začíná prohlídkou. Než budete soubor prohledávat, upravovat nebo archivovat, nejdřív zjistěte, co je uvnitř a jak je velký.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `logs/`, `reports/` a `archives/`.

## Mentální model

Příkazy pro prohlížení by neměly měnit soubory. Použijte je k zodpovězení otázek:

- Je tento soubor text?
- Je dost krátký na vypsání?
- Kolik má řádků?
- Jak vypadá začátek nebo konec?

## Představené příkazy

```sh
cat
less
head
tail
wc
file
```

Stavba příkazu:

- `cat FILE`: vypíše celý soubor. Nejlépe se hodí pro krátké soubory.
- `less FILE`: otevře posuvný prohlížeč. Ukončíte ho stisknutím `q`.
- `head -n N FILE`: vypíše prvních `N` řádků.
- `tail -n N FILE`: vypíše posledních `N` řádků.
- `wc -l FILE`: spočítá řádky. `-l` znamená řádky.
- `file PATH`: odhadne, jaký druh obsahu cesta obsahuje.

## Cvičení 1: Vypište krátký soubor

Spusťte:

```sh
cat reports/q1.txt
```

Tento soubor je krátký, takže `cat` dává smysl. Nepoužívejte `cat` naslepo na soubory, které jste neprozkoumali; některé logy mají tisíce nebo miliony řádků.

## Cvičení 2: Přečtěte jen začátek a konec

Spusťte:

```sh
head -n 3 logs/app-2026-06-01.log
tail -n 3 logs/app-2026-06-01.log
```

Co dělají jednotlivé části:

- `-n 3` znamená „zobraz 3 řádky“.
- `head` odpovídá na otázku „čím tento soubor začíná?“
- `tail` odpovídá na otázku „co se v tomto souboru stalo naposledy?“

## Cvičení 3: Spočítejte řádky logů

Spusťte:

```sh
wc -l logs/*.log > out/log-line-counts.txt
cat out/log-line-counts.txt
```

Čeho si všimnout:

- `logs/*.log` odpovídá logům na nejvyšší úrovni v `logs/`.
- `wc -l` vypíše počty řádků.
- Protože je předán více než jeden soubor, `wc` vypíše také řádek `total`.

## Cvičení 4: Rozpoznejte typy souborů

Spusťte:

```sh
file reports/q1.txt archives/* > out/file-types.txt
cat out/file-types.txt
```

`file` vám pomůže vyhnout se tomu, abyste s archivem zacházeli jako s obyčejným textem. Přesné znění se může lišit podle systému, ale měli byste umět rozeznat text od archivních dat.

## Výzva

Otevřete `logs/auth.log` pomocí `less`, vyhledejte `failed`, přejděte na další shodu a ukončete prohlížeč.

Nápovědy uvnitř `less`:

- `/failed` hledá dopředu.
- `n` přejde na další shodu.
- `q` ukončí prohlížeč.

## Když se něco pokazí

- Pokud se terminál zaplní příliš velkým množstvím textu, použijte místo `cat` příkaz `less`, `head` nebo `tail`.
- Pokud `archives/*` vypíše doslovný vzor, archivy možná neexistují. Spusťte `../tools/make-archives.sh` z kořene repozitáře a potom obnovte sandbox.
- Pokud vás výstup `wc -l` překvapí, pamatujte, že počítá řádky ukončené znakem nového řádku, ne „záznamy“ ve všech možných formátech.

## Zkontrolujte se

Ověřte, že tyto soubory existují a obsahují čitelný výstup:

```sh
out/log-line-counts.txt
out/file-types.txt
```

## Další lekce

Dále budete hledat text pomocí `grep`.

