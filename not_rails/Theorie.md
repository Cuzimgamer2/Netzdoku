# Tag 1
## **Q:** 1. Was ist der Unterschied zwischen einer Klasse und einem Objekt? Zeig es an deinem Router-Beispiel.

## **A:** 
eine Klasse ist der "Bauplan" und das Objekt ist die initialisierte Klasse.

```ruby
class Router < NetworkDevice
  attr_reader :routing_table

  def initialize(name, ip_address, status, routing_table)
    super(name, ip_address, status)
    @routing_table = routing_table
  end

  def describe
    "infos: #{name}, #{ip_address}, #{status}, #{@routing_table}"
  end
end
```
Hier ist der Bauplan ohne Werte nur mit Attributen und Methoden

```ruby
router = Router.new("mikrotik", "1.1.1.1", "running", [20, 20])
puts router.describe
```
Und hier wird das Objekt "router" aus der Klasse "Router" mit .new erstellt und mit Werten befüllt


## **Q:** 2. Wo genau in deinem Code siehst du Kapselung? Was würde passieren, wenn du stattdessen attr_accessor :status genutzt hättest?

## **A:** 
Kasplung gibt es in meinem code durch die verwendung von def update_status!().  
`attr_reader :status`: Lesen von außen erlaubt, Schreiben von außen nicht erlaubt.  
`attr_accessor :status`: Lesen und Schreiben von außen erlaubt.  
 Deshalb wird im Code `attr_reader` verwendet und die Änderung über `update_status!` kontrolliert. Ansonsten könnte man einen ungültigen Status setzen

## **Q:** Erkläre Vererbung vs. Komposition an einem eigenen Beispiel – wäre AccessPoint erbt von NetworkDevice in jedem Fall die beste Lösung, oder hätte Komposition (has_a statt is_a) an einer Stelle mehr Sinergeben?


## **A:** 
### Vererbung
Hier erbt AccessPoint von NetworkDevice, weil ein AccessPoint ein Netzwerkgerät ist und deshalb gemeinsame Attribute wie name, ip_address und status besitzt.
```ruby
class AccessPoint < NetworkDevice
end
```

### Komposition
Hier gehört die Routingtabelle zu dem Router, ich könnte die Routingtabelle aber auch als Klasse definieren und dem Router als Objekt übergeben. Dann würde der Router die Routingtabelle verwenden, ansatt die gesamte Funktionalität selbst zu implementieren.
```ruby
class Router < NetworkDevice
  def initialize(name, ip_address, status, routing_table)
    super(name, ip_address, status)
    @routing_table = routing_table
  end
end
```
in meinem Beispiel ist Vererbung für AccessPoint sinnvoll, weil er ein Netzwerkgerät ist. Komposition wäre beispielsweise für die Routingtabelle sinvoller weil ein Router ja eine Routingtabelle besitzt. Dafür müsste aber die Routingtabelle als eigene Klasse eingebaut werden.

# Tag 2
## **Q:** Warum hat Ruby keine Mehrfachvererbung, aber Module? Was ist der Unterschied zu Interfaces in Java/C#?
## **A:** 
Mehrfachvererbung kann zu Konflikten führen, wenn mehrere Eltern dieselben Methoden oder Attribute besitzen da dann nicht eindeutig ist, von welcher Elternklasse eine Methode oder ein Attribut kommen soll, wenn beide diesselbe anbieten.

Der Unterschied zwischen Interfaces ist, dass ruby die fertige Methode direkt mitliefert und per include eingebunden wird und nicht im klassenaufruf wie bei Java/C#

## **Q:** Wann würdest du ein Modul statt einer Vererbungshierarchie wählen?
## **A:** 
Ich würde ein Modul verwenden, wenn unterschiedliche Klassen ein bestimmtes Verhalten oder eine bestimmte Funktion gemeinsam haben. Eine Vererbung würde ich verwenden, wenn die Klassen in einer Beziehung zueinander stehen und gemeinsame Eigenschaften und Verhalten von einer Basisklasse übernehmen sollen.

# Tag 3
## **Q:** Was übernimmt ActiveRecord von der objektorientierten Modellierung, und was ist reine “Datenbank-Magie”?
## **A:**
ActiveRecord übernimmt die objektorientierte Modellierung, indem ich Klassen wie Customer, Contract und Device erstellen und Beziehungen mit has_many und belongs_to definieren kann. Die Datenbankseite übernimmt ActiveRecord automatisch, zum Beispiel wird bei customer:references eine customer_id-Spalte angelegt und bei customer.contracts die passende Datenbankabfrage automatisch ausgeführt.

