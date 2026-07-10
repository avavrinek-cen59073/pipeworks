# Lekce 13: Procesy a kontrola systému

## Cíl

Zkontrolovat základní informace o systému, spustit neškodný proces na pozadí, najít ho podle PID a zastavit pouze tento proces.

## Proč na tom záleží

Dříve nebo později budete potřebovat odpovědět na otázku „co právě běží?“ Bezpečný návyk je cílit na konkrétní proces, kterému rozumíte, a nezabíjet široké skupiny podle názvu.

## Než začnete

Spusťte:

```sh
cd sandbox
```

Zastavujte pouze procesy, které v této lekci sami spustíte.

## Mentální model

Běžící program je proces. Každý proces má identifikátor procesu, tedy PID.

Když spustíte příkaz s `&`, shell ho spustí na pozadí a nabídne vám další prompt. Speciální proměnná `$!` uchovává PID posledního procesu spuštěného na pozadí.

## Představené příkazy

```sh
ps
pgrep
pkill
top
df
whoami
id
uname
lsof
kill
```

Význam příkazů:

- `whoami`: vypíše vaše uživatelské jméno.
- `id`: vypíše ID uživatele a skupin.
- `uname -a`: vypíše informace o operačním systému/jádře.
- `df -h PATH`: zobrazí volné místo v souborovém systému, který obsahuje `PATH`.
- `ps -p PID`: zobrazí informace o jednom PID.
- `kill PID`: pošle jednomu procesu výchozí signál pro ukončení.
- `top`: interaktivní prohlížeč procesů; obvykle ho ukončíte stiskem `q`.
- `pgrep` a `pkill`: najdou procesy podle názvu nebo jim pošlou signál. Používejte opatrně.
- `lsof`: vypíše otevřené soubory; na některých systémech je volitelný.

## Cvičení 1: Uložte informace o identitě a OS

Spusťte:

```sh
whoami > out/system-info.txt
id >> out/system-info.txt
uname -a >> out/system-info.txt
cat out/system-info.txt
```

Proč připojovat? Jsou to tři samostatné příkazy, které přispívají do jednoho souboru, takže druhý a třetí příkaz používají `>>`.

## Cvičení 2: Zkontrolujte volné místo na disku

Spusťte:

```sh
df -h . > out/disk-free.txt
cat out/disk-free.txt
```

Co to znamená:

- `df` hlásí místo v souborovém systému, ne velikost adresáře. Pro velikost adresáře použijte `du`.
- `-h` vypisuje jednotky čitelné pro člověka.
- `.` se ptá na souborový systém, který obsahuje sandbox.

## Cvičení 3: Spusťte, zkontrolujte a zastavte proces na pozadí

Spusťte:

```sh
sleep 300 &
sleep_pid=$!
printf 'sleep pid: %s\n' "$sleep_pid" > out/sleep-process.txt
ps -p "$sleep_pid" >> out/sleep-process.txt
cat out/sleep-process.txt
kill "$sleep_pid"
```

Co dělají jednotlivé části:

- `sleep 300 &` spustí neškodný proces na pozadí.
- `sleep_pid=$!` uloží jeho PID.
- `ps -p "$sleep_pid"` zkontroluje pouze toto PID.
- `kill "$sleep_pid"` zastaví pouze tento proces.

## Cvičení 4: Zkontrolujte přiloženou pomalou úlohu

Spusťte:

```sh
scripts/slow-task.sh 300 &
task_pid=$!
ps -p "$task_pid"
kill "$task_pid"
```

Je to stejný vzor, jen se skriptem místo `sleep`.

## Výzva

Pokud je nainstalovaný `lsof`, otevřete `reports/q1.txt` pomocí `less` v jednom terminálu a z jiného terminálu použijte `lsof`, abyste našli otevřený soubor. Ukončete `less` pomocí `q`.

## Když se něco pokazí

- Pokud `kill "$sleep_pid"` hlásí "No such process", proces už skončil.
- Pokud zapomenete uložit `$!`, spusťte nový neškodný proces místo hádání PID.
- Neprocvičujte `pkill` na skutečných názvech procesů. Může najít víc, než jste zamýšleli.

## Poznámky ke kompatibilitě

`ps` a `top` mají mnoho voleb specifických pro jednotlivé systémy. Tato lekce používá `ps -p PID`, protože je široce dostupné. `lsof` je volitelný.

## Zkontrolujte si

Ověřte, že tyto soubory existují:

```sh
out/system-info.txt
out/disk-free.txt
out/sleep-process.txt
```

## Další lekce

Příště napíšete své první Bash skripty.

