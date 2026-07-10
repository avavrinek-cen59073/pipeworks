# Lekce 08: sort, uniq, wc, cut a tr

## Cíl

Proměnit řádky textu v malé reporty pomocí řazení, počítání, výběru polí a normalizace textu.

## Proč na tom záleží

Mnoho praktických terminálových reportů vzniká ze stejného vzoru:

```text
extract one value -> sort -> count -> sort by count
```

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `logs/` a `csv/`.

## Mentální model

Tyto nástroje většinou zpracovávají řádky:

- `cut` vybere část každého řádku.
- `tr` mění znaky.
- `sort` řadí řádky.
- `uniq` slučuje sousední opakované řádky.
- `wc` počítá řádky, slova nebo bajty.

Důležité: `uniq` vidí jen sousední duplicity. Když chcete počítat v celém vstupu, před `uniq` řaďte.

## Představené příkazy

```sh
sort
sort -n
sort -r
uniq
uniq -c
wc -l
cut -d DELIMITER -f FIELD
tr SET1 SET2
```

Význam voleb:

- `sort`: abecední řazení.
- `sort -n`: číselné řazení.
- `sort -r`: opačné pořadí.
- `uniq`: odstraní sousední duplicitní řádky.
- `uniq -c`: před každý jedinečný řádek přidá počet.
- `wc -l`: spočítá řádky.
- `cut -d, -f3`: rozdělí podle čárky a vypíše pole 3.
- `tr '[:upper:]' '[:lower:]'`: převede velká písmena na malá.

## Cvičení 1: Vypište jedinečné uživatele z logů

Spusťte:

```sh
grep -h -o 'user=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq > out/users.txt
cat out/users.txt
```

Význam pipeline:

- `grep -o 'user=[^ ]*'` vytáhne části jako `user=alice`.
- `cut -d= -f2` rozdělí podle `=` a ponechá druhé pole, například `alice`.
- `sort | uniq` vytvoří seznam jedinečných hodnot.

## Cvičení 2: Najděte duplicitní ID uživatelů

Spusťte:

```sh
cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d > out/duplicate-user-ids.txt
cat out/duplicate-user-ids.txt
```

Co dělají jednotlivé fáze:

- `cut -d, -f1` vypíše první sloupec CSV.
- `tail -n +2` přeskočí řádek se záhlavím.
- `sort` seskupí stejná ID.
- `uniq -d` vypíše jen ID, která se objevují víc než jednou.

## Cvičení 3: Spočítejte hodnoty statusu

Spusťte:

```sh
grep -h -o 'status=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq -c | sort -nr > out/status-counts.txt
cat out/status-counts.txt
```

Závěrečné `sort -nr` znamená číselné řazení v opačném pořadí, takže největší počet bude první.

## Cvičení 4: Normalizujte názvy oddělení

Spusťte:

```sh
cut -d, -f3 csv/messy-data.csv | tail -n +2 | tr '[:upper:]' '[:lower:]' | sort | uniq -c > out/department-counts.txt
cat out/department-counts.txt
```

To ukazuje, proč je normalizace důležitá: `Engineering` a `engineering` se mají v tomto reportu počítat dohromady.

## Výzva

Vytvořte frekvenční tabulku služeb z logů a uložte ji do `out/service-counts.txt`.

## Když se něco pokazí

- Pokud `uniq -c` dává opakované řádky na různých místech, zapomněli jste nejdřív řadit.
- Pokud výstup CSV obsahuje záhlaví jako data, přidejte `tail -n +2`.
- Pokud se `cut -d,` chová špatně na skutečném CSV, soubor může obsahovat čárky v uvozovkách. Tyto tréninkové soubory jsou jednoduché CSV; spolehlivé parsování CSV potřebuje nástroj, který CSV rozumí.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-08-sort-uniq-wc-cut-tr.sh
```

## Další lekce

Příště budete bezpečně upravovat proudy pomocí `sed`.
