# Lekce 02: Soubory, adresáře a globy

## Cíl

Bezpečně vytvářet, kopírovat, přejmenovávat a odstraňovat soubory a přitom se naučit, jak se chovají globy a cesty v uvozovkách.

## Proč na tom záleží

Souborové příkazy jsou jednoduché, dokud je nespustíte nad nesprávným cílem. Tato lekce buduje návyk zobrazit si cesty předtím, než je změníte.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat soubory pod `messy/` a zapisovat cvičné soubory pod `out/file-practice/`.

## Mentální model

Shell rozbalí globy před spuštěním příkazu.

```sh
cp messy/*.txt out/file-practice/
```

Než se spustí `cp`, shell změní `messy/*.txt` na seznam odpovídajících cest, například:

```text
messy/duplicate.txt messy/empty-file.txt messy/mixed_case.txt
```

Na uvozovkách záleží, protože mezery oddělují argumenty:

```sh
"messy/spaces in names/quarterly draft.txt"
```

Uvozovky udělají z celé cesty jeden argument.

## Představené příkazy

```sh
mkdir
touch
cp
mv
rm
printf
```

Stavba příkazu:

- `mkdir -p DIR`: vytvoří adresář. `-p` také vytvoří chybějící nadřazené adresáře a nestěžuje si, pokud adresář už existuje.
- `touch FILE`: vytvoří prázdný soubor, pokud neexistuje, nebo aktualizuje jeho časovou značku, pokud existuje.
- `cp SOURCE DEST`: zkopíruje soubor. Pokud je `DEST` adresář, kopie si zachová původní název souboru.
- `mv SOURCE DEST`: přesune nebo přejmenuje soubor.
- `rm FILE`: odstraní soubor. Nepřesune ho do koše.
- `printf '%s\n' VALUES...`: vypíše každou hodnotu na vlastní řádek.

## Cvičení 1: Vytvořte bezpečné cvičné místo

Spusťte:

```sh
mkdir -p out/file-practice
touch out/file-practice/empty-note.txt
ls out/file-practice
```

Co vás to učí:

- Necvičíte v `messy/`; vytváříte kopie pod `out/`.
- `mkdir -p` dělá toto cvičení opakovatelným.

## Cvičení 2: Zkopírujte soubory vybrané globem

Spusťte:

```sh
printf '%s\n' messy/*.txt
cp messy/*.txt out/file-practice/
ls out/file-practice
```

První příkaz je náhled. Ukáže, na co se `messy/*.txt` rozbalí, než stejný vzor předáte příkazu `cp`.

## Cvičení 3: Zkopírujte cestu s mezerami

Spusťte:

```sh
cp "messy/spaces in names/quarterly draft.txt" out/file-practice/
ls out/file-practice
```

Bez uvozovek by shell rozdělil zdroj na několik argumentů: `messy/spaces`, `in`, `names/quarterly` a `draft.txt`.

## Cvičení 4: Odstraňte jen známý cvičný soubor

Spusťte:

```sh
printf 'About to remove: %s\n' out/file-practice/empty-note.txt
rm out/file-practice/empty-note.txt
ls out/file-practice
```

Neříká to „vždy vypisujte seznam před každým `rm`“. Učí to bezpečnější návyk: když příkaz něco maže, udělejte cíl explicitní a prohlédněte si ho, když se učíte nebo používáte vzor.

## Výzva

Přejmenujte zkopírovaný `quarterly draft.txt` na `quarterly-draft.txt` uvnitř `out/file-practice/`.

## Když se něco pokazí

- Pokud selže cesta s mezerami, zkontrolujte, zda jste dali do uvozovek celou cestu.
- Pokud `cp messy/*.txt ...` v zsh hlásí, že nenašel shody, glob neodpovídal z vašeho aktuálního adresáře. Spusťte `pwd`.
- Pokud odstraníte soubor v `out/file-practice/`, vytvořte ho znovu z `messy/`. Pokud poškodíte `sandbox/`, obnovte ho.

## Zkontrolujte se

Použijte:

```sh
ls out/file-practice
```

Měli byste vidět zkopírované soubory a `empty-note.txt` by po Cvičení 4 měl být pryč.

## Další lekce

Dále budete prohlížet obsah souborů bez jejich úprav.

