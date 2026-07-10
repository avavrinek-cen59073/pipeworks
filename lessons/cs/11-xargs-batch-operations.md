# Lekce 11: xargs a dávkové operace

## Cíl

Použít `xargs` k převodu seznamů ze stdin na argumenty příkazů a přitom bezpečně zacházet s mezerami.

## Proč na tom záleží

Běžný pracovní postup je:

```text
find paths -> preview command -> run command on those paths
```

`xargs` pomáhá s druhou polovinou, ale u názvů souborů se musí používat opatrně.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `messy/` a `configs/`.

## Mentální model

`xargs` čte položky ze stdin a přidává je jako argumenty k jinému příkazu.

Příklad:

```sh
printf '%s\n' a b c | xargs echo item:
```

Zhruba se z toho stane:

```sh
echo item: a b c
```

U názvů souborů dávejte přednost vstupu oddělenému nulovými bajty:

```sh
find . -print0 | xargs -0 ...
```

Nové řádky a mezery se mohou v názvech souborů objevit. Nulové bajty ne.

## Představené příkazy

```sh
xargs
xargs -n 1
xargs -I {}
find ... -print0 | xargs -0
```

Význam voleb:

- `xargs COMMAND`: nasbírá vstupní položky a spustí `COMMAND` s nimi jako argumenty.
- `-n 1`: použije jednu vstupní položku na jedno spuštění příkazu.
- `-I {}`: použije `{}` jako zástupný symbol uvnitř příkazu.
- `-0`: čte vstup oddělený nulovými bajty z `find -print0`.

## Cvičení 1: Zobrazte náhled generovaných příkazů

Spusťte:

```sh
find messy -name '*.txt' -type f -print | xargs -n 1 echo inspect
```

To vypíše příkazy ve tvaru `inspect PATH`. Nic to nekontroluje; `echo` je zkušební běh.

Tato jednoduchá verze záměrně není bezpečná pro cesty s mezerami. Tento vzor opravíte v dalších cvičeních.

## Cvičení 2: Bezpečně prohledejte nalezené soubory

Spusťte:

```sh
find configs -type f -print0 | xargs -0 grep -l 'old-db.internal' > out/xargs-deprecated-configs.txt
cat out/xargs-deprecated-configs.txt
```

Co se změnilo:

- `find ... -print0` odděluje cesty nulovými bajty.
- `xargs -0` čte tento formát.
- `grep -l` vypíše názvy souborů, které obsahují zastaralý host.

## Cvičení 3: Vytvořte bezpečný náhled mazání

Spusťte:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print0 | xargs -0 -I {} echo rm "{}" > out/xargs-delete-preview.txt
cat out/xargs-delete-preview.txt
```

Tím vznikne plán mazání, ne mazání. `echo rm "{}"` vypíše, co by se spustilo.

## Cvičení 4: Zkopírujte soubory, jejichž cesty obsahují mezery

Spusťte:

```sh
mkdir -p out/copied-messy
find "messy/spaces in names" -type f -print0 | xargs -0 -I {} cp "{}" out/copied-messy/
ls out/copied-messy
```

Proč to funguje:

- Počáteční cesta je v uvozovkách.
- `-print0` a `-0` zachovají názvy souborů s mezerami.
- `-I {}` vám umožní umístit zdrojovou cestu před cíl.

## Výzva

Použijte `find -print0` a `xargs -0` ke spuštění `wc -l` nad každým logovacím souborem.

## Když se něco pokazí

- Pokud se název souboru s mezerami rozdělí na části, přejděte na `find -print0 | xargs -0`.
- Pokud náhled ukazuje `rm` na soubory, které jste nečekali, zastavte. Než něco odstraníte, opravte výraz `find`.
- Pokud `xargs` spustí příkaz bez vstupu, zkontrolujte nejdřív svůj výraz `find`.

## Poznámky ke kompatibilitě

`find -print0` a `xargs -0` jsou dostupné na GNU/Linux i macOS a jsou bezpečným výchozím nastavením pro názvy souborů.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-11-xargs-batch-operations.sh
```

## Další lekce

Příště budete vytvářet, vypisovat, rozbalovat a komprimovat archivy.
