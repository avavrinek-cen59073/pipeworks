# Lekce 04: grep: hledání textu

## Cíl

Používat `grep` k hledání odpovídajících řádků, ignorování velikosti písmen, zobrazování čísel řádků, obracení shod, prohledávání adresářů, vytažení odpovídajícího textu, počítání shod a vypsání souborů se shodou.

## Proč na tom záleží

Když prohlížíte logy nebo konfigurace, obvykle začínáte otázkami jako „kde to selhalo?“, „které soubory zmiňují tohoto hostitele?“ nebo „jak často se tento kód objevuje?“

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `logs/` a `configs/`.

## Mentální model

`grep PATTERN FILE...` čte řádky a vypisuje ty, které odpovídají `PATTERN`.

Výchozí chování:

- Vstup se kontroluje po jednom řádku.
- Řádek se vypíše, pokud obsahuje vzor.
- U více souborů `grep` obvykle před shody přidává názvy souborů.

## Představené příkazy

```sh
grep PATTERN FILE
grep -i PATTERN FILE
grep -n PATTERN FILE
grep -v PATTERN FILE
grep -R PATTERN DIR
grep -E PATTERN FILE
grep -o PATTERN FILE
grep -c PATTERN FILE
grep -l PATTERN FILE
```

Význam voleb:

- `-i`: ignoruje velikost písmen.
- `-n`: zobrazí čísla řádků.
- `-v`: obrátí shodu; vypíše řádky, které neodpovídají.
- `-R`: prohledává adresář rekurzivně.
- `-E`: použije rozšířené regulární výrazy.
- `-o`: vypíše jen odpovídající část, ne celý řádek.
- `-c`: vypíše počet odpovídajících řádků.
- `-l`: vypíše názvy souborů, které obsahují alespoň jednu shodu.
- `-h`: potlačí prefixy s názvy souborů při hledání ve více souborech.

## Cvičení 1: Najděte chybové řádky

Spusťte:

```sh
grep -h 'level=ERROR' logs/*.log > out/errors.txt
cat out/errors.txt
```

Čtěte zleva doprava:

- `grep` hledá.
- `-h` skryje názvy souborů, takže výstup obsahuje jen řádky logu.
- `'level=ERROR'` je vzor.
- `logs/*.log` prohledá logy na nejvyšší úrovni.
- `>` uloží shody do `out/errors.txt`.

## Cvičení 2: Přidejte hledání bez ohledu na velikost písmen a čísla řádků

Spusťte:

```sh
grep -hi 'failed' logs/*.log > out/failed-events.txt
grep -n 'failed' logs/auth.log
```

Co se změnilo:

- `-hi` kombinuje `-h` a `-i`: skryje názvy souborů a ignoruje velikost písmen.
- `-n` ukáže, kde se každá shoda v jednom souboru nachází.

## Cvičení 3: Vytáhněte a spočítejte chybové kódy

Spusťte:

```sh
grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq -c > out/error-codes.txt
cat out/error-codes.txt
```

Vzor znamená:

- `code=E` odpovídá doslovnému textu.
- `[0-9]` odpovídá jedné číslici.
- `[0-9]*` odpovídá nule nebo více dalším číslicím.

Pipeline znamená:

- `grep -o` vypíše jen kódy, například `code=E42`.
- `sort` seskupí stejné kódy vedle sebe.
- `uniq -c` spočítá sousedící opakované řádky.

## Cvičení 4: Vypište konfigurační soubory obsahující zastaralého hostitele

Spusťte:

```sh
grep -R -l 'old-db.internal' configs > out/deprecated-files.txt
cat out/deprecated-files.txt
```

Čeho si všimnout:

- `-R` hledá uvnitř `configs/` a jeho podadresářů.
- `-l` vypíše jen názvy souborů, což je užitečné, když plánujete pozdější úpravu.

## Výzva

Najděte všechny řádky logů na nejvyšší úrovni, které nejsou `INFO`, a uložte je do `out/not-info.log`.

Nápověda: použijte `-v`.

## Když se něco pokazí

- Pokud zapomenete uvozovky kolem vzoru obsahujícího `*`, `[` nebo mezery, shell ho může interpretovat dřív, než ho uvidí `grep`.
- Pokud `grep -c` vypíše jeden počet na soubor, je to normální. Počítá odpovídající řádky pro každý vstupní soubor.
- Pokud rekurzivní hledání vrátí příliš mnoho výsledků, prohledejte nejdřív užší adresář.

## Poznámky ke kompatibilitě

V tomto kurzu se vyhněte `grep -P`. Je specifický pro GNU a ve výchozím `grep` na macOS není dostupný. Pro regulární výrazy probírané zde používejte `grep -E`.

## Zkontrolujte se

Z kořene repozitáře:

```sh
./checks/check-04-grep-searching-text.sh
```

## Další lekce

Dále budete vyhledávat soubory pomocí `find`.

