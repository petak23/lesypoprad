# Manuál pre grid.
*posledná zmena: 24.06.2022*

## Komponenta: GridFooter.vue

Vytvorenie pätičky gridu. Obsahuje časti: *počet položiek, stránkovanie, výber počtu položiek na stránku*. **Stránkovanie** sa zobrazuje len ak je vypočítaný väčší počet stránok ako 1. **Výber počtu položiek** sa zobrazuje len ak je počet položiek väčší ako 10.

**Property**

| Názov       | typ    | Povinný | Východzia hodnota | Popis                     |
|-------------|--------|---------|-------------------|---------------------------|
| basePath    | String | Áno     | ---               | Základná cesta v adrese   |
| baseApiPath | String | Áno     | ---               | Základná časť cesty k API |
| currentLang | String | Nie     | sk                | Skratka aktuálneho jazyka |
| id          | String | Áno     | ---               | Id časti                  |
| items_count | Number | Áno     | ---               | Celkový počet položiek    | 


**Emity**

| Názov                  | Popis                                           | Parametre                                |
|------------------------|-------------------------------------------------|------------------------------------------|
| changed_items_per_page | Posielaný po úspešnej zmene položiek na stránku | id, items_per_page_selected, currentPage |
| current_page           | Posielaný pri zmene aktuálnej stránky           | id, currentPage              |

**Reakcie cez $root.$on**

žiadne

----

## Komponenta: SelectCell.vue

V gride vytvorí po kliku editovateľný select box.

**Property**

| Názov       | typ    | Povinný | Východzia hodnota | Popis                     |
|-------------|--------|---------|-------------------|---------------------------|
| value       | ---    | Nie     | ''                | Hodnota prvku             |
| apiLink     | String | Áno     | ---               | Základná časť cesty k API |
| colName     | String | Áno     | ---               | Názov príslušného stípca  DB tabuľky |
| id          | Number | Áno     | ---               | Id prvku v DB tabuľke     |
| options     | Array  | Áno     | ---               | Položky select boxu       |

**Emity**

| Názov                  | Popis                                           | Parametre                                |
|------------------------|-------------------------------------------------|------------------------------------------|
| flash_message          | Info o výsledku uloženia hodnoty do DB tabuľky | message, type, heading |

----

## Komponenta: TextCell.vue

V gride vytvorí po kliku editovateľné textové pole. 

**Property**

| Názov       | typ    | Povinný | Východzia hodnota | Popis                     |
|-------------|--------|---------|-------------------|---------------------------|
| value       | String | Nie     | ''                | Hodnota prvku             |
| apiLink     | String | Áno     | ---               | Základná časť cesty k API |
| colName     | String | Áno     | ---               | Názov príslušného stípca  DB tabuľky |
| id          | Number | Áno     | ---               | Id prvku v DB tabuľke     |

**Emity**

| Názov                  | Popis                                           | Parametre                                |
|------------------------|-------------------------------------------------|------------------------------------------|
| flash_message          | Info o výsledku uloženia hodnoty do DB tabuľky | message, type, heading |
