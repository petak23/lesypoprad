# Komponenta zobraz karty podčlánkov

*Vypísanie podčlánkov na kartách. *

Vytvorené špeciálne pre sutaz.lesypoprad.sk

**Inštalácia**
1. nakopírovanie archývu do `app\components`,
2. do `app\AdminModule\presenters\ArticlePresenter` doplniť `use PeterVojtech\Clanky\ZobrazKartyPodclankov\zobrazKartyPodclankovTrait;`,
3. do `app\FrontModule\presenters\ClankyPresenter` doplniť `use PeterVojtech\Clanky\ZobrazKartyPodclankov\zobrazKartyPodclankovTrait;`,
4. do `app\config\komponenty.neon` doplniť:
```neon
parameters:
  komponenty:
#...
    zobrazKartyPodclankov:
      nazov: 'Zobrazenie podčlánkov na kartách'
      jedinecna: TRUE
      fa_ikonka: 'columns'
      parametre:
        template:
          nazov: 'Názov vzhľadu'
          hodnoty: 
            default: 'Základný'
#...

# Component Clanky\ZobrazKartyPodclankov
  - PeterVojtech\Clanky\ZobrazKartyPodclankov\IAdminZobrazKartyPodclankovControl
  - PeterVojtech\Clanky\ZobrazKartyPodclankov\IFrontZobrazKartyPodclankovControl
```