## **Q:**  Was ist der Unterschied zwischen einem PORO (Plain Old Ruby Object) und einem ActiveRecord-Modell? Wann würdest du bewusst kein ActiveRecord-Modell verwenden?
## **A:**
Ein PORO ist eine normale Ruby-Klasse ohne automatische Datenbankanbindung. Man benutzt es also wenn nur wenn eine Klasse nur eine bestimmte Logik ausführt und keinen eigenen Datensatz in der Datenbank repräsentiert. Ein ActiveRecord-Modell erbt dagegen von ApplicationRecord und kann so mit der Datenbank arbeiten. In meinem Projekt ist Device ein ActiveRecord-Modell, weil Geräte in der Datenbank gespeichert werden sollen.

# Tag 4
## **Q:** Was sind die Nachteile von STI? Wann wäre eine polymorphe Assoziation  polymorphic: true) die bessere Wahl?

## **A:**
Da bei STI alle Unterklassen in eine Datenbanktabelle gespeichert werden, können viele Spalten entstehen, die für bestimmte Typen gar nicht gebraucht werden. Eine polymorphe Assoziation wäre sinnvoll, wenn ein Objekt mit verschiedenen Modelltypen verbunden sein kann. Zum Beispiel könnte ein Comment zu einem Customer, Contract oder Device gehören.

## **Q:** Verstößt STI in deinem Fall gegen das Liskov-Substitutionsprinzip? Begründe konkret an deinem Beispiel

## **A:**
In meinem Fall verstößt STI gegen das Liskov-Substitutionsprinzip, wenn Code von jedem Device eine Routing-Tabelle erwarten würde, könnte ein Switch oder AccessPoint diese Anforderung nicht sinnvoll erfüllen.

```ruby
class Router < Device
  def show_routing_table
    "routing table: "
  end
end
```

# Tag 5
## **Aufgabe** Baue bewusst 3 Fehler ein und finde sie am nächsten Tag und dokumentiere deren Auswirkung

## **1:**
In .\router.rb hatte ich ein "super" gelöscht. Das fürhrt dazu dass die Initialisierung des Objektes Router fehlschlägt, da ich nicht mehr die Atttribute aus dem NetworkDevice inizialisiert habe,
somit schlägt das hier fehl
```ruby
def initialize(name, ip_address, status, routing_table)
  (name, ip_address, status)
  @routing_table = routing_table
end

router = Router.new("mikrotik", "1.1.1.1", "running", [20, 20])

```

## **2:**
In netzdoku\app\models\switch.rb hatte ich nur das "<" gegen ein ">" ausgetauscht, dadurch erbt Switch wegen dem Syntaxfehler nicht mehr von Device

## **3:**
In netzdoku\app\models\contract.rb hatte ich hier die Beziehung von "has_many" auf "belongs_to" gesetzt. Das ist einmal falsch da "belongs_to" normalerweise nur auf ein einzelnes Objekt zeigt, außerdem kann ein Auftrag mehrere Geräte beeinhalten, das wäre der zweite Grund
```ruby
class Contract < ApplicationRecord
  belongs_to :customer
  belongs_to :devices
end
```

# Tag 6-7
## Fat Controller
```ruby
class ContractsController < ApplicationController
  def create
    contract = Contract.create!(customer: current_customer)
    device = Device.find(params[:device_id])
    device.update!(contract: contract)
    puts("#{current_customer} sie haben eine neue benachrichtigung")
  end
end
```
## **Q:** 1. Welches SOLID-Prinzip wird durch den ursprünglichen “Fat Controller” verletzt?

## **A:**
### Single Responsibility Principle (SRP)
```ruby
def create
  contract = Contract.create!(customer: current_customer)
  device = Device.find(params[:device_id])
end
```
- Hier regelt der Controller die Vertragsanlage und Gerätezuweisung
### Open/Closed Principle (OCP)
```ruby
puts("#{current_customer} sie haben eine neue benachrichtigung")
```
- für jede neue Art einer Benachrichtigung muss der Controller geändert werden

## Nicht verletzt werden:
### - Liskov Substitution Principle (LSP)
### - Interface Segregation Principle (ISP)
### - Dependency Inversion Principle (DIP)

