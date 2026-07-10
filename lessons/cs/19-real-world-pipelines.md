# Lekce 19: Pipeline z reálného světa

## Cíl

Vytvářet užitečné reporty kombinováním vyhledávání, extrakce, řazení, počítání, auditu konfigurací, detekce duplicit a náhledů čištění.

## Proč na tom záleží

Skutečná práce na příkazové řádce málokdy znamená jeden příkaz. Pipeline stavíte po krocích, každý krok zkontrolujete a finální odpověď uložíte.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Finální výstupy zapisujte do `out/`.

## Mentální model

Pipeline stavte postupně:

1. Začněte nejmenším příkazem, který vrací relevantní řádky.
2. Přidejte jednu transformaci.
3. Zkontrolujte výstup.
4. Přidejte počítání nebo řazení.
5. Uložte finální výstup.

Nepište dlouhou pipeline zpaměti s nadějí, že bude správná.

## Znovu použité nástroje

Tato lekce kombinuje:

```sh
grep
sed
cut
sort
uniq
find
awk
du
```

## Cvičení 1: Vytvořte report selhání

Nejdřív si prohlédněte surové shody:

```sh
grep -h 'status=failed' logs/*.log | head
```

Potom sestavte report:

```sh
grep -h 'status=failed' logs/*.log \
  | sed -E 's/.*user=([^ ]+).*code=([^ ]+).*/user=\1 code=\2/' \
  | sort \
  | uniq -c \
  | sort -nr > out/failure-report.txt
cat out/failure-report.txt
```

Důležité části:

- `sed -E` zapíná seskupené regulární výrazy.
- `([^ ]+)` zachytí jeden nebo více znaků, které nejsou mezera.
- `\1` a `\2` znovu použijí zachyceného uživatele a kód.
- `sort | uniq -c | sort -nr` vytvoří frekvenční tabulku.

## Cvičení 2: Auditujte zastaralé konfigurační hodnoty

Spusťte:

```sh
grep -R -n 'old-db.internal' configs > out/config-audit.txt
cat out/config-audit.txt
```

Co získáte:

- název souboru;
- číslo řádku;
- celý odpovídající řádek.

To je dostatek kontextu pro naplánování bezpečné migrace.

## Cvičení 3: Odhalte duplicitní uživatele v CSV

Spusťte:

```sh
cut -d, -f1 csv/duplicate-users.csv \
  | tail -n +2 \
  | sort \
  | uniq -d > out/duplicate-users-report.txt
cat out/duplicate-users-report.txt
```

Tím znovu použijete vzor z lekce 08. Hodnota opakování je v tom, že začnete rozpoznávat tvary reportů.

## Cvičení 4: Vygenerujte plán čištění

Spusťte:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print \
  | sort > out/cleanup-plan.txt
cat out/cleanup-plan.txt
```

Toto je záměrně plán, ne příkaz pro mazání.

## Výzva

Vytvořte `out/incident-report.md` se sekcemi pro:

- uživatele s nejvíce selháními;
- nejčastější IP adresy;
- jedinečné chybové kódy;
- první a poslední časové razítko;
- služby s nejvíce chybami.

Každou sekci sestavte samostatně, než je seskupíte do jednoho souboru Markdown.

## Když se něco pokazí

- Pokud extrakce pomocí `sed` vrátí celý řádek beze změny, vzor neodpovídal. Otestujte ho na jednom ukázkovém řádku.
- Pokud počty vypadají příliš vysoké, zkontrolujte, zda se stejná událost nevyskytuje ve více log souborech.
- Pokud plán čištění obsahuje neočekávané cesty, opravte výraz pro `find`, než z něj uděláte jakoukoli akci.

## Zkontrolujte se

Z kořene repozitáře:

```sh
./checks/check-19-real-world-pipelines.sh
```

## Další lekce

Dále se naučíte pokročilé shellové vzory pro robustní skripty.

