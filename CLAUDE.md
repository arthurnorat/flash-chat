# CLAUDE.md - Preferências e Diretrizes do Projeto FlashChat

## Sobre o Projeto

O **FlashChat** é uma conversão do projeto Flash-Chat (UIKit + Firebase) para SwiftUI com AWS Amplify.

### Objetivo
- Converter todas as funcionalidades do Flash-Chat original para SwiftUI
- Substituir Firebase Authentication por AWS Cognito
- Substituir Firebase Firestore por AWS AppSync/API

---

## ⚠️ REGRA IMPORTANTE - NÃO GERAR CÓDIGO AUTOMATICAMENTE

**O desenvolvedor está estudando e precisa praticar escrevendo código para aprender.**

### Papel do Claude:
- ❌ **NÃO** gerar código automaticamente
- ✅ **EXPLICAR** o que precisa ser feito
- ✅ **ORIENTAR** sobre como implementar
- ✅ **RESPONDER** dúvidas quando o desenvolvedor perguntar
- ✅ **REVISAR** código que o desenvolvedor escrever, se solicitado
- ✅ **SUGERIR** melhorias e boas práticas
- ✅ **ATUALIZAR** o CLAUDE.md com progresso do projeto (autorizado)

### Fluxo de Trabalho:
1. Claude fornece **APENAS UM PASSO** de cada vez
2. Desenvolvedor executa o passo
3. Desenvolvedor retorna com o resultado
4. Claude fornece o próximo passo (repetir)

**⚠️ IMPORTANTE:** Não fornecer múltiplos passos de uma vez. Aguardar o retorno do desenvolvedor antes de continuar.

---

## Preferências do Desenvolvedor

- Arquitetura MVVM
- SwiftUI para todas as interfaces
- Código em português nos comentários (quando necessário)
- Seguir as convenções Swift padrão

---

## Histórico do Projeto - O que já foi feito

### Setup Inicial (08/10/2025)
1. ✅ Criado projeto limpo em SwiftUI no Xcode
2. ✅ Inicializado repositório Git
3. ✅ Commit inicial: "Initial commit: Clean SwiftUI project setup"

### Estrutura MVVM (08/10/2025)
4. ✅ Criada estrutura de pastas MVVM:
   - `/Models` - para modelos de dados
   - `/Views` - para interfaces SwiftUI
   - `/ViewModels` - para lógica de apresentação
   - `/Services` - para serviços (autenticação, API, etc)
   - `/Utils` - para utilitários
5. ✅ Commit: "feat: Add MVVM folder structure"

### Integração AWS Amplify (08/10/2025)
6. ✅ Instalado CocoaPods como gerenciador de dependências
7. ✅ Criado Podfile com dependências:
   - `Amplify` (framework principal)
   - `AWSPluginsCore`
   - `AmplifyPlugins/AWSCognitoAuthPlugin` (para autenticação)
   - `AmplifyPlugins/AWSAPIPlugin` (para API/GraphQL)
8. ✅ Executado `pod install`
9. ✅ Commit: "feat: Add CocoaPods with AWS Amplify dependencies"

### Documentação (09/10/2025)
10. ✅ Criado arquivo CLAUDE.md com preferências e histórico do projeto

### Resolução de Problemas com CocoaPods (09/10/2025)
11. ✅ Resolvido erro de build relacionado ao Sandbox do Xcode com CocoaPods
    - **Problema**: Erros "Operation not permitted" ao tentar buildar o projeto
    - **Solução**: Desabilitado "User Script Sandboxing" nas Build Settings do target
    - **Configuração**: Build Settings → `ENABLE_USER_SCRIPT_SANDBOXING` → definido como `No`
    - **Motivo**: O Sandboxing impedia os scripts do CocoaPods de copiar frameworks
12. ✅ Projeto buildando corretamente e Xcode Previews funcionando

### Configuração AWS Amplify CLI (09/10/2025)
13. ✅ Instalado Amplify CLI globalmente via npm
    - Comando: `npm install -g @aws-amplify/cli`
    - Versão instalada: 14.1.0
14. ✅ Corrigido problema de permissões do Amplify
    - Comando: `sudo chown -R $(whoami):$(id -gn) ~/.amplify`
