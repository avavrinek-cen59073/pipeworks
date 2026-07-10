# Lekce 00: Nastavení

## Cíl

Připravit kurz, pochopit, co můžete bezpečně upravovat, a vytvořit první kontrolovaný výstupní soubor.

## Proč na tom záleží

Terminál je mocný nástroj, protože příkazy pracují se skutečnými soubory. Pipeworks vám dává jednorázové cvičné prostředí, takže se můžete učit skutečné příkazy, aniž byste trénovali na svých osobních souborech.

## Než začnete

Otevřete terminál v kořeni repozitáře. Pokud si nejste jistí, kde jste, spusťte:

```sh
pwd
```

Vypsaná cesta by měla končit na `pipeworks`.

## Mentální model

Jsou tu dva důležité adresáře:

- `fixtures/` je čistá zdrojová kopie. Necvičte v ní.
- `sandbox/` je vaše pracovní kopie. Lekce jsou navržené pro tento adresář.

Když spustíte `./tools/reset-sandbox.sh`, Pipeworks znovu sestaví `sandbox/` z `fixtures/`. To znamená, že chyby uvnitř `sandbox/` jsou napravitelné.

## Představené příkazy

```sh
pwd
printf
command -v
bash --version
zsh --version
```

Stavba příkazu:

- `pwd` vypíše aktuální adresář. Nevyžaduje žádné argumenty.
- `printf 'text\n'` vypíše přesně text, který mu předáte. `\n` znamená nový řádek.
- `command -v NAME` se shellu zeptá, odkud pochází příkaz pojmenovaný `NAME`.
- `bash --version` a `zsh --version` požádají tyto shelly, aby vypsaly informace o verzi. Část `--version` je volba.

## Cvičení 1: Zkontrolujte své nástroje

Spusťte:

```sh
./tools/doctor.sh
```

Čeho si všimnout:

- `./tools/doctor.sh` znamená „spusť soubor pojmenovaný `doctor.sh` uvnitř adresáře `tools` pod aktuálním adresářem“.
- Úvodní `./` je důležité, protože většina shellů nespouští programy z aktuálního adresáře automaticky.
- Varování u volitelných nástrojů nejsou selhání. Hlavní kurz se volitelným závislostem vyhýbá.

## Cvičení 2: Obnovte sandbox

Spusťte:

```sh
./tools/reset-sandbox.sh --yes
```

Co dělají jednotlivé části:

- `./tools/reset-sandbox.sh` spustí skript pro obnovu.
- `--yes` neinteraktivně odpoví na bezpečnostní dotaz skriptu.
- Skript znovu vytvoří `sandbox/` z `fixtures/` a ujistí se, že existuje `sandbox/out/`.

## Cvičení 3: Najděte soubory kurzu

Spusťte:

```sh
find lessons -maxdepth 1 -name '*.md' | sort | head
```

Čtěte zleva doprava:

- `find lessons` hledá uvnitř adresáře `lessons`.
- `-maxdepth 1` znamená „nevstupuj do podadresářů“.
- `-name '*.md'` odpovídá souborům Markdown. Uvozovky zabrání shellu rozbalit `*.md` příliš brzy.
- `| sort` pošle seznam do `sort`.
- `| head` zobrazí jen několik prvních řádků.

## Cvičení 4: Vytvořte svůj první výstupní soubor

Spusťte:

```sh
printf 'pipeworks ready\n' > sandbox/out/first-output.txt
cat sandbox/out/first-output.txt
```

Co dělají jednotlivé části:

- `printf 'pipeworks ready\n'` vytvoří jeden řádek textu.
- `>` zapíše tento text do souboru. Pokud soubor už existuje, nahradí ho.
- `cat FILE` vypíše soubor, abyste si mohli prohlédnout, co jste zapsali.

## Výzva

Najděte soubor s řešením pro tuto lekci pomocí příkazu, ne ručním procházením.

Nápověda: názvy souborů s řešeními odpovídají názvům souborů lekcí.

## Když se něco pokazí

- Pokud `./tools/doctor.sh` hlásí „No such file“, pravděpodobně nejste v kořeni repozitáře. Spusťte `pwd`.
- Pokud nelze vytvořit `sandbox/out/first-output.txt`, obnovte sandbox a ověřte, že existuje `sandbox/out/`.
- Pokud omylem přepíšete `first-output.txt`, zapište ho znovu. Právě proto cvičení používají `sandbox/out/`.

## Zkontrolujte se

Z kořene repozitáře:

```sh
./checks/check-00-setup.sh
```

## Další lekce

Dále se naučíte, jak se zorientovat v terminálové relaci.

