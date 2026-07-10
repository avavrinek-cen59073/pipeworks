# Lekce 07: Roury, přesměrování a proudy

## Cíl

Porozumět stdin, stdout, stderr, návratovému stavu, rourám, přesměrování s přepsáním, přesměrování s připojením, přesměrování stderr a příkazu `tee`.

## Proč na tom záleží

Shell začne být užitečný ve chvíli, kdy umíte propojovat malé příkazy a řídit, kam půjde jejich výstup.

## Než začnete

Spusťte:

```sh
cd sandbox
```

## Mentální model

Většina příkazů má tři standardní proudy:

- stdin: vstup, který příkaz čte.
- stdout: běžný výstup.
- stderr: chybové zprávy a diagnostika.

Příkaz také skončí s návratovým stavem:

- `0` obvykle znamená úspěch.
- nenulový stav obvykle znamená, že něco selhalo nebo neodpovídalo očekávání příkazu.

## Představená syntaxe

```sh
|
>
>>
2>
2>&1
tee
echo $?
```

Co jednotlivé části znamenají:

- `A | B`: pošle stdout příkazu `A` do stdin příkazu `B`.
- `>`: zapíše stdout do souboru a soubor nahradí.
- `>>`: připojí stdout na konec souboru.
- `2>`: zapíše stderr do souboru.
- `2>&1`: pošle stderr na stejné místo, kam právě míří stdout.
- `tee FILE`: zapíše stdin do `FILE` a zároveň ho předá na stdout.
- `$?`: návratový stav předchozího příkazu.

## Cvičení 1: Uložte běžný výstup

Spusťte:

```sh
grep -h 'level=ERROR' logs/*.log > out/error-lines.txt
cat out/error-lines.txt
```

Výstup `grep` by se normálně objevil v terminálu. `>` místo toho pošle stdout do `out/error-lines.txt`.

## Cvičení 2: Sestavte souhrn pomocí přepsání a připojení

Spusťte:

```sh
printf 'error lines: ' > out/pipeline-summary.txt
wc -l < out/error-lines.txt >> out/pipeline-summary.txt
cat out/pipeline-summary.txt
```

Čeho si všimnout:

- První příkaz používá `>`, protože soubor zakládá.
- Druhý příkaz používá `>>`, protože do souboru přidává.
- `< out/error-lines.txt` předá soubor příkazu `wc` jako stdin, takže `wc` vypíše jen počet, ne název souboru.

## Cvičení 3: Oddělte chyby od běžného výstupu

Spusťte:

```sh
find missing-directory -type f > out/find-output.txt 2> out/find-errors.txt
echo $?
cat out/find-errors.txt
```

Tento příkaz záměrně selže, protože `missing-directory` neexistuje. Díky tomu se hodí pro ukázku stderr a návratového stavu.

## Cvičení 4: Uložte a zároveň zobrazte

Spusťte:

```sh
grep -h 'status=failed' logs/*.log | tee out/failed-lines.txt | wc -l
```

Význam pipeline:

- `grep` vypíše řádky logu s neúspěchem.
- `tee` uloží kopii do `out/failed-lines.txt`.
- `wc -l` spočítá stejné řádky.

## Výzva

Vytvořte `out/warn-and-error-counts.txt` s jedním řádkem pro `WARN` a jedním řádkem pro `ERROR`.

## Když se něco pokazí

- Pokud je soubor prázdný, ověřte, zda příkaz zapisoval stdout nebo stderr.
- Pokud jste chtěli zachovat starý výstup, ale použili jste `>`, soubor jste přepsali. Když chcete přidávat na konec, použijte `>>`.
- Pokud `echo $?` vypíše `0` poté, co jste spustili jiný příkaz, čekali jste příliš dlouho; `$?` si pamatuje jen bezprostředně předchozí příkaz.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-07-pipes-redirection-streams.sh
```

## Další lekce

Příště budete vytvářet jednoduché souhrny pomocí `sort`, `uniq`, `wc`, `cut` a `tr`.

