# Lekce 20: Pokročilé shellové vzory

## Cíl

Používat dočasné adresáře, trapy, pole, seskupování příkazů, subshelly a kompromisy přísného režimu pro psaní bezpečnějších Bash skriptů.

## Proč na tom záleží

Pokročilé shellové skriptování není o zkracování příkazů. Jde o to, aby selhání byla bezpečnější a skripty srozumitelné, až se k nim později vrátíte.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Vytvoříte `out/advanced-report.sh`.

## Mentální model

Robustní skripty spravují zdroje:

- vstupy;
- výstupy;
- dočasné soubory;
- úklid;
- zpracování chyb.

Pokud skript vytvoří dočasný adresář, měl by ho odstranit bez ohledu na to, zda skript uspěje nebo selže.

## Představená syntaxe

```sh
mktemp -d
trap cleanup EXIT
array=(one two three)
"${array[@]}"
{ command1; command2; } > file
( cd dir && command )
```

Co tyto části znamenají:

- `mktemp -d`: vytvoří jedinečný dočasný adresář.
- `trap cleanup EXIT`: spustí `cleanup`, když skript skončí.
- `array=(...)`: pole v Bash.
- `"${array[@]}"`: bezpečně expanduje prvky pole jako samostatné argumenty.
- `{ ...; } > file`: seskupí příkazy a přesměruje jejich společný výstup.
- `( ... )`: spustí příkazy v subshellu, takže změny adresáře neovlivní nadřazený shell.

## Cvičení 1: Vytvořte a odstraňte dočasný pracovní prostor

Spusťte:

```sh
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
printf '%s\n' "$tmp_dir" > out/temp-workspace.txt
rm -rf "$tmp_dir"
```

Co to znamená:

- `$(...)` zachytí výstup příkazu.
- `${TMPDIR:-/tmp}` použije `$TMPDIR`, pokud je nastavená, jinak `/tmp`.
- Část `XXXXXX` nahradí `mktemp`, aby vznikla jedinečná cesta.

## Cvičení 2: Přidejte úklid pomocí trapu

Vytvořte `out/advanced-report.sh`:

```sh
#!/usr/bin/env bash
set -euo pipefail

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

printf 'temporary workspace: %s\n' "$tmp_dir" >&2
grep -h 'level=ERROR' logs/*.log > "$tmp_dir/errors.log"
wc -l "$tmp_dir/errors.log"
```

Proč je to bezpečnější: `cleanup` se spustí, i když pozdější příkaz selže.

## Cvičení 3: Použijte pole v Bash

Přidejte toto do skriptu nebo to spusťte interaktivně v Bash:

```sh
sections=(errors warnings failures)
printf '%s\n' "${sections[@]}"
```

Pole jsou užitečná, když potřebujete seznam, ve kterém musí každá položka zůstat samostatná.

## Cvičení 4: Seskupte příkazy do jednoho reportu

Spusťte:

```sh
{
  printf '# Advanced report\n\n'
  printf '## Error count\n'
  grep -h 'level=ERROR' logs/*.log | wc -l
  printf '\n## Deprecated configs\n'
  grep -R -l 'old-db.internal' configs
} > out/advanced-report.md
cat out/advanced-report.md
```

Složené závorky umožňují použít jedno přesměrování na celý blok.

## Výzva

Porovnejte pole v Bash se seznamem názvů souborů odděleným novými řádky. Které řešení je bezpečnější pro názvy souborů s mezerami? Kdy by bylo `find -print0` bezpečnější než obě možnosti?

## Když se něco pokazí

- Pokud úklid odstraní nesprávnou cestu, před mazáním vypište dočasnou cestu na stderr a dejte `"$tmp_dir"` do uvozovek.
- Pokud se skript s polem spustí pomocí `sh`, selže. Použijte shebang pro Bash.
- Pokud přísný režim skončí dříve, než čekáte, zjistěte, který příkaz vrátil nenulový stav, a rozhodněte, zda je takové selhání přijatelné.

## Poznámky ke kompatibilitě

Pole v Bash jsou specifická pro Bash. zsh má také pole, ale indexování a chování se liší. Skripty v této lekci by měly používat `#!/usr/bin/env bash`.

## Zkontrolujte se

Spusťte:

```sh
bash -n out/advanced-report.sh
bash out/advanced-report.sh
```

## Další lekce

Dále dokončíte závěrečné výzvy s minimem nápovědy.

