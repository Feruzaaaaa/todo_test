
# Todo Project (Flutter + MVVM)

Небольшое приложение для управления задачами с drag-and-drop, построенное на Flutter и архитектуре MVVM. Интерфейс выполнен в стиле карточек с расширяемыми секциями и кастомным диалогом создания задачи.

## Возможности

- четыре статуса задач: «К выполнению», «В работе», «На проверке», «Выполнено»;
- перетаскивание задач между статусами;
- акцент на UX: подсветка целей drop-зоны, плавающие лейблы в полях, индикатор «Просрочена»;
- локальное хранение данных через Hive;
- адаптация интерфейса под веб (Chrome) и мобильные платформы.

## Технический стек

- Flutter 3.x
- MVVM с `ChangeNotifier` + `provider`
- Hive / Hive Flutter
- Google Fonts
- Intl (локаль `ru`)

## Структура

```
assets/                  # иконки (bookmark/calendar/trash)
lib/
 ├─ main.dart            # инициализация Hive + provider
 ├─ models/              # Task (HiveModel)
 ├─ services/            # StorageService
 ├─ viewmodels/          # TodoViewModel
 └─ views/
    ├─ screens/          # TodoScreen
    └─ widgets/
       ├─ cards/         # TaskItemContent, TodoStatusCard
       ├─ dialogs/       # CreateTaskDialog + компоненты
       └─ items/         # DraggableTaskItem
```

## Сборка / тестирование

- `flutter test` – Юнит/виджет-тесты (при наличии)
- `flutter build apk` / `flutter build web` – для релизных сборок

## Автор

Feruza (GitHub: [Feruzaaaaa](https://github.com/Feruzaaaaa))


