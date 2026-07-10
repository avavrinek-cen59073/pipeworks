# Lekce 09: sed: úpravy textu

## Cíl

Použít `sed` k nahrazování textu, mazání řádků, tisku vybraných řádků a bezpečné úpravě zkopírovaných souborů.

## Proč na tom záleží

`sed` se hodí, když potřebujete proměnit text v pipeline nebo připravit upravenou kopii konfiguračního souboru.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete používat `configs/`.

## Mentální model

`sed` čte vstup řádek po řádku a používá na něj editační příkazy. Ve výchozím nastavení vypíše každý zpracovaný řádek.

Většina práce se `sed` v tomto kurzu má jednu z těchto podob:

```sh
sed 's/old/new/' file
sed '/pattern/d' file
sed -n '/pattern/p' file
```

Dokud si nejste jistí, raději zapisujte do nového souboru.

## Představené příkazy

```sh
sed 's/old/new/'
sed 's/old/new/g'
sed -E 's/pattern/replacement/'
sed -n '/pattern/p'
sed '/pattern/d'
sed '/^#/d'
```

Význam příkazů:

- `s/old/new/`: nahradí první `old` na každém řádku.
- `s/old/new/g`: nahradí všechny výskyty na každém řádku. `g` znamená globálně v rámci řádku.
- `-E`: použije rozšířené regulární výrazy.
- `-n`: automaticky nevypisuje každý řádek.
- `/pattern/p`: vypíše řádky odpovídající `pattern`.
- `/pattern/d`: smaže řádky odpovídající `pattern`.
- `^#`: odpovídá znaku `#` na začátku řádku.

## Cvičení 1: Nahraďte text jen ve výstupu

Spusťte:

```sh
sed 's/old-db.internal/db.internal.local/g' configs/database.conf > out/database-migrated.conf
cat out/database-migrated.conf
```

Tím se neupraví `configs/database.conf`. Upravená kopie se zapíše do `out/database-migrated.conf`.

## Cvičení 2: Odstraňte komentáře a prázdné řádky

Spusťte:

```sh
sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' configs/app.conf > out/app-no-comments.conf
cat out/app-no-comments.conf
```

Význam vzorů:

- `^[[:space:]]*#` odpovídá řádku s komentářem, včetně komentářů s úvodními mezerami.
- `^[[:space:]]*$` odpovídá prázdnému řádku nebo řádku obsahujícímu jen bílé znaky.
- `;` odděluje dva příkazy `sed`.

## Cvičení 3: Vypište vybrané řádky

Spusťte:

```sh
sed -n '/host/p' configs/services.ini > out/service-hosts.txt
cat out/service-hosts.txt
```

Proč je `-n` důležité: bez něj by `sed` vypsal každý řádek a odpovídající řádky by vypsal ještě jednou.

## Cvičení 4: Upravte zkopírovaný soubor na místě

Nejprve soubor zkopírujte:

```sh
cp configs/database.conf out/database-copy.conf
```

Potom použijte příkaz pro svůj systém.

GNU/Linux:

```sh
sed -i 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

macOS:

```sh
sed -i '' 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

Prohlédněte si výsledek:

```sh
cat out/database-copy.conf
```

## Výzva

Normalizujte mezery okolo `=` v `configs/app.conf` a výsledek uložte do `out/app-normalized.conf`.

## Když se něco pokazí

- Pokud se na řádku změnil jen první výskyt, pravděpodobně jste zapomněli závěrečné `g`.
- Pokud macOS hlásí `sed: 1: ... invalid command code`, zkontrolujte syntaxi `sed -i ''`.
- Pokud jste poškodili konfiguraci, resetujte sandbox. Ve skutečné práci si před úpravou na místě udělejte kopii nebo zálohu.

## Poznámky ke kompatibilitě

`sed -i` se liší mezi GNU/Linux a macOS. Pro přenositelné lekce raději přesměrujte výstup do nového souboru:

```sh
sed 's/old/new/g' input > output
```

## Zkontrolujte si

Z kořene repozitáře:

```sh
./checks/check-09-sed-text-editing.sh
```

## Další lekce

Příště budete zpracovávat strukturovaný text pomocí `awk`.

