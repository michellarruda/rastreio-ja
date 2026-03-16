// Rastreio Já — Strings e labels
library;

abstract final class AppStrings {
  static const appName       = 'Rastreio Já';
  static const appTagline    = 'Seus pacotes, sempre em vista';
  static const appVersion    = '1.0.0';

  static const homeTitle         = 'Meus Pacotes';
  static const homeEmpty         = 'Nenhum pacote cadastrado ainda';
  static const homeEmptySubtitle = 'Toque no + para adicionar seu primeiro rastreio';

  static const addPackageTitle     = 'Adicionar Pacote';
  static const addPackageCodeLabel = 'Código de rastreio';
  static const addPackageCodeHint  = 'Ex: BR123456789BR';
  static const addPackageNameLabel = 'Apelido (opcional)';
  static const addPackageNameHint  = 'Ex: Tenis Nike, Pedido 123';
  static const addPackageButton    = 'Adicionar';

  static const detailTitle      = 'Detalhes do Pacote';
  static const detailRefresh    = 'Atualizar';
  static const detailLastUpdate = 'Ultima atualizacao';

  static const settingsTitle       = 'Configuracoes';
  static const settingsTheme       = 'Tema do aplicativo';
  static const settingsThemeLight  = 'Claro';
  static const settingsThemeDark   = 'Escuro';
  static const settingsThemeSystem = 'Seguir sistema';
  static const settingsColorPreset = 'Esquema de cores';

  static const errorGeneric     = 'Algo deu errado. Tente novamente.';
  static const errorNetwork     = 'Sem conexao com a internet.';
  static const errorNotFound    = 'Codigo de rastreio nao encontrado.';
  static const errorInvalidCode = 'Codigo de rastreio invalido.';

  static const statusPosted    = 'Postado';
  static const statusInTransit = 'Em transito';
  static const statusOutForDel = 'Saiu para entrega';
  static const statusDelivered = 'Entregue';
  static const statusAlert     = 'Requer atencao';
  static const statusUnknown   = 'Status desconhecido';
}
