# rastreio_ja

Rastreio Ja - Rastreamento de pacotes multiplataforma

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


✅ Lista de Tarefas — Ordem de Execução
Fase 1 — Setup e Infraestrutura

 T01 — Criar projeto Flutter com suporte Web + iOS + Android
 T02 — Configurar pubspec.yaml com todas as dependências
 T03 — Configurar analysis_options.yaml (linting rigoroso)
 T04 — Implementar estrutura de pastas (Clean Architecture)
 T05 — Configurar Hive com adapters gerados por code gen
 T06 — Configurar Dio com interceptors (log, erro, retry)
 T07 — Configurar GoRouter com todas as rotas
Fase 2 — Sistema de Temas

 T08 — Criar paleta de cores baseada no design Vitality (teal/cyan)
 T09 — Implementar ThemeData light e dark com ColorScheme
 T10 — Criar 4+ presets de temas (Vitality, Ocean, Sunset, Minimal)
 T11 — Implementar ThemeNotifier com Riverpod + persistência em SharedPreferences
 T12 — Criar widget ThemePicker na tela de settings
Fase 3 — Feature de Rastreamento

 T13 — Implementar PackageModel com Hive adapter
 T14 — Implementar TrackingLocalDataSource (CRUD Hive)
 T15 — Integrar API SeuRastreio (GET /rastreio/{codigo})
 T16 — Implementar TrackingRepository com cache local + fetch remoto
 T17 — Implementar UseCases (Add, Get, Delete, Refresh)
 T18 — Implementar Riverpod providers para estado dos pacotes
 T19 — Construir HomeScreen com lista de pacotes (design Vitality)
 T20 — Construir AddPackageScreen com validação de código
 T21 — Construir PackageDetailScreen com timeline de eventos
 T22 — Implementar widgets reutilizáveis (card, badge de status, timeline)
Fase 4 — UX e Polimento

 T23 — Implementar pull-to-refresh na home
 T24 — Implementar notificação de atualização de status (local notifications)
 T25 — Responsividade Web (layout adaptativo para telas grandes)
 T26 — Animações de transição entre telas (Hero, Fade)
 T27 — Empty states e error states com ilustrações
Fase 5 — Extensibilidade

 T28 — Implementar CarrierInterface base para novas transportadoras
 T29 — Adicionar suporte a múltiplas carriers na UI (selector de transportadora)
 T30 — Testes unitários dos UseCases e Repository
