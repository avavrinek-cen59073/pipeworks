# Lekce 18: Ladění a kvalita

## Cíl

Ladit shellové skripty pomocí kontroly syntaxe, trasování běhu, oprav problémů s uvozovkami a nahrazování nebezpečných akcí náhledy.

## Proč na tom záleží

Shellové skripty často selhávají z důvodů, které nejsou snadno vidět: prázdná proměnná, název souboru s mezerami, glob, který odpovídal příliš mnoha souborům, nebo chybová zpráva skrytá v nesprávném proudu.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete prohlížet skripty v `scripts/` a vytvářet opravené kopie v `out/`.

## Mentální model

Laďte po vrstvách:

1. Syntaxe: dokáže Bash skript zpracovat?
2. Trasování: jaké příkazy Bash ve skutečnosti spouští?
3. Data: jaké hodnoty proměnné obsahují?
4. Bezpečnost: mohl by tento příkaz ovlivnit více souborů, než bylo zamýšleno?

Nezačínejte přepisováním všeho. Nejdřív chybu zviditelněte.

## Představené příkazy

```sh
bash -n SCRIPT
bash -x SCRIPT ARGS...
shellcheck SCRIPT
```

Význam voleb:

- `bash -n`: zpracuje skript bez jeho spuštění.
- `bash -x`: před spuštěním vypíše každý příkaz po expanzi.
- `shellcheck`: volitelný externí nástroj, který upozorňuje na běžné problémy v shellu.

## Cvičení 1: Zkontrolujte syntaxi

Spusťte:

```sh
bash -n scripts/broken-report.sh
echo $?
```

Pokud je návratový stav `0`, Bash dokáže skript zpracovat. To neznamená, že je skript správný.

## Cvičení 2: Trasujte běh

Spusťte:

```sh
bash -x scripts/broken-report.sh logs/auth.log > out/broken-trace-output.txt 2> out/broken-trace-debug.txt || true
```

Potom si prohlédněte:

```sh
less out/broken-trace-debug.txt
```

Na co se zaměřit:

- proměnné expandované na prázdné řetězce;
- cesty rozdělené na mezerách;
- globy jako `*.log` expandované dříve, než jste čekali;
- příkazy, které zapisují mimo `out/`.

## Cvičení 3: Opravte rozbitý reportovací skript

Zkopírujte skript:

```sh
cp scripts/broken-report.sh out/fixed-report.sh
```

Upravte `out/fixed-report.sh` tak, aby:

- obsahoval `set -euo pipefail`;
- odmítl chybějící vstup;
- dával proměnné do uvozovek;
- neprocházel `$(find ...)` ve smyčce;
- zapisoval výstup do `out/`.

Potom spusťte:

```sh
bash -n out/fixed-report.sh
bash out/fixed-report.sh logs/auth.log
```

## Cvičení 4: Změňte nebezpečné čištění na náhled

Zkopírujte nebezpečný skript:

```sh
cp scripts/unsafe-cleanup.sh out/safe-cleanup.sh
```

Upravte `out/safe-cleanup.sh` tak, aby:

- vyžadoval cílový adresář;
- odmítl prázdný cíl;
- vypsal dočasné a záložní soubory, kterých by se dotkl;
- nic nemazal.

## Výzva

Pokud je nainstalovaný `shellcheck`, spusťte:

```sh
shellcheck out/fixed-report.sh out/safe-cleanup.sh
```

Přečtěte si každé varování. Varování nepotlačujte naslepo; pochopte je.

## Když se něco pokazí

- Pokud `bash -n` projde, ale skript selže, problém je v chování za běhu, ne v syntaxi.
- Pokud je výstup `bash -x` zahlcující, přesměrujte stdout a stderr do samostatných souborů, jak je ukázáno výše.
- Pokud čisticí skript obsahuje `rm -rf "$target"/*`, zastavte se a před jakýmkoli mazáním přidejte validaci a náhled.

## Zkontrolujte se

Spusťte:

```sh
bash -n out/fixed-report.sh
bash -n out/safe-cleanup.sh
```

## Další lekce

Dále budete spojovat mnoho nástrojů do realistických pipeline.