15. ✅ Configurado Amplify CLI com credenciais AWS
    - Comando: `amplify configure`
    - Região selecionada: `sa-east-1` (São Paulo)
    - Criado usuário IAM: `amplify-dev`
    - Permissão: `AdministratorAccess-Amplify`
    - Access Keys criadas e configuradas localmente
    - Profile: `default`
16. ✅ Corrigido .gitignore para incluir .xcworkspace no controle de versão
    - Removidas linhas que ignoravam `*.xcworkspace`
    - Necessário para projetos que usam CocoaPods

### Inicialização do Amplify no Projeto (10/10/2025)
17. ✅ Executado `amplify init` para inicializar o Amplify no projeto
    - Nome do projeto: `FlashChat`
    - Environment: `dev`
    - Editor: `Xcode`
    - App type: `ios`
    - Método de autenticação: `AWS profile` (default)
    - Criada estrutura de pastas `amplify/`
    - Arquivos de configuração adicionados ao Xcode
    - `.gitignore` atualizado automaticamente pelo Amplify
18. ✅ Adicionados CLAUDE.md e .gitignore ao Xcode para facilitar edição

### Configuração AWS Cognito (11/10/2025)
19. ✅ Executado `amplify add auth` para adicionar autenticação
    - Configurado AWS Cognito User Pool
20. ✅ Executado `amplify push` para provisionar recursos na AWS
    - **Criados na AWS**:
      - User Pool (Cognito) - gerenciamento de usuários
      - User Pool Clients (Web e Native) - autenticação
      - Identity Pool - credenciais AWS
      - IAM Roles - permissões
    - Arquivos gerados: `amplifyconfiguration.json` e `awsconfiguration.json`
21. ✅ Resolvido problema de imports do Amplify no código Swift
    - **Problema**: Erro "No such module 'AWSCognitoAuthPlugin'"
    - **Solução**: Usar `import AmplifyPlugins` ao invés de `import AWSCognitoAuthPlugin`
    - **Causa**: O CocoaPods instala o módulo como `AmplifyPlugins` (genérico)
    - Executado `pod deintegrate && pod install` para limpar e reinstalar
    - Limpado cache do Xcode: `rm -rf ~/Library/Developer/Xcode/DerivedData`
22. ✅ Configurado Amplify no `FlashChatApp.swift`
    - Imports: `Amplify` e `AmplifyPlugins`
    - Função `configureAmplify()` criada com `AWSCognitoAuthPlugin`
    - Build funcionando corretamente
23. ✅ Criado arquivo `Constants.swift` em `/Utils`
    - Replicada estrutura `K` do projeto original
    - Constantes: appName, BrandColors, FStore, avatares
    - Corrigido typo: `lighBlue` → `lightBlue`
24. ✅ Importados assets do projeto original
    - **Cores**: BrandBlue, BrandLightBlue, BrandPurple, BrandLightPurple
    - **Imagens**: MeAvatar, YouAvatar, textfield
    - **AppIcon**: Todos os tamanhos de ícones do app
    - Removido AccentColor padrão
25. ✅ Commit: "feat: Add brand assets and Constants from original project"

### Implementação da WelcomeView (11/10/2025)
26. ✅ Criado `WelcomeViewModel.swift` em `/ViewModels`
    - `ObservableObject` para integração com SwiftUI
    - `@Published var titleText` - propriedade reativa para animação
    - Função `animateTitle()` - animação letra por letra (0.1s por caractere)
    - **Aprendizado**: Necessário `import Combine` para usar `ObservableObject`
27. ✅ Convertido `ContentView` para `WelcomeView`
    - Usado Refactor do Xcode para renomear struct e referências
    - Atualizado `FlashChatApp.swift` automaticamente
28. ✅ Implementada UI da WelcomeView em SwiftUI
    - `@StateObject var viewModel` - conexão com ViewModel
    - Título animado usando `viewModel.titleText`
    - Botão Register (azul claro) e Login (teal)
    - Layout com VStack, Spacers e frames fixos (48pt)
    - **Problema resolvido**: Background do botão Login vazando - solução: `.clipShape(Rectangle())`
    - Animação iniciada com `.onAppear { viewModel.animateTitle() }`
29. ✅ Commit: "feat: Create WelcomeView with animated title in SwiftUI"

