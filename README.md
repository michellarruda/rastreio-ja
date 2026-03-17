# 📦 Rastreio Já

> Rastreamento de pacotes multiplataforma — Web, iOS e Android

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Funcionalidades

- Rastreamento de pacotes dos Correios via API SeuRastreio
- Adicionar pacotes por código de rastreio com apelido opcional
- Timeline completa de eventos de rastreamento
- Notificações locais quando o status do pacote muda
- Sistema de temas com 4 presets (Vitality, Ocean, Sunset, Minimal)
- Modo claro e escuro persistido localmente
- Layout adaptativo — NavigationRail no desktop/web, BottomNavigationBar no mobile
- Animações de entrada na lista de pacotes
- Swipe para deletar pacotes
- Pull-to-refresh na tela principal

## 🛠️ Stack

| Camada | Tecnologia |
|---|---|
| Framework | Flutter 3.x / Dart 3.x |
| State Management | Riverpod 2.x |
| Navegação | GoRouter 13.x |
| HTTP | Dio 5.x |
| Storage local | Hive 2.x |
| Preferências | SharedPreferences |
| Notificações | flutter_local_notifications |
| Testes | flutter_test + mocktail |

## 🏗️ Arquitetura

Clean Architecture com separação em camadas:

    lib/
    ├── core/               # Constantes, tema, roteamento, rede, storage, utils
    ├── features/
    │   ├── tracking/       # Feature principal de rastreamento
    │   │   ├── data/       # Models, datasources, repository impl
    │   │   ├── domain/     # Entities, repository interface, usecases
    │   │   └── presentation/ # Providers, screens, widgets
    │   ├── settings/       # Tela de configurações e ThemePicker
    │   └── carriers/       # Interface base para transportadoras
    └── main.dart

## 🚀 Como executar

### Pré-requisitos

- Flutter >= 3.16.0
- Dart >= 3.0.0
- Chave de API do [SeuRastreio](https://seurastreio.com.br)

### Setup

    # Clone o repositório
    git clone https://github.com/michellarruda/rastreio-ja.git
    cd rastreio-ja

    # Instale as dependências
    flutter pub get

    # Gere os arquivos de code generation
    dart run build_runner build --delete-conflicting-outputs

### Configurar a chave da API

Abra `lib/core/constants/app_constants.dart` e substitua:

    static const apiKey = 'COLOQUE_SUA_CHAVE_AQUI';

pela sua chave gerada no dashboard do SeuRastreio.

### Executar

    # Web
    flutter run -d chrome

    # Android
    flutter run -d android

    # iOS
    flutter run -d ios

### Testes

    flutter test

## 🎨 Temas disponíveis

| Preset | Cor primária |
|---|---|
| Vitality | Teal `#2ECFCF` |
| Ocean | Azul `#1A73E8` |
| Sunset | Coral `#FF6B6B` |
| Minimal | Grafite `#2D3436` |

## 📡 API

O app utiliza a [API pública do SeuRastreio](https://seurastreio.com.br/api-docs):

- **Endpoint**: `GET /api/public/rastreio/{codigo}`
- **Auth**: Bearer token no header `Authorization`
- **Rate limit**: 10 req/min por IP
- **Transportadoras suportadas**: Correios, Total Express

## 🗺️ Roadmap

- [ ] Suporte a múltiplas transportadoras (Total Express, Jadlog)
- [ ] Notificações push via Firebase
- [ ] Widget de rastreamento para iOS e Android
- [ ] Importação de códigos via câmera (QR Code)
- [ ] Compartilhamento de rastreamento

## 📄 Licença

MIT © [Michel Larruda](https://github.com/michellarruda)