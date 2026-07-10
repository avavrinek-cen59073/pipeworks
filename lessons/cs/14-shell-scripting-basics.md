# Lekce 14: Základy skriptování v shellu

## Cíl

Napsat malý Bash skript, který ověřuje vstup, cituje proměnné, jasně hlásí chyby a končí s užitečnými návratovými kódy.

## Proč na tom záleží

Skript je příkaz, který můžete opakovat. Dobrý skript vysvětlí, co potřebuje, a selže dřív, než začne dělat matoucí práci.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Vytvoříte `out/log-summary.sh`.

## Mentální model

Shellový skript je textový soubor interpretovaný shellem. První řádek, nazývaný shebang, říká operačnímu systému, který interpret má použít:

```sh
#!/usr/bin/env bash
```

Tento skript použije Bash, i když je váš interaktivní shell zsh.

## Představená syntaxe

```sh
#!/usr/bin/env bash
set -euo pipefail
variable=value
"$variable"
${1:-}
if [ condition ]; then ... fi
exit 2
```

Co tyto části znamenají:

- `set -euo pipefail`: přísnější chování při chybách. `-e` ukončí skript při mnoha selháních, `-u` odmítne nenastavené proměnné a `pipefail` zachytí selhání uvnitř pipelines.
- `log_file=${1:-}`: nastaví `log_file` na první argument, nebo na prázdnou hodnotu, pokud první argument neexistuje.
- `"$log_file"`: ocituje proměnnou, aby cesty s mezerami zůstaly jedním argumentem.
- `>&2`: zapíše zprávu na stderr.
- `exit 2`: zastaví skript se stavem 2. Mnoho skriptů používá 2 pro chyby použití.

## Cvičení 1: Vytvořte skript

Vytvořte `out/log-summary.sh` s tímto obsahem:

```sh
#!/usr/bin/env bash
set -euo pipefail

log_file=${1:-}
if [ -z "$log_file" ]; then
  printf 'Usage: %s LOGFILE\n' "${0##*/}" >&2
  exit 2
fi

if [ ! -f "$log_file" ]; then
  printf 'Missing file: %s\n' "$log_file" >&2
  exit 1
fi

printf 'File: %s\n' "$log_file"
printf 'ERROR lines: '
grep -c 'level=ERROR' "$log_file"
```

Před spuštěním si skript přečtěte. Dva bloky `if` ověřují vstup dřív, než se spustí `grep`.

## Cvičení 2: Nastavte ho jako spustitelný

Spusťte:

```sh
chmod +x out/log-summary.sh
```

Co to znamená: `chmod +x` přidá oprávnění ke spuštění, takže soubor půjde spustit jako příkaz.

## Cvičení 3: Spusťte ho se skutečným logem

Spusťte:

```sh
out/log-summary.sh logs/app-2026-06-01.log > out/log-summary-output.txt
cat out/log-summary-output.txt
```

Cesta k logu se uvnitř skriptu stane `$1`.

## Cvičení 4: Otestujte chybějící vstup

Spusťte:

```sh
out/log-summary.sh > out/log-summary-missing.txt 2>&1 || printf 'script rejected missing input\n'
cat out/log-summary-missing.txt
```

Co vás to naučí:

- Skript má odmítnout chybné použití.
- `2>&1` zachytí stderr a stdout do jednoho souboru.
- `||` spustí pravou stranu pouze tehdy, když skript skončí s nenulovým stavem.

## Výzva

Přidejte druhé počítání pro řádky `WARN`.

## Když se něco pokazí

- Pokud skript hlásí "Permission denied", spusťte `chmod +x out/log-summary.sh`.
- Pokud si `set -u` stěžuje na `$1`, použijte `${1:-}`, když argument může chybět.
- Pokud se rozbije název souboru s mezerami, zkontrolujte, že každé rozvinutí proměnné je ocitované.

## Poznámky ke kompatibilitě

Toto je Bash skript. Po `chmod +x` ho spusťte jako `out/log-summary.sh`, nebo výslovně pomocí `bash out/log-summary.sh ...`.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-14-shell-scripting-basics.sh
```

## Další lekce

Příště přidáte argumenty a volby skriptu.