### Organização e Planejamento (11/10/2025)
30. ✅ Configurado Project "FlashChat" no Claude Desktop
    - Adicionadas Instructions com contexto completo do projeto
    - Permite fazer perguntas conceituais sobre SwiftUI separadamente
    - Mantém histórico e progresso sincronizado
31. ✅ Criado Kanban board no Notion
    - Arquivo CSV gerado: `flashchat-tasks.csv` com 75 tarefas
    - 21 tarefas marcadas como "Done" (concluídas)
    - 54 tarefas "To Do" (pendentes)
    - Categorias: Setup, Backend, Views, ViewModels, Services, Models, Testing, Polish, Docs, Deploy
    - Prioridades definidas (High, Medium, Low)
    - Dependências entre tarefas mapeadas

### Implementação de RegisterView e LoginView (20/10/2025)
32. ✅ Criada `RegisterView.swift` em `/Views`
    - UI em SwiftUI com TextField (email) e SecureField (senha)
    - `@State` variables: `email` e `password` para binding
    - Estilos: background branco, corner radius 25pt, sombras
    - Background da tela: BrandLightBlue
    - Botão Register com altura 48pt
    - Layout com VStack, spacing de 20pt, Spacers para centralização
    - Modificador `.frame(maxHeight: .infinity)` para ocupar tela toda
33. ✅ Criada `LoginView.swift` em `/Views`
    - Estrutura idêntica à RegisterView para manter consistência visual
    - TextField para email e SecureField para senha
    - `@State private` variables: `email` e `password`
    - Botão "Login" ao invés de "Register"
    - Mesmo estilo visual (cores, sombras, espaçamentos)
34. ✅ Implementada navegação entre telas com NavigationStack
    - Atualizada versão mínima do iOS para 16.0
    - Adicionado `NavigationStack` em `FlashChatApp.swift` envolvendo WelcomeView
    - Substituídos `Button` por `NavigationLink` na WelcomeView
    - NavigationLink "Register" → destino: RegisterView
    - NavigationLink "Login" → destino: LoginView
    - Navegação funcionando com transições automáticas
    - **Aprendizado**: NavigationStack é mais simples que UIKit (sem SceneDelegate, sem pushViewController)

### Implementação de RegisterViewModel e Navegação Assíncrona (23/10/2025)
35. ✅ Criado `RegisterViewModel.swift` em `/ViewModels`
    - `ObservableObject` para integração com SwiftUI
    - `@Published` properties: `email`, `password`, `errorMessage`, `isRegistrationSuccessful`
    - Propriedade `isLoading` comentada (feature futura - ProgressView)
    - Função `register()` com validação de campos:
      - Email e senha não podem estar vazios
      - Senha deve ter no mínimo 6 caracteres
    - Integração com `Amplify.Auth.signUp()` para criar usuários no AWS Cognito
    - Configuração de atributos do usuário (email)
    - Execução assíncrona com callback e retorno à main thread para atualizar UI
    - Função `handleSignUpResult()` para processar resposta do Cognito:
      - Caso `.confirmUser`: exibe mensagem pedindo confirmação por email
      - Caso `.done`: marca `isRegistrationSuccessful = true`
    - Função `handleAuthError()` com tratamento detalhado de erros:
      - `UsernameExistsException` → "This email is already registered"
      - `InvalidPasswordException` → "Password does not meet requirements"
      - Outros erros de serviço e validação
    - Debug logs para facilitar troubleshooting
    - **Aprendizado**: Integração Swift + AWS Amplify, callbacks assíncronos, tratamento de erros
36. ✅ Atualizada `RegisterView.swift` com ViewModel e navegação assíncrona
    - Conectado `@StateObject private var viewModel = RegisterViewModel()`
    - Alterados `@State` variables para bindings com ViewModel:
      - `text: $viewModel.email` no TextField
      - `text: $viewModel.password` no SecureField
    - Botão Register chama `viewModel.register()` ao invés de ação vazia
    - Adicionado display condicional de mensagens de erro:
      - `if let errorMessage = viewModel.errorMessage { Text(...) }`
      - Estilo: texto vermelho, fonte 14pt, alinhamento centralizado
    - Implementada navegação assíncrona para ChatView após registro bem-sucedido:
      - `@State private var navigateToChatView = false` - controla navegação
      - `.navigationDestination(isPresented: $navigateToChatView) { ChatView() }`
      - `.onChange(of: viewModel.isRegistrationSuccessful)` - detecta sucesso
      - Quando `isRegistrationSuccessful = true` → `navigateToChatView = true` → navega
    - **Aprendizado**: Navegação assíncrona no SwiftUI usando `.navigationDestination` + `.onChange`, diferente de navegação direta com NavigationLink