## **Q:** 2. Was ist der Vorteil von Service Objects gegenüber “Fat Models” oder “Fat Controllers”? Wo liegen die Grenzen (Overengineering)?

## **A:**
Der klare Vorteil von Service Objekten ist, dass jede Klasse eine eigene Aufgabe hat, was den Code übersichtlicher und organisierter macht, siehe SRP. Fat Models hingegen machen mehrere Aufgaben in einem Controller. Mit Overengineering ist gemeint, dass wennm man nur einen kleinen Controller mit z.B. zwei Aufgaben hat, es manchmal sinnvol sein kann, diese beiden Aufgaben nicht noch extra aufzuteilen, wennn man z.B. nicht plant ein Programm weiterzuentwickeln oder diese beiden Aufgaben sich sehr ähneln. Man muss also manchmal abwiegen ob es für kleine Controller nicht sinnvoller ist, sie als "Fat Model" zu belassen.

# Tag 8-9

## **Q:** 1. Ruby hat keine expliziten Interfaces wie Java. Wie stellst du trotzdem sicher, dass alle Notification-Klassen die erwartete Methode implementieren? Diskutiere Duck Typing vs. das NotImplementedError-Pattern in der Basisklasse.

## **A:**
Durch Duck Typing können alle Notification-Klassen dieselbe Methode "send_message" implementieren. Dadurch kann der NotificationSender alle Klassen verwenden, ohne deren konkreten Typ kennen zu müssen. Mit Duck-Typing brauch ich keine Basisklasse da alle Objekte die Methode nur besitzen müssen und mit einer Basisklasse hätte man eine zeile mit "raise NotImplementedError" und alle Klassen müssten von der Basisklasse erben.

## **Q:** 2. Was ist Duck Typing, und warum passt der Name?

## **A:**
Duck Typing ist ein Konzept, bei dem der Typ eines Objekts nicht durch seine Klasse festgelegt wird, sondern durch das Vorhandensein bestimmter Methoden oder Eigenschaften. "if it walks like a duck and quacks like a duck it's probably a duck", heißt also es wird beim Objekt nicht auf die Klasse geguckt sondern die Methoden und Eigenschaften entscheiden was es für ein Typ ist.

## **Q:** 3. Warum ließ sich SmsNotification ergänzen, ohne bestehenden Code zu ändern? Welches SOLID-Prinzip zeigt sich hier?

## **A:**
SmsNotification konnte ergänzt werden, ohne bestehenden code zu verändern, da das Konzept Duck Typing benutzt wurde, weswegen der NotificationSender den Typen des Objekts, anhand der implimentierten Methode (hier send_message) beurteilt hat und dadurch nicht wissen muss um welchen Typ es sich handelt. Das OCP ist das einzige "SOLID-Prinzip" was hier relevant ist.

# Tag 10

## **Abschlussfragen** 1. Welche der 10 Aufgaben hat dir das Konzept “Objektorientierung” am klarsten gemacht, und warum? 

## **A:**
Ich würde sagen am klarsten hat mir das Konzept "Objektorientierung", Tag 1 gemacht, da ich auf niedrigem Niveu die einzelnen Teile von OOP gelernt habe, also Attribute, Basis/Unterklassen usw.

## **Abschlussfragen** 2. Wenn du das Projekt nochmal von vorne beginnen würdest – was würdest du objektorientiert anders lösen?

## **A:**
Objektorientiert würde ich warscheinlich nichts anders machen, außer z.b keinen Fat Controller einbauen (also absichtliche Fehler), außerdem würde ich warscheinlich mehr tests einbauen und praktische Versuche machen, damit man den code und die Fehler besser versteht

## **Abschlussfragen** 3. Nenne drei konkrete Design-Entscheidungen aus deinem Projekt und begründe jeweils in 2–3 Sätzen, warum du dich so entschieden hast.

## **A:**
not_rails\network_device.rb
Ich habe mich dazu entschieden, den Status über eine eigene Methode namens update_status! zu ändern. Dabei wird zuerst geprüft, ob der neue Status gültig ist, bevor er übernommen wird. So kann verhindert werden, dass ein Gerät einen ungültigen Status bekommt.
Ansonsten habe ich weil es vorgegeben war, der Anweisung der Aufgaben genau gefolgt und nichts selber erfunden sondern Kriterien erfüllt.