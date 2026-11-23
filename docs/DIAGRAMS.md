# Diagrams — how the lab works

GitHub renders these Mermaid diagrams natively. Arabic summaries under each.

## 1 · The study pipeline — from a shipped program to a verified study

```mermaid
flowchart TD
    A["Shipped program<br/>(EXE · APK · Electron · firmware)"] --> B{"Triage<br/>diec · capa"}
    B --> C["Identify the stack<br/>.NET · PyInstaller · Electron · native · Android"]
    C --> D["Decompile / unpack<br/>Ghidra · ILSpy · jadx · pyinstxtractor · asar"]
    D --> E["Ask the binary to describe itself<br/>strings · resources · manifests · embedded docs"]
    E --> F["Runtime observation<br/>run it, watch files / registry / network"]
    F --> G["Evidence log<br/>every claim tied to an artifact"]
    G --> H["Study report<br/>verified ≠ assumed, stated plainly"]
    H --> I{"New evidence<br/>proves a difference?"}
    I -- yes --> D
    I -- no --> J["Clean-room rebuild<br/>original code, tested"]
```

**بالعربية:** من البرنامج الجاهز → فرز أولي (نوعه وحزمته) → فكّ وتفكيك →
دَع البرنامج يصف نفسه (نصوصه وموارده ووثائقه المدمجة) → مراقبة وقت التشغيل →
سجلّ أدلة → تقرير دراسة يفصل المُتحقَّق من المفترَض → إعادة بناء نظيفة بكود
أصلي مختبَر. ولا يُعاد فتح أي جزء إلا بدليل جديد يثبت فرقاً.

## 2 · Which tool for which artifact

```mermaid
flowchart LR
    X["Artifact"] --> T{"Stack?"}
    T -- ".NET" --> I["ILSpy (ilspycmd)"]
    T -- "Android APK" --> J["jadx + REA bridge"]
    T -- "PyInstaller" --> P["pyinstxtractor → .pyc"]
    T -- "Electron" --> S["asar extract"]
    T -- "Native PE/ELF" --> G["Ghidra · Hopper"]
    T -- "Unknown" --> D["diec identifies it first"]
    I --> R["REA study"]
    J --> R
    P --> R
    S --> R
    G --> R
    D --> T
    C["capa — capability scan"] -.-> R
```

**بالعربية:** كل نوع برنامج له أداته: ‏.NET إلى ILSpy، أندرويد إلى jadx،
بايثون المجمّد إلى pyinstxtractor، إلكترون إلى asar، والأصلي إلى Ghidra —
وdiec يعرف النوع أولاً، وcapa يفحص القدرات.

## 3 · The lab layout — why it survives machine replacements

```mermaid
flowchart TD
    subgraph HOME["Persistent home — ~/tools"]
        BIN["bin/ — launchers<br/>rea · capa · diec · ilspycmd · pyinstxtractor · asar"]
        ENG["Engines<br/>ghidra_12.1.4 · jdk21 · dotnet · ilspy · capa · die"]
        DL["downloads/<br/>jadx-headless-mcp jar"]
    end
    BIN -- "env wiring:<br/>GHIDRA_INSTALL_DIR · JAVA_HOME · REA_JADX_MCP_JAR" --> ENG
    REA["rea doctor → healthy: true"] --> BIN
    OPT["/opt/hopper — Hopper (ephemeral)<br/>re-run: rea setup --yes --install-hopper"] -.-> BIN
```

**بالعربية:** كل شيء تحت `~/tools` في المجلد الدائم؛ المشغّلات توصِل المحركات
بمتغيرات بيئة صريحة، وما يعيش في مسارات مؤقتة (Hopper) يُعاد تثبيته بأمر واحد.

## 4 · From studies to the DZ family — clean-room only

```mermaid
flowchart LR
    S["Study practice<br/>reports stay with their projects"] --> B["Behaviour spec<br/>what it does, not its code"]
    B --> O["Original implementation<br/>per-year rules as data"]
    O --> V["Tests on real school files<br/>numbers verified"]
    V --> DZ["The DZ family<br/>timetable · RGF · survey · exam centre · library …"]
```

**بالعربية:** الدراسة تنتج «مواصفة سلوك» لا كوداً منقولاً؛ التنفيذ أصلي من
الصفر، والقواعد الرقمية بيانات مرقّمة حسب السنة الدراسية، والفحص على ملفات
المدرسة الحقيقية.