37. ✅ Criada `ChatView.swift` em `/Views`
    - Tela simples com `Text("ChatView")` para validar navegação
    - Será desenvolvida completamente no futuro com lista de mensagens e input

### Testes e Ajustes do Registro AWS Cognito (23/10/2025)
38. ✅ Testado registro de usuário no AWS Cognito via app
    - Primeiro teste: erro "error 8" - senha com menos de 8 caracteres
    - **Descoberta**: AWS Cognito configurado para senha mínima de 8 caracteres
    - Corrigida validação no RegisterViewModel: `password.count >= 6` → `password.count >= 8`
39. ✅ Segundo teste: código de confirmação recebido por email
    - Usuário criado com sucesso no Cognito (status: UNCONFIRMED)
    - Código de 6 dígitos enviado para o email
    - **Problema descoberto**: Mensagem de confirmação exibe objeto Swift bruto ao invés do email mascarado
    - Tentativa de correção com pattern matching: `if case let .email(emailAddress) = deliveryDetails?.destination`
    - Ainda com problemas na exibição - deixado para ajustar depois
40. ✅ Identificado tratamento de erro incompleto
    - Erro "usernameExists" não estava sendo capturado corretamente
    - Código procurava por "UsernameExistsException" mas Amplify retorna "usernameExists" ou "User already exists"
    - Sugerida correção (não implementada): adicionar verificações adicionais na linha 86
41. ✅ Confirmação manual de usuário testada
    - Usuário confirmado manualmente via AWS Console (mudou status de UNCONFIRMED → CONFIRMED)
    - **Descoberta importante**: App não navega para ChatView após confirmação manual
    - **Motivo**: `isRegistrationSuccessful = true` só acontece quando `nextStep == .done`
    - Quando Cognito exige confirmação, retorna `nextStep == .confirmUser`, não `.done`
    - Navegação só funciona se o código de confirmação for validado dentro do app
42. ⏳ **Decisão para próxima sessão**: Implementar sistema de confirmação de código
    - Opção escolhida: Alert/Sheet com TextField (não tela completa)
    - Fluxo planejado:
      1. Usuário registra → recebe código por email
      2. App mostra TextField/Alert para inserir código
      3. Chama `Amplify.Auth.confirmSignUp(username:, confirmationCode:)`
      4. Se código correto → `isRegistrationSuccessful = true` → navega para ChatView
    - Pendente implementação

### Implementação de Confirmação de Código por Email (24/10/2025)
43. ✅ Adicionadas properties para controle de confirmação no RegisterViewModel
    - `@Published var needsConfirmation: Bool = false` - controla quando mostrar alert
    - `@Published var confirmationCode: String = ""` - armazena código de 6 dígitos digitado
    - Properties adicionadas na seção Published Properties
44. ✅ Criada função `confirmSignUp()` no RegisterViewModel
    - Validação: verifica se `confirmationCode` não está vazio
    - Chamada: `Amplify.Auth.confirmSignUp(for: email, confirmationCode: confirmationCode)`
    - Execução assíncrona com callback e retorno à main thread
    - Tratamento de sucesso: `isRegistrationSuccessful = true` (navega para ChatView)
    - Tratamento de erro: reutiliza `handleAuthError()` para mensagens apropriadas
    - **Aprendizado**: Mesmo padrão de callbacks assíncronos do `register()`
45. ✅ Modificado `handleSignUpResult()` para ativar flag de confirmação
    - Linha 95: Adicionado `needsConfirmation = true` no caso `.confirmUser`
    - Quando Cognito envia código, ativa flag que dispara alert na View
