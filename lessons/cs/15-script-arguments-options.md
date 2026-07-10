# Lekce 15: Argumenty a volby skriptu

## Cíl

Zpracovat argumenty skriptu, podporovat jednoduché volby, vypsat nápovědu k použití a odmítat neznámé příznaky.

## Proč na tom záleží

Skripty se používají snáz, když mají předvídatelné volby jako `--help`, `--count` a `--errors-only`.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Budete pracovat na `out/log-tool.sh`.

## Mentální model

Když se skript spustí:

- `$0` je název skriptu.
- `$1` je první argument.
- `$2` je druhý argument.
- `$#` je počet argumentů.
- `"$@"` znamená všechny argumenty, zachované jako samostatná slova.
- `shift` zahodí `$1` a posune zbytek doleva.

Volby jsou podle konvence jen argumenty. Váš skript rozhoduje, co znamená `--count`.

## Představená syntaxe

```sh
case "$1" in
  --help) ... ;;
  --count) ... ;;
  --*) ... ;;
esac
shift
usage() { ...; }
```

Co to znamená:

- `case` porovnává hodnotu se vzory.
- `--*)` odpovídá libovolnému argumentu, který začíná na `--`.
- `;;` ukončuje větev.
- `shift` umožňuje parseru přesunout se na další argument.

## Cvičení 1: Začněte od funkčního skriptu

Spusťte:

```sh
cp scripts/parse-log.sh out/log-tool.sh
chmod +x out/log-tool.sh
out/log-tool.sh logs/auth.log
```

Proč ho kopírovat? Skripty ve fixtures mají zůstat beze změny, abyste je mohli obnovit a porovnávat.

## Cvičení 2: Přidejte `--help`

Upravte `out/log-tool.sh`, aby fungovalo toto:

```sh
out/log-tool.sh --help
```

Očekávané chování:

- Vypíše řádek s použitím.
- Skončí úspěšně.
- Při použití `--help` nevyžaduje soubor s logem.

## Cvičení 3: Přidejte `--count`

Upravte skript, aby fungovalo toto:

```sh
out/log-tool.sh --count logs/auth.log
```

Očekávané chování: vypíše pouze počet řádků `level=ERROR`.

## Cvičení 4: Přidejte `--errors-only` a odmítejte chybné volby

Podporujte tento tvar:

```sh
out/log-tool.sh [--help] [--count] [--errors-only] LOGFILE
```

Otestujte také:

```sh
out/log-tool.sh --bad-option logs/auth.log
echo $?
```

Skript má neznámou volbu odmítnout a skončit s nenulovým stavem.

## Výzva

Podporujte volby před cestou k logu i za ní, aniž by skript přijal dvě cesty k logu.

## Když se něco pokazí

- Pokud se skript zacyklí, zkontrolujte, zda každá zpracovaná volba volá `shift`.
- Pokud se `--bad-option` bere jako název souboru, přidejte odmítací větev `--*)`.
- Pokud se rozbijí cesty s mezerami, používejte `"$@"`, `"$1"` a ocitované proměnné.

## Zkontrolujte si

Spusťte:

```sh
out/log-tool.sh --help
out/log-tool.sh --count logs/auth.log
out/log-tool.sh --bad-option logs/auth.log
```

## Další lekce

Příště použijete podmínky a cykly.

