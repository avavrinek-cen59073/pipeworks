# Lekce 05: find: vyhledávání souborů

## Cíl

Používat `find` k vyhledávání souborů a adresářů podle názvu, typu, prázdnosti, velikosti, stáří a navazujících příkazů souvisejících s obsahem.

## Proč na tom záleží

`grep` hledá text uvnitř souborů. `find` hledá cesty. Mnoho skutečných úloh potřebuje obojí: nejdřív najít soubory a pak je prohlédnout nebo zpracovat.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `logs/`, `messy/` a `configs/`.

## Mentální model

`find START TESTS ACTIONS` prochází strom adresářů.

Příklad:

```sh
find logs -name '*.log' -type f -print
```

- `logs` je místo, kde procházení začíná.
- `-name '*.log'` ponechá cesty, jejichž názvy odpovídají vzoru.
- `-type f` ponechá běžné soubory.
- `-print` vypíše odpovídající cesty.

Pokud akci vynecháte, mnoho verzí `find` ve výchozím stavu vypisuje, ale zapsáním `-print` svůj záměr vyjádříte jasně.

## Představené příkazy

```sh
find . -name PATTERN
find . -iname PATTERN
find . -type f
find . -type d
find . -size SIZE
find . -mtime DAYS
find . -empty
find . -exec COMMAND {} \;
find . -print0
```

Význam voleb:

- `-name`: porovná vzor názvu souboru přesně tak, jak je zapsaný.
- `-iname`: porovná vzor názvu souboru bez ohledu na velikost písmen.
- `-type f`: jen běžné soubory.
- `-type d`: jen adresáře.
- `-size`: porovná velikost souboru.
- `-mtime`: porovná čas změny ve dnech.
- `-empty`: prázdné soubory nebo prázdné adresáře.
- `-exec ... {} \;`: spustí příkaz pro každou odpovídající cestu; `{}` se nahradí cestou.
- `-print0`: vypíše cesty oddělené nulovým bajtem pro bezpečné použití s `xargs -0`.

## Cvičení 1: Najděte logovací soubory

Spusťte:

```sh
find logs -name '*.log' -type f -print | sort > out/log-files.txt
cat out/log-files.txt
```

Proč na uvozovkách záleží: `'*.log'` se musí předat příkazu `find`. Pokud napíšete `*.log` bez uvozovek, shell ho může rozbalit dřív, než se `find` spustí.

## Cvičení 2: Najděte prázdné soubory

Spusťte:

```sh
find messy -type f -empty -print | sort > out/empty-files.txt
cat out/empty-files.txt
```

Tím najdete soubory, které obsahují nula bajtů. Soubor s řádkem, který jen vypadá prázdně, prázdný není; obsahuje znak nového řádku.

## Cvičení 3: Prohlédněte si kandidáty na úklid

Spusťte:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort > out/cleanup-preview.txt
cat out/cleanup-preview.txt
```

Co výraz znamená:

- `\(` a `\)` seskupují testy názvů. Zpětná lomítka zabrání shellu zacházet se závorkami speciálně.
- `-o` znamená OR.
- Příkaz kandidáty jen vypíše; nemaže je.

## Cvičení 4: Zkombinujte `find` s `grep`

Spusťte:

```sh
find configs -type f -exec grep -l 'old-db.internal' {} \; | sort > out/find-deprecated-configs.txt
cat out/find-deprecated-configs.txt
```

Co znamenají jednotlivé speciální části:

- `-exec grep -l ... {} \;` spustí `grep -l` jednou pro každý nalezený soubor.
- `{}` se nahradí aktuální cestou.
- `\;` označuje konec příkazu předaného `-exec`.

## Výzva

Najděte adresáře pod `messy/` a uložte je do `out/messy-directories.txt`.

## Když se něco pokazí

- Pokud `find` nic nevrátí, zkontrolujte nejdřív počáteční adresář: `find messy -maxdepth 1 -print`.
- Pokud závorky způsobí chybu shellu, ujistěte se, že jsou escapované jako `\(` a `\)`.
- Pokud názvy souborů s mezerami rozbijí pozdější příkaz, použijte `find ... -print0` a nástroj, který rozumí vstupu oddělenému nulami.

## Poznámky ke kompatibilitě

Testy použité ve cvičeních fungují na GNU/Linuxu i macOS. Některé pokročilé příklady s `-size`, `-mtime` a `-printf` nalezené online nejsou přenositelné; podívejte se do místního `man find`.

## Zkontrolujte se

Z kořene repozitáře:

```sh
./checks/check-05-find-locating-files.sh
```

## Další lekce

Dále budete sumarizovat využití disku pomocí `du`.