46. ✅ Implementado Alert com TextField na RegisterView
    - `@State private var showConfirmationAlert: Bool = false` - controla exibição do alert
    - `.onChange(of: viewModel.needsConfirmation)` - detecta quando precisa confirmar
    - `.alert("Confirm your email", isPresented: $showConfirmationAlert)` - alert com:
      - `TextField("6-digit code", text: $viewModel.confirmationCode)` com binding
      - `.textInputAutocapitalization(.never)` - sem capitalização automática
      - `.keyboardType(.numberPad)` - teclado numérico para melhor UX
      - Botão "Confirm" que chama `viewModel.confirmSignUp()`
      - Botão "Cancel" com `role: .cancel` para fechar
      - Mensagem explicativa: "Enter the confirmation code sent to your email"
    - **Aprendizado**: Alerts com TextField disponíveis desde iOS 16, seguindo tutorial HackingWithSwift
47. ✅ Mantida navegação assíncrona existente
    - `.onChange(of: viewModel.isRegistrationSuccessful)` continua detectando sucesso
    - Navega para ChatView tanto após registro direto quanto após confirmação de código
48. ✅ Testado fluxo completo com sucesso
    - Register → Recebe email com código → Alert aparece → Digita código → Confirma → Navega para ChatView ✅
    - Validação de código vazio funciona
    - Tratamento de erro funciona (código inválido, expirado, etc.)
    - UX melhorada com teclado numérico

### Migração Amplify Gen 2 + CocoaPods → SPM (19/05/2026)
49. ✅ Criado backend Gen 2 com `npm create amplify@latest -- --dirName amplify-gen2`
    - Pasta `amplify-gen2/` criada com TypeScript backend
    - Dependências instaladas: `@aws-amplify/backend`, `@aws-amplify/backend-cli`, `aws-cdk-lib`, etc.
50. ✅ Resolvido problema de permissões IAM para CDK
    - **Problema**: Usuário `arthur-norat` só tinha `AdministratorAccess-Amplify` (Gen 1), insuficiente para CDK
    - **Solução**: Adicionada policy `AdministratorAccess` ao usuário no IAM Console
51. ✅ CDK bootstrapped na região sa-east-1 via Amplify Console
    - URL: `sa-east-1.console.aws.amazon.com/amplify/create/bootstrap`
    - Pilha CDKToolkit implantada com sucesso
52. ✅ Backend Gen 2 deployado com `npx ampx sandbox`
    - Novo User Pool Cognito criado (sa-east-1)
    - `amplify_outputs.json` gerado em `amplify-gen2/`
    - Sandbox em watch mode (terminal deve ficar aberto durante desenvolvimento)
53. ✅ CocoaPods removido
    - `pod deintegrate` executado
    - `Podfile` e `Podfile.lock` deletados
    - `.xcworkspace` deletado (não mais necessário com SPM)
54. ✅ Amplify adicionado via SPM (Amplify 2.58.1)
    - File → Add Package Dependencies → `https://github.com/aws-amplify/amplify-swift`
    - Targets adicionados: `Amplify` e `AWSCognitoAuthPlugin`
55. ✅ `amplify_outputs.json` adicionado ao Xcode
    - Copiado para raiz do projeto iOS
    - Arrastado para o grupo `FlashChat` no Project Navigator
    - Target `FlashChat` marcado no import
56. ✅ `FlashChatApp.swift` atualizado para Gen 2
    - `import AmplifyPlugins` → `import AWSCognitoAuthPlugin`
    - `try Amplify.configure()` → `try Amplify.configure(with: .amplifyOutputs)`
57. ✅ `RegisterViewModel.swift` migrado para async/await
    - `register()` e `confirmSignUp()` convertidos de callbacks para `Task { } + async/await`
    - `DispatchQueue.main.async` substituído por `await MainActor.run { }`
    - Ajuste no pattern matching: `.confirmUser(let deliveryDetails, _, _)` (Gen 2 tem 3 valores)
    - **Aprendizado**: Gen 2 remove a API de callbacks — só suporta async/await
58. ✅ `.gitignore` corrigido
    - `amplify/` → `/amplify/` (barra no início limita o padrão à raiz, não afeta `amplify-gen2/amplify/`)
    - Corrigido para que os arquivos TypeScript do backend Gen 2 sejam rastreados pelo git
