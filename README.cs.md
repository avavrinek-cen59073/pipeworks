# Pipeworks

[English README](README.md) | Česká verze

Pipeworks je praktický kurz terminálu a shellu inspirovaný `vimtutor`: učíte se tím, že v opravdovém terminálu pracujete se skutečnými lokálními soubory.

Není potřeba webová aplikace, Docker, SSH server, `sudo`, placená služba ani externí infrastruktura. Naklonujete nebo stáhnete repozitář, obnovíte sandbox, otevřete lekci a začnete cvičit.

## Pro koho je kurz určený

Pipeworks je pro lidi, kteří chtějí praktickou jistotu v terminálu:

- začátečníky, kteří znají pár příkazů, ale ještě se při pohybu v terminálu necítí jistě;
- vývojáře, kteří chtějí lépe zpracovávat text a automatizovat opakovanou práci;
- provozní, datové a podpůrné týmy, které prohlížejí logy a soubory;
- kohokoli, kdo chce rozumět pipeline místo kopírování jednorázových příkazů.

Kurz začíná základy a postupně vede k reálné práci: vyhledávání, hledání souborů, využití místa na disku, pipeline, `sed`, `awk`, `xargs`, archivy, kontrola procesů, skripty, ladění a propojené shellové workflow.

## Čím se Pipeworks liší od běžných tutoriálů

Většina tutoriálů ukazuje příkazy izolovaně. Pipeworks vám dá lokální pracovní prostor s realistickými logy, CSV soubory, konfiguracemi, reporty, skripty, archivy a problematickými názvy souborů. Lekce vás nutí příkazy spouštět, číst výstup, ukládat výsledky, porovnávat chování a bezpečně se vracet zpět.

Opakovaně budete cvičit, jak zjistit, kde právě jste, jak si předem zobrazit destruktivní operace, jak citovat cesty a proměnné, jak spojovat malé nástroje pomocí pipe, jak zapisovat výstupy do `sandbox/out/` a jak číst nápovědu, manuálové stránky a chyby.

## Požadavky

Použijte GNU/Linux nebo macOS s běžným terminálem. Potřebujete běžné příkazové nástroje, které už jsou na většině systémů dostupné: `bash`, `grep`, `sed`, `awk`, `find`, `du`, `sort`, `uniq`, `cut`, `tr`, `wc`, `xargs`, `tar` a `gzip`. Volitelné nástroje jsou `zsh`, `zip`, `unzip`, `shellcheck` a `lsof`.

Pro hlavní kurz není potřeba nic instalovat.

## Začátek

```sh
git clone git@github.com:avavrinek-cen59073/pipeworks.git
cd pipeworks
./tools/doctor.sh
./tools/reset-sandbox.sh
cd sandbox
```

## Struktura repozitáře

```text
lessons/en/ Anglické lekce v Markdownu
lessons/cs/ České lekce v Markdownu
solutions/  Vypracovaná řešení
fixtures/   Čistá zdrojová data pro obnovu sandboxu
sandbox/    Pracovní kopie pro cvičení
checks/     Volitelné lehké kontrolní skripty
tools/      Pomocné skripty pro setup, reset a archivy
```

`fixtures/` je čistý zdroj pravdy. `sandbox/` je místo, kde cvičíte. Soubory v `sandbox/` můžete poškodit a kdykoli je obnovit.

## Obnova sandboxu

Z kořene repozitáře:

```sh
./tools/reset-sandbox.sh
```

Pro neinteraktivní spuštění:

```sh
./tools/reset-sandbox.sh --yes
```

Resetovací skript znovu vytvoří `sandbox/` z `fixtures/` a obnoví `sandbox/out/`. Pokud nepoužijete `--yes`, upozorní vás před nahrazením změn v sandboxu.

## Použití lekcí

České lekce otevírejte postupně:

```sh
less lessons/cs/00-setup.md
```

Anglické lekce jsou zde:

```sh
less lessons/en/00-setup.md
```

Většina lekcí vás pošle spouštět příkazy z:

```sh
cd sandbox
```

Cvičení jsou zpočátku malá. Pozdější lekce propojují dříve naučené nástroje do realističtějších workflow.

## Použití řešení

Řešení jsou v `solutions/` a odpovídají číslům lekcí. Nejdřív si zkuste cvičení, potom si přečtěte řešení:

```sh
less solutions/04-grep-searching-text.md
```

Řešení ukazují jeden doporučený příkaz, vysvětlují proč funguje a kde je to užitečné, upozorňují na alternativy nebo časté chyby.

## Volitelné kontroly

Některé lekce mají kontrolní skripty. Kontrolují soubory, které vytvoříte pod `sandbox/out/`.

```sh
./checks/check-04-grep-searching-text.sh
```

Kontroly jsou volitelné. Jsou to malé Bash skripty, ne testovací framework.

## Poznámky ke GNU/Linuxu a macOS

Většina lekcí používá přenositelné vzory příkazů, ale některé nástroje se liší:

```sh
# GNU/Linux
du -h --max-depth=1 .

# macOS/BSD
du -h -d 1 .
```

```sh
# GNU/Linux
sed -i 's/old/new/g' file

# macOS/BSD
sed -i '' 's/old/new/g' file
```

Pipeworks nevyžaduje GNU-only volby jako `grep -P`, `readlink -f`, `stat -c` nebo `date -d`, pokud u nich nejsou ukázané alternativy.

## Poznámky k Bash a zsh

Interaktivní příklady fungují v Bash i zsh, pokud lekce neříká něco jiného. Externí příkazy jako `grep`, `sort` a `awk` se chovají většinou stejně; shellová syntaxe a globy se mohou lišit.

Skripty v tomto repozitáři používají Bash:

```sh
#!/usr/bin/env bash
```

Spuštění Bash skriptu ze zsh je v pořádku, pokud má skript Bash shebang a právo ke spuštění.

## Bezpečnostní poznámky

Pipeworks opakovaně učí bezpečné návyky: pracovat uvnitř `sandbox/`, spustit `pwd` před dávkovými operacemi, zobrazit si náhled před mazáním nebo přesouváním, kopírovat soubory před editací na místě, citovat cesty a proměnné, počítat s názvy souborů obsahujícími mezery, nepoužívat `sudo` a nespouštět náhodné instalační příkazy z internetu.

Tyto tvary berte jako varovné signály, dokud přesně nevíte, na co míří:

```sh
rm -rf
find ... -delete
sed -i
xargs rm
pkill
```

Preferujte náhledy:

```sh
find messy -name '*.tmp' -print
find messy -name '*.tmp' -print0 | xargs -0 echo rm
```
