# Lekce 01: Orientace v terminálu

## Cíl

Pochopit, kde se příkazy spouštějí, jak fungují cesty a jak do sebe zapadají názvy příkazů, volby a argumenty.

## Proč na tom záleží

Správný příkaz ve špatném adresáři může selhat nebo změnit nesprávné soubory. Než se začnete učit složitější příkazy, potřebujete umět odpovědět na otázky „kde jsem?“ a „co tomuto příkazu předávám?“.

## Než začnete

Spusťte:

```sh
cd sandbox
pwd
```

Teď byste měli být uvnitř adresáře sandbox.

## Mentální model

Váš shell má vždy aktuální adresář.

- Relativní cesta jako `logs/auth.log` začíná v aktuálním adresáři.
- Absolutní cesta jako `/Users/name/git/pipeworks/sandbox/logs/auth.log` začíná od `/`.
- `.` znamená aktuální adresář.
- `..` znamená nadřazený adresář.

Příkazový řádek obvykle vypadá takto:

```text
command option argument
```

Příklad:

```sh
ls -l logs
```

- `ls` je příkaz.
- `-l` je volba, která mění formát výstupu.
- `logs` je argument: cesta, která se má vypsat.

## Představené příkazy

```sh
pwd
ls
cd
echo
printf
```

Co dělají:

- `pwd`: vypíše pracovní adresář.
- `ls PATH`: vypíše obsah adresáře. Bez `PATH` vypíše aktuální adresář.
- `cd PATH`: změní aktuální adresář shellu.
- `echo TEXT`: vypíše text s novým řádkem. Je užitečný, ale méně předvídatelný než `printf`.
- `printf FORMAT VALUES`: vypíše formátovaný text. Použijte ho, když záleží na přesném výstupu.

## Cvičení 1: Zeptejte se, kde jste

Spusťte:

```sh
pwd
```

Nekontrolujte jen to, že něco vypíše. Přečtěte si cestu. Měla by končit na `sandbox`.

## Cvičení 2: Vypište aktuální a podřízené adresáře

Spusťte:

```sh
ls
ls logs
```

Co se změnilo:

- `ls` vypsal váš aktuální adresář: sandbox.
- `ls logs` vypsal adresář `logs` uvnitř sandboxu.

## Cvičení 3: Přesuňte se, ověřte to a vraťte se

Spusťte:

```sh
cd logs
pwd
cd ..
pwd
```

Co jednotlivé cesty znamenají:

- `cd logs` se přesune do podřízeného adresáře pojmenovaného `logs`.
- `cd ..` se přesune o jeden adresář nahoru.
- Dva příkazy `pwd` dokazují, kde shell po každém přesunu je.

## Cvičení 4: Uložte si poznámky k orientaci

Spusťte:

```sh
pwd > out/current-directory.txt
printf 'I am practicing command structure.\n' >> out/current-directory.txt
cat out/current-directory.txt
```

Čeho si všimnout:

- `>` zapíše nový soubor.
- `>>` připojí obsah k existujícímu souboru.
- `out/current-directory.txt` je relativní cesta ze `sandbox`.

## Výzva

Vypište názvy `logs`, `csv` a `configs` na samostatné řádky pomocí jednoho příkazu.

Nápověda: `printf` umí vypsat několik hodnot jedním formátovacím řetězcem.

## Když se něco pokazí

- Pokud `cd logs` selže, spusťte `pwd`. Možná nejste v `sandbox`.
- Pokud chybí `out/current-directory.txt`, zkontrolujte, zda jste zapisovali do `sandbox/out/`, nebo do jiného adresáře `out/`.
- Pokud jste napsali znak promptu, například `$` nebo `%`, odstraňte ho. Prompty nejsou součástí příkazů.

## Zkontrolujte se

Ověřte, že `out/current-directory.txt` obsahuje cestu končící na `sandbox` a vaši poznámku.

## Další lekce

Dále budete bezpečně vytvářet, kopírovat, přesouvat a odstraňovat soubory.