59. ✅ User Pool Gen 1 deletado do Cognito (`flashchat34e00180_userpool_34e00180-dev`)
60. ✅ Fluxo completo testado e funcionando com Gen 2
    - Email de confirmação cai na pasta Spam (remetente: `no-reply@verificationemail.com`)
    - Registro → código por email → Alert → confirmação → ChatView ✅
61. ✅ Commits e push realizados

---

## 📋 Plano de Desenvolvimento (atualizado em 19/05/2026)

### PARTE 1 — Migração Amplify Gen 1 → Gen 2 ✅ CONCLUÍDA

---

### PARTE 2 — LoginViewModel

**Etapa 2.1 — Criar `LoginViewModel.swift`**
- [ ] `ObservableObject` com `@Published`: `email`, `password`, `errorMessage`, `isLoginSuccessful`
- [ ] Função `signIn()` com `Amplify.Auth.signIn(username:password:)` em `async/await`
- [ ] Tratar resultado `.done` → `isLoginSuccessful = true`
- [ ] Tratar erros: usuário não encontrado, senha incorreta, usuário não confirmado

**Etapa 2.2 — Conectar `LoginView` ao `LoginViewModel`**
- [ ] Adicionar `@StateObject private var viewModel = LoginViewModel()`
- [ ] Bindings: `$viewModel.email` e `$viewModel.password`
- [ ] Botão Login chama `viewModel.signIn()`
- [ ] Mostrar `errorMessage` (igual ao RegisterView)
- [ ] Navegação assíncrona para ChatView (mesmo padrão do RegisterView)
- [ ] Usar API correta do `onChange(of:)`: `{ _, isSuccessful in ... }`

**Verificação da Parte 2:**
- Login com usuário existente → navega para ChatView
- Login com senha errada → exibe erro

---

### PARTE 3 — Chat (Model + AppSync + ChatView)

**Etapa 3.1 — Criar `Message.swift`**
- [ ] Campos: `id: String`, `sender: String`, `body: String`, `timestamp: Date`
- [ ] Implementar `Identifiable` para uso em `List` no SwiftUI

**Etapa 3.2 — Configurar AppSync no backend Gen 2**
- [ ] Adicionar `defineData` ao `amplify-gen2/amplify/backend.ts`
- [ ] Criar schema GraphQL com modelo `Message`
- [ ] Regras: usuários autenticados podem criar e ler mensagens
- [ ] Rodar `npx ampx sandbox` para deploy
- [ ] Substituir `amplify_outputs.json` no projeto iOS
- [ ] No Xcode: adicionar target `AWSAPIPlugin` via SPM
- [ ] Em `FlashChatApp.swift`: adicionar `try Amplify.add(plugin: AWSAPIPlugin())`

**Etapa 3.3 — Criar `MessageService.swift`**
- [ ] `sendMessage(body:sender:)` — mutation GraphQL via `Amplify.API.mutate()`
- [ ] `observeMessages()` — subscription GraphQL via `Amplify.API.subscribe()` (tempo real)

**Etapa 3.4 — Criar `ChatViewModel.swift`**
- [ ] `@Published var messages: [Message]` e `@Published var newMessageText: String`
- [ ] Função `sendMessage()` → chama `MessageService`
- [ ] Função `loadMessages()` → carrega histórico
- [ ] Observar mensagens em tempo real via subscription
- [ ] Obter email do usuário logado: `Amplify.Auth.getCurrentUser()`

**Etapa 3.5 — Implementar `ChatView.swift`**
- [ ] `List` ou `ScrollView` com as mensagens
- [ ] Bubble com `MeAvatar` (direita, azul) ou `YouAvatar` (esquerda, roxo)
- [ ] Barra inferior: `TextField` + botão enviar
- [ ] `.onAppear` → `viewModel.loadMessages()`

**Verificação da Parte 3:**
- Enviar mensagem → aparece na lista
- Dois simuladores: mensagem de um aparece no outro (tempo real)

---

### PARTE 4 — Polish (após tudo funcional)

- [ ] `RegisterView.swift` linhas 62/67 — corrigir `onChange(of:)`: `{ _, value in ... }`
- [ ] `WelcomeViewModel.swift` — remover `import SwiftUI`, basta `Foundation`
- [ ] Adicionar `ProgressView` durante operações assíncronas
- [ ] Adicionar botão "Resend code" na RegisterView
- [ ] Botão de logout na ChatView → `Amplify.Auth.signOut()`

