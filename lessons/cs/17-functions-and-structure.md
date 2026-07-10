# Lekce 17: Funkce a struktura

## Cíl

Uspořádat Bash skript do malých funkcí pro použití, chyby, logování, ověřování a zpracování.

## Proč na tom záleží

Když skript vyroste nad několik řádků, začne záležet na struktuře. Funkce usnadňují vidět, co skript kontroluje, co vypisuje a kde se děje skutečná práce.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Vytvoříte `out/function-report.sh`.

## Mentální model

Funkce je pojmenovaný blok příkazů:

```sh
name() {
  commands
}
```

Funkce mohou přijímat argumenty stejně jako skripty: uvnitř funkce je `$1` první argument dané funkce.

Pro stav úspěchu/selhání používejte `return`. Když funkce potřebuje vypsat text, použijte stdout.

## Představená syntaxe

```sh
name() { ...; }
local variable=value
return 0
main "$@"
```

Co to znamená:

- `local` udrží proměnnou uvnitř funkce.
- `main "$@"` předá všechny argumenty skriptu funkci `main`.
- `die` je běžný název pro funkci, která vypíše chybu a ukončí skript.

## Cvičení 1: Vytvořte strukturovaný skript

Vytvořte `out/function-report.sh`:

```sh
#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s LOGFILE\n' "${0##*/}"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

log_info() {
  printf 'INFO: %s\n' "$*" >&2
}

main() {
  local log_file=${1:-}
  [ -n "$log_file" ] || { usage >&2; exit 2; }
  [ -f "$log_file" ] || die "missing file: $log_file"
  log_info "reading $log_file"
  grep -c 'level=ERROR' "$log_file"
}

main "$@"
```

Nejdřív ho čtěte podle názvů funkcí: použití, zpracování chyb, logování, hlavní pracovní postup.

## Cvičení 2: Spusťte skript

Spusťte:

```sh
chmod +x out/function-report.sh
out/function-report.sh logs/app-2026-06-02.log
```

Měli byste vidět informační zprávu a počet.

## Cvičení 3: Oddělte data od diagnostiky

Spusťte:

```sh
out/function-report.sh logs/app-2026-06-02.log > out/function-count.txt 2> out/function-debug.txt
cat out/function-count.txt
cat out/function-debug.txt
```

Funguje to proto, že počet se vypisuje na stdout, zatímco `log_info` vypisuje na stderr.

## Cvičení 4: Přidejte funkci pro zpracování

Přidejte tuto funkci:

```sh
print_error_lines() {
  local log_file=$1
  grep 'level=ERROR' "$log_file"
}
```

Potom ji zavolejte z `main` po vypsání počtu.

## Výzva

Přidejte funkci `validate_log_file` a přesuňte do ní kontrolu existence souboru.

## Když se něco pokazí

- Pokud proměnná uniká mezi funkcemi, použijte `local`.
- Pokud funkce používá `$1`, zkontrolujte, zda jste této funkci předali argument.
- Pokud se logy a data reportu míchají dohromady, posílejte diagnostiku na stderr pomocí `>&2`.

## Poznámky ke kompatibilitě

Tato lekce používá styl funkcí v Bashi a `local`. Pro takové skripty používejte Bash shebang.

## Zkontrolujte si

Ověřte, že stdout obsahuje data reportu a stderr obsahuje řádek logu `INFO:`.

## Další lekce

Příště budete ladit skripty a zlepšovat kvalitu shellového kódu.

