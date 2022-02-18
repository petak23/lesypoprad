# Komponenta pre zobrazenie lonuky jazykových mutácii webu

**Inštalácia**
1. nakopírovanie archývu do `app\components`,
2. do `app\FrontModule\presenters\BasePresenter` doplniť `use PeterVojtech\MainLayout\LangMenu\LangMenuTrait;`,
4. do `app\FrontModule\config\services.neon` doplniť:
```neon
services:
  LangMenuControl:
    implement: PeterVojtech\MainLayout\LangMenu\ILangMenuControl
    arguments:
      nastavenie: %user_panel%

```
5. do hlavného template `@layout.latte` doplniť na koniec `{control langMenu}`.