---

## 🔍 Análise Técnica (Revisão 01/04/2026)

Revisão completa do projeto feita com Claude Code. Pontos identificados para corrigir conforme o desenvolvimento avança:

### Problemas a corrigir

**1. `onChange(of:)` com API depreciada no iOS 17**
Afeta `RegisterView.swift` (linhas 62 e 67). A forma antiga recebe um único parâmetro na closure; a forma nova recebe dois (valor antigo e novo).
```swift
// Atual (depreciado)
.onChange(of: viewModel.isRegistrationSuccessful) { isSuccessful in ... }
// Correto para iOS 16+
.onChange(of: viewModel.isRegistrationSuccessful) { _, isSuccessful in ... }
```

**2. `WelcomeViewModel` importa SwiftUI desnecessariamente**
`WelcomeViewModel.swift` importa `SwiftUI` mas só usa `Timer` e `String`. Basta `Foundation` + `Combine`.

**3. `AWSAPIPlugin` não inicializado** *(pendente para Parte 3)*
O `FlashChatApp.swift` só inicializa o `AWSCognitoAuthPlugin`. Quando implementar o chat (AppSync/GraphQL), adicionar:
```swift
try Amplify.add(plugin: AWSAPIPlugin())
```

### Estado atual confirmado (19/05/2026)
- Registro + confirmação por email: **funcionando** ✅ (com Gen 2)
- `LoginView`: campos prontos visualmente, mas botão tem `TODO` — sem `LoginViewModel`
- `ChatView`: apenas `Text("ChatView")` — placeholder
- Amplify Gen 2 + SPM: **migração concluída** ✅

---

## Funcionalidades a Implementar

### Baseado no projeto Flash-Chat original:

**Modelos:**
- [ ] Message Model (sender, body, timestamp?)

**Telas (Views SwiftUI):**
- [x] WelcomeView - Tela inicial com logo e botões Register/Login
- [x] RegisterView - Tela de cadastro (email + senha) + Alert de confirmação + navegação assíncrona
- [x] LoginView - Tela de login (email + senha) - estrutura básica criada
- [⏳] ChatView - Estrutura básica criada (precisa implementação completa)

**ViewModels:**
- [x] WelcomeViewModel - Animação do título e navegação
- [x] RegisterViewModel - Lógica completa de registro e confirmação com AWS Cognito
- [ ] LoginViewModel - Lógica de autenticação com AWS Cognito
- [ ] ChatViewModel - Lógica de envio/recebimento de mensagens

**Services:**
- [ ] AuthService - Integração com AWS Cognito
- [ ] MessageService - Integração com AWS AppSync/API para mensagens

**Outros:**
- [x] Constants.swift - Constantes do app (cores, strings, etc)
- [x] Kanban board no Notion - 75 tarefas mapeadas
- [x] Project no Claude Desktop - Contexto para aprendizado
- [x] Navegação entre telas (NavigationStack + NavigationLink)
- [ ] UI/UX matching do app original

---

## Notas Técnicas

- **Platform**: iOS 16.0+ (atualizado para usar NavigationStack)
- **Framework**: SwiftUI
- **Architecture**: MVVM
- **Backend**: AWS Amplify (Cognito + AppSync)
- **Dependency Manager**: Swift Package Manager (SPM) — migrado do CocoaPods na Parte 1 do plano
- **Projeto Original**: Flash-Chat (localizado em `/Users/arthurnorat/iOS_Projects/Flash-Chat`)

### Design do App Original:
- **App Name**: ⚡️FlashChat
- **Cores da Marca**:
  - BrandPurple
  - BrandLightPurple
  - BrandBlue
  - BrandLightBlue
- **Avatares**: YouAvatar (esquerda), MeAvatar (direita)

### Estrutura Firestore Original (para referência):
- **Collection**: "messages"
- **Fields**: `sender`, `body`, `date`

---

_Última atualização: 2026-05-19 (Parte 1 concluída — migração Amplify Gen 2 + SPM completa e testada — próximo passo: LoginViewModel)_
