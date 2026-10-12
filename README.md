# Netzdoku

Netzdoku ist ein Ruby-on-Rails-Projekt zur Netzwerkdokumentation. Es beschäftigt sich mit der Verwaltung von Kunden, Verträgen und Netzwerkgeräten.

## Technologien

- Ruby
- Ruby on Rails
- SQLite
- RSpec und Minitest

## Funktionen und Lerninhalte

- Objektorientierte Programmierung mit Ruby
- Netzwerkgeräte: Router, Switches und Access Points
- Kunden, Verträge und Geräte mit Active Record
- Single Table Inheritance (STI)
- Service Objects zur Trennung von Verantwortlichkeiten
- Polymorphismus und verschiedene Benachrichtigungskanäle
- Automatisierte Tests

## Voraussetzungen

- Ruby in der zum Projekt passenden Version
- Bundler
- SQLite

## Installation

Repository klonen und in das Rails-Projekt wechseln:

```bash
git clone https://github.com/Cuzimgamer2/Netzdoku.git
cd Netzdoku/netzdoku
```

Abhängigkeiten installieren:

```bash
bundle install
```

Datenbank vorbereiten:

```bash
bin/rails db:prepare
```

Anwendung starten:

```bash
bin/rails server
```

Danach ist die Anwendung normalerweise unter http://localhost:3000 erreichbar.

## Tests

Alle RSpec- und Minitest-Tests ausführen:

```bash
bundle exec rspec
bin/rails test
```

## Status

Das Projekt wird im Rahmen einer Ausbildung entwickelt und schrittweise erweitert.