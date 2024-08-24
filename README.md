# Eurofarma Training Management App

Este projeto é um aplicativo mobile desenvolvido em Flutter para a Eurofarma, com o objetivo de gerenciar treinamentos e supervisionar funcionários. O aplicativo diferencia o acesso entre funcionários padrão e o departamento de RH, proporcionando uma experiência personalizada para cada usuário.

## Funcionalidades

- **Tela de Seleção de Usuário**: Permite que o usuário escolha entre "Funcionário" e "RH".
- **Login de Funcionários**: Login para usuários padrão que não fazem parte do RH.
- **Login RH**: Login para usuários do departamento de RH.
- **Tela de Treinamentos**: Lista os treinamentos disponíveis para os funcionários e o progresso em cada um.
- **Registro de Funcionário**: Permite que o RH registre novos funcionários no sistema, atribuindo treinamentos automaticamente.
- **Tela de Perfil**: Exibe as informações de perfil do usuário, permitindo edição dos dados.

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento de aplicativos multiplataforma.
- **Dart**: Linguagem de programação utilizada pelo Flutter.
- **SweetAlert**: Para exibição de alertas personalizados na interface.

## Como Executar o Projeto

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/eurofarma-training-app.git
   cd eurofarma-training-app
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**:
   ```bash
   flutter run
   ```
