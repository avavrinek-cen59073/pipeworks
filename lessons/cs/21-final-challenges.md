# Lekce 21: Závěrečné výzvy

## Cíl

Uplatnit znalosti z kurzu vytvořením přehledných reportů a jednoho automatizačního skriptu z dat v sandboxu.

## Proč na tom záleží

Skutečná práce vám obvykle neřekne, který přesný příkaz spustit. Definujete otázku, prozkoumáte data, sestavíte pipeline a uložíte odpověď, kterou si může přečíst někdo další.

## Než začnete

Spusťte:

```sh
cd sandbox
mkdir -p out/final
```

## Mentální model

Pro každou výzvu:

1. Napište otázku běžným jazykem.
2. Najděte relevantní soubory.
3. Sestavujte a kontrolujte vždy jeden příkaz.
4. Uložte výstup pod `out/final/`.
5. Přidejte dostatek kontextu, aby report pochopil i někdo jiný.

Nehodnotí se chytrost. Dávejte přednost čitelným příkazům a jasnému výstupu.

## Znovu použité příkazy

Použijte nástroje z předchozích lekcí:

```sh
find grep sed awk sort uniq cut tr wc du tar xargs
```

## Cvičení 1: Vyšetřování logů

Vytvořte:

```text
out/final/log-investigation.md
```

Zahrňte:

- uživatele s nejvíce selháními;
- nejčastější IP adresy;
- jedinečné chybové kódy;
- první a poslední časové razítko;
- služby s nejvíce chybami.

Začněte samostatnými průzkumnými příkazy. Příklad tvaru:

```sh
grep -h 'status=failed' logs/*.log | grep -o 'user=[^ ]*'
```

Potom přidejte `cut`, `sort`, `uniq -c` a `sort -nr`, až bude extrakce vypadat správně.

## Cvičení 2: Migrace konfigurací

Vytvořte:

```text
out/final/config-migration.md
out/final/migrated-configs/
```

Zahrňte:

- soubory obsahující zastaralé hostnames;
- zkopírované konfigurace, které potřebují migraci;
- nahrazení provedená pouze v kopiích;
- krátké shrnutí toho, co se změnilo.

Důležité: neupravujte soubory pod `configs/` přímo. Pracujte s kopiemi.

## Cvičení 3: Audit čištění disku

Vytvořte:

```text
out/final/cleanup-audit.md
```

Zahrňte:

- největší cesty;
- dočasné soubory;
- záložní soubory;
- plán mazání, který nemaže originály.

Výstup by měl působit jako plán, který si můžete před provedením akce zkontrolovat.

## Cvičení 4: Obchodní report z CSV

Vytvořte:

```text
out/final/csv-business-report.md
```

Zahrňte:

- výdaje podle oddělení;
- duplicitní uživatele;
- chybějící pole;
- seřazené součty prodejů.

Každou sekci sestavte samostatně a potom je spojte pomocí seskupení příkazů.

## Výzva: Skriptovaná automatizace

Napište:

```text
out/final/project-audit.sh
```

Skript by měl z dat v sandboxu vytvořit auditní report v Markdownu. Měl by:

- používat shebang pro Bash;
- ověřit, že požadované adresáře existují;
- vytvořit `out/final/`, pokud je potřeba;
- zapsat jeden soubor reportu;
- ponechat čisticí akce pouze jako náhledy.

## Když se něco pokazí

- Pokud je report špatně čitelný, přidejte nadpisy a prázdné řádky. Na kvalitě výstupu záleží.
- Pokud se jedna obří pipeline špatně ladí, nejdřív ji rozdělte na menší příkazy.
- Pokud váš skript funguje jen z jednoho adresáře, buď to zdokumentujte, nebo při startu ověřte aktuální adresář.

## Zkontrolujte se

Přečtěte si každý finální výstup tak, jako by ho měl použít někdo jiný. Měl by říkat, co jste zkontrolovali, co jste našli a kde jsou migrované nebo vygenerované soubory.

## Další lekce

Žádná další lekce není. Resetujte sandbox a opakujte vybrané lekce, dokud vám postupy nepřijdou přirozené.

