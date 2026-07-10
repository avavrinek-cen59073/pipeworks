# Lekce 16: Podmínky a cykly

## Cíl

Používat podmínky, `case`, cykly `for` a bezpečné cykly `while read` ke zpracování souborů a řádků.

## Proč na tom záleží

Skripty potřebují rozhodovat a opakovat práci. Nejtěžší je dělat to tak, aby se nerozbily na mezerách, prázdných řádcích nebo komentářích.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `configs/`, `logs/` a `messy/`.

## Mentální model

Existují dva různé problémy s cykly:

- Procházet seznam vytvořený shellem, například `logs/*.log`.
- Procházet vstupní řádky nebo cesty vytvořené jiným příkazem.

Pro libovolné názvy souborů dávejte přednost cyklům odděleným nulovým znakem:

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  ...
done
```

## Představená syntaxe

```sh
if ...; then ... elif ...; else ...; fi
[[ ... ]]
for file in pattern; do ... done
while IFS= read -r line; do ... done
case "$value" in pattern) ... ;; esac
```

Co jednotlivé části znamenají:

- `if` vybírá podle úspěchu nebo selhání příkazu.
- `for file in logs/*.log` se zopakuje jednou pro každou odpovídající cestu.
- `while read` zpracovává vstup po jednom řádku.
- `IFS=` brání ořezávání úvodních a koncových bílých znaků.
- `read -r` brání tomu, aby se zpětná lomítka interpretovala jako escape sekvence.
- `case` se hodí pro několik větví založených na vzorech.

## Cvičení 1: Projděte soubory logů

Spusťte:

```sh
for file in logs/*.log; do
  printf '%s: ' "$file"
  grep -c 'level=ERROR' "$file"
done > out/errors-per-log.txt
cat out/errors-per-log.txt
```

Čeho si všimnout:

- `file` je název proměnné, který jste si zvolili.
- `"$file"` je ocitované pokaždé, když se používá.
- Celý cyklus zapisuje do jednoho výstupního souboru.

## Cvičení 2: Přeskočte komentáře a prázdné řádky

Spusťte:

```sh
while IFS= read -r line; do
  case "$line" in
    ''|\#*) continue ;;
    *) printf '%s\n' "$line" ;;
  esac
done < configs/app.conf > out/app-active-lines.txt
cat out/app-active-lines.txt
```

Význam vzorů:

- `''` odpovídá prázdnému řádku.
- `\#*` odpovídá řádku začínajícímu znakem `#`.
- `continue` přeskočí na další průchod cyklem.

## Cvičení 3: Ošetřete názvy souborů s mezerami

Spusťte:

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  printf '%s\n' "$file"
done > out/all-messy-files.txt
cat out/all-messy-files.txt
```

Tím se cesty jako `messy/spaces in names/quarterly draft.txt` zpracují jako jedna cesta.

## Cvičení 4: Sestavte vícesekční report

Spusťte:

```sh
{
  printf 'Errors per log\n'
  cat out/errors-per-log.txt
  printf '\nActive app config\n'
  cat out/app-active-lines.txt
} > out/multi-section-report.txt
cat out/multi-section-report.txt
```

Složené závorky seskupí několik příkazů, takže jedno přesměrování zapíše celý report.

## Výzva

Přidejte sekci se seznamem dočasných a záložních souborů.

## Když se něco pokazí

- Pokud se cesty s mezerami rozdělí, necyklujte přes `$(find ...)`; použijte `find -print0`.
- Pokud zůstávají řádky komentářů, zkontrolujte vzory v `case`.
- Pokud do souboru zapisuje jen poslední příkaz, dejte přesměrování za uzavírací `}`.

## Poznámky ke kompatibilitě

`read -d ''` a `[[ ... ]]` jsou funkce Bashe. Pro skripty, které na nich závisí, používejte Bash.

## Zkontrolujte si

Ověřte, že `out/multi-section-report.txt` má víc než jednu sekci a že cesty s mezerami zůstávají tam, kde je to relevantní, neporušené.

## Další lekce

Příště budete skripty organizovat pomocí funkcí.

