# Lekce 12: Archivy a komprese

## Cíl

Vytvářet, vypisovat, rozbalovat a komprimovat archivy pomocí `tar`, `gzip` a volitelně `zip`.

## Proč na tom záleží

Archivy jsou způsob, jak z adresářů udělat jednotlivé soubory pro zálohy, přenosy, vydání a balíky logů. Vypsání obsahu před rozbalením předchází překvapením.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `reports/`, `logs/` a `archives/`.

## Mentální model

Archiv a komprese jsou dvě různé věci:

- Archiv seskupuje soubory dohromady.
- Komprese zmenšuje data.

Soubor `.tar` je archiv. Soubor `.tar.gz` je obvykle tar archiv komprimovaný pomocí gzip.

## Představené příkazy

```sh
tar -cf ARCHIVE PATH
tar -tf ARCHIVE
tar -xf ARCHIVE
tar -czf ARCHIVE PATH
tar -xzf ARCHIVE
gzip FILE
gunzip FILE.gz
zip
unzip
```

Význam voleb:

- `tar -c`: vytvoří archiv.
- `tar -t`: vypíše obsah archivu.
- `tar -x`: rozbalí obsah archivu.
- `tar -f FILE`: použije tento název archivního souboru.
- `tar -z`: použije kompresi gzip.
- `gzip FILE`: nahradí `FILE` souborem `FILE.gz`.
- `gunzip FILE.gz`: obnoví komprimovaný soubor.

## Cvičení 1: Vytvořte archiv

Spusťte:

```sh
tar -cf out/reports.tar reports
ls -l out/reports.tar
```

Co to znamená:

- `-c` vytváří.
- `-f out/reports.tar` pojmenovává archivní soubor.
- `reports` je adresář, který se archivuje.

## Cvičení 2: Před rozbalením vypište obsah

Spusťte:

```sh
tar -tf out/reports.tar > out/reports-archive-list.txt
cat out/reports-archive-list.txt
```

Vypsání obsahu vám řekne, jaké cesty archiv obsahuje. Je to důležité, protože rozbalení tyto cesty znovu vytvoří.

## Cvičení 3: Rozbalte do cílového adresáře

Spusťte:

```sh
mkdir -p out/extracted-reports
tar -xf out/reports.tar -C out/extracted-reports
find out/extracted-reports -type f | sort
```

Co dělá `-C`: před rozbalením přejde do cílového adresáře. Bez něj se soubory rozbalí do aktuálního adresáře.

## Cvičení 4: Vytvořte komprimovaný archiv

Spusťte:

```sh
tar -czf out/logs.tar.gz logs
tar -tzf out/logs.tar.gz | head
```

Přidané `z` znamená kompresi gzip. Příkaz pro vypsání obsahu také potřebuje `z`, protože archiv je komprimovaný.

## Výzva

Zkopírujte `reports/incident-001.txt` do `out/`, zkomprimujte kopii pomocí `gzip` a pak ji obnovte pomocí `gunzip`.

## Když se něco pokazí

- Pokud rozbalení umístí soubory na špatné místo, pravděpodobně jste vynechali `-C`.
- Pokud `tar -tf` nedokáže přečíst `.tar.gz`, použijte `tar -tzf`.
- Pokud `gzip` způsobí, že původní název souboru zmizí, je to normální: nahrazuje `file` souborem `file.gz`.

## Poznámky ke kompatibilitě

Volby `tar` použité zde fungují na GNU/Linux i macOS. `zip` a `unzip` jsou v tomto kurzu volitelné, protože nemusí být nainstalované všude.

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-12-archives-compression.sh
```

## Další lekce

Příště prozkoumáte procesy a základní systémové informace.

