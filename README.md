# Web Security Training - Docker Umgebung

Dieses Repository stellt eine vollständig konfigurierte und sofort einsatzbereite [Kali Linux](https://www.kali.org/) Docker-Umgebung für Web-Security-Kurse bereit. Sie enthält alle notwendigen Tools, die für den Kurs benötigt werden.

Der Vorteil dieser Umgebung ist, dass keine virtuelle Desktop-Umgebung eingerichtet und keine Kali-Tools auf dem eigenen Host-System installiert werden müssen. Alle Komponenten laufen isoliert in einem Docker-Container.

---
## Features

Die Docker-Umgebung enthält unter anderem:
* Eine stabile Version von **Kali Linux** als Basis.
* Die wichtigsten Metapackages für Web-Security (`kali-tools-web`).
* Moderne Fuzzer wie **ffuf**, **gobuster** und **feroxbuster**.
* Wichtige Sammlungen für Payloads und Wordlists (**PayloadsAllTheThings** und **SecLists**).
* Einen persistenten **Workspace**, um Arbeit und Notizen zu speichern.

---
## Voraussetzungen

Vor der Inbetriebnahme müssen die folgenden Voraussetzungen erfüllt sein:

1.  **Docker Desktop installiert**
    [Docker Desktop](https://www.docker.com/products/docker-desktop/) muss auf dem Host-System (Mac, Windows oder Linux) installiert und gestartet sein.

2.  **Burp Suite Community Edition installiert**
    [Burp Suite](https://portswigger.net/burp/communitydownload) wird als primärer HTTP-Proxy verwendet. Die kostenlose **Community Edition** sollte direkt auf dem Host-System installiert werden.

3.  **PortSwigger Academy Account**
    Praktische Übungen finden unter anderem in der Web Security Academy von PortSwigger statt. Ein kostenloser Account sollte im Vorfeld hier erstellt werden: [https://portswigger.net/web-security](https://portswigger.net/web-security)

---
## Schnellstart-Anleitung

Die Inbetriebnahme der Lernumgebung erfolgt in diesen Schritten.

### 1. Repository klonen

Dieses Git-Repository wird auf den lokalen Rechner geklont. Anschließend wird in das neu erstellte Verzeichnis gewechselt.

```bash
git clone <URL_DES_REPOSITORIES>
cd <NAME_DES_VERZEICHNISSES>
```

### 2. Docker-Container starten

Der folgende Befehl baut das Docker-Image und startet den Container im Hintergrund.

```bash
docker compose up -d --build
```
* `--build`: Baut das Image basierend auf dem `Dockerfile`. Dies ist beim ersten Mal und nach Änderungen notwendig.
* `-d`: Startet den Container im "detached" Modus (im Hintergrund).

### 3. Mit der Shell verbinden

Der Container läuft im Hintergrund. Eine interaktive `bash`-Shell wird mit dem folgenden Befehl geöffnet:

```bash
docker compose exec kali-websec bash
```
Nach der Ausführung wird die Willkommensnachricht im Terminal des Kali-Containers angezeigt. 🚀

---
## Wichtige Arbeitsabläufe

### Arbeiten mit dem Workspace

Der Ordner `workspace` in diesem Repository ist direkt mit dem Verzeichnis `/workspace` im Container verbunden.

* Dateien, die **im Container** in diesem Ordner abgelegt werden, erscheinen **auf dem Host-Rechner**.
* Dateien, die **auf dem Host-Rechner** in diesen Ordner gelegt werden, erscheinen **im Container**.

Dieser Ordner dient zur Speicherung von Notizen, Skripten und Ergebnissen, damit diese bei Beendigung des Containers nicht verloren gehen.

### Burp Suite verwenden

Burp Suite läuft auf dem Host-System. Um den Traffic von Tools innerhalb des Containers durch Burp zu leiten, muss die spezielle Docker-interne Adresse `host.docker.internal` verwendet werden. Der Standard-Port für Burp ist `8080`.

**Beispiel mit `sqlmap`:**
```bash
sqlmap -u "http://beispiel.com" --proxy=http://host.docker.internal:8080
```

**Beispiel mit `gobuster`:**
```bash
gobuster dir -u https://beispiel.com -w /path/to/wordlist --proxy http://host.docker.internal:8080 -k
```

**Beispiel mit `ffuf`:**
```bash
ffuf -w /path/to/wordlist -u https://FUZZ.beispiel.com -x http://host.docker.internal:8080
```

---
## Beenden der Umgebung

Nach Abschluss der Arbeit wird der Container mit dem folgenden Befehl gestoppt und entfernt.

```bash
docker compose down
```
Dieser Befehl löscht den Container. Der Inhalt des `workspace`-Ordners auf dem Host-System bleibt erhalten.

---
## Wichtige Online-Ressourcen

Diese Sammlung von Links dient als Ergänzung zu den im Training behandelten Themen und als wertvolle Ressource für die zukünftige Arbeit.

### PortSwigger
* **Web Security Academy**
    Umfassende Ressource zum interaktiven Lernen von Web Security.
    * [https://portswigger.net/web-security](https://portswigger.net/web-security)

* **Cheat Sheets**
    Schnelle Referenzen und technische Details für gängige Angriffstechniken.
    * **XSS:** [https://portswigger.net/web-security/cross-site-scripting/cheat-sheet](https://portswigger.net/web-security/cross-site-scripting/cheat-sheet)
    * **SQLi:** [https://portswigger.net/web-security/sql-injection/cheat-sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet)
    * **SSRF:** [https://portswigger.net/web-security/ssrf/url-validation-bypass-cheat-sheet](https://portswigger.net/web-security/ssrf/url-validation-bypass-cheat-sheet)

### OWASP (Open Worldwide Application Security Project)
* **OWASP Cheat Sheet Series**
    Eine Sammlung von kompakten Sicherheitsinformationen zu spezifischen Themen.
    * [https://cheatsheetseries.owasp.org/](https://cheatsheetseries.owasp.org/)

* **OWASP Application Security Verification Standard (ASVS)**
    Ein Framework zum Testen der technischen Sicherheitsmaßnahmen in Webanwendungen und ein Leitfaden für sichere Entwicklung.
    * [https://github.com/OWASP/ASVS](https://github.com/OWASP/ASVS)