# Lekce 10: awk: strukturovaný text

## Cíl

Použít `awk` k práci s poli, filtrování řádků, sčítání čísel, výpočtu průměrů, seskupování hodnot a zpracování jednoduchých logů typu klíč-hodnota.

## Proč na tom záleží

`awk` stojí mezi rychlými textovými filtry a plnohodnotnými programovacími jazyky. Výborně se hodí na úlohy typu „čti řádky, prohlédni pole, vytvoř souhrn“.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `csv/` a `logs/`.

## Mentální model

`awk` čte vstup po jednom záznamu. Ve výchozím nastavení je jeden záznam jeden řádek.

Každý řádek se rozdělí na pole:

- `$0` je celý řádek.
- `$1` je první pole.
- `$2` je druhé pole.
- `NR` je číslo aktuálního záznamu.
- `END { ... }` se spustí po přečtení celého vstupu.

U souborů podobných CSV v tomto kurzu používejte `-F,`, aby se pole dělila podle čárek.

## Představené příkazy

```sh
awk '{print $1}'
awk -F, '{print $2}'
awk -F, '$4 > 100 {print $0}'
awk -F, 'NR > 1 {print $2}'
awk -F, 'NR > 1 {sum += $4} END {print sum}'
awk -F, '{count[$1]++} END {for (k in count) print k, count[k]}'
```

Části programu:

- `pattern { action }`: spustí `action` jen tehdy, když je `pattern` pravdivý.
- `{ action }`: spustí akci pro každý řádek.
- `sum += $4`: přičte pole 4 k průběžnému součtu.
- `count[$1]++`: zvýší počítadlo pro hodnotu pole 1.

## Cvičení 1: Vypište jedno pole

Spusťte:

```sh
awk -F, 'NR > 1 {print $2}' csv/employees.csv > out/employee-names.txt
cat out/employee-names.txt
```

Co to znamená:

- `-F,` nastaví oddělovač polí na čárku.
- `NR > 1` přeskočí řádek se záhlavím.
- `{print $2}` vypíše druhé pole: jméno zaměstnance.

## Cvičení 2: Filtrujte řádky podle čísla

Spusťte:

```sh
awk -F, 'NR > 1 && $4 > 100 {print $0}' csv/expenses.csv > out/large-expenses.csv
cat out/large-expenses.csv
```

Co to znamená:

- `&&` znamená AND.
- `$4 > 100` ponechá řádky, kde je sloupec s částkou větší než 100.
- `$0` vypíše celý řádek.

## Cvičení 3: Sečtěte výdaje podle oddělení

Spusťte:

```sh
awk -F, 'NR > 1 {sum[$3] += $4} END {for (d in sum) print d, sum[d]}' csv/expenses.csv | sort > out/expenses-by-department.txt
cat out/expenses-by-department.txt
```

Co to znamená:

- `sum[$3]` ukládá samostatný součet pro každé oddělení.
- `END` vypíše součty po přečtení všech řádků.
- `sort` zajistí předvídatelný výstup.

## Cvičení 4: Průměrná latence z logů

Spusťte:

```sh
awk '{for (i=1; i<=NF; i++) if ($i ~ /^latency_ms=/) {sub("latency_ms=", "", $i); total += $i; count++}} END {if (count) print total / count}' logs/app-2026-06-01.log > out/average-latency.txt
cat out/average-latency.txt
```

Tohle je hutnější. Čtěte to po částech:

- `for (i=1; i<=NF; i++)` prochází každé pole na řádku.
- `$i ~ /^latency_ms=/` najde pole, které začíná na `latency_ms=`.
- `sub("latency_ms=", "", $i)` odstraní klíč a ponechá jen číslo.
- `total += $i; count++` sleduje součet a počet.
- `END` vypíše průměr.

## Výzva

Seskupte chybové řádky logů podle služby a uložte výsledek do `out/errors-by-service.txt`.

## Když se něco pokazí

- Pokud jsou pole špatně, zkontrolujte oddělovač. Příklady CSV potřebují `-F,`; příklady logů používají mezery.
- Pokud se v číselných výsledcích objeví záhlaví, přidejte `NR > 1`.
- Pokud seskupený výstup mění pořadí mezi spuštěními, pošlete ho přes `sort`.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-10-awk-structured-text.sh
```

## Další lekce

Příště budete provádět dávkové operace pomocí `xargs`.

