# CLAUDE.md — FlashChat

## Sobre o Projeto

Conversão do **Flash-Chat** (UIKit + Firebase) para **SwiftUI + AWS Amplify**.
Projeto original de referência: `/Users/arthurnorat/iOS_Projects/Flash-Chat`

- Firebase Auth → AWS Cognito
- Firebase Firestore → AWS AppSync (GraphQL)

---

## Stack e Ambiente

| Item | Detalhe |
|---|---|
| Plataforma | iOS 16.0+ |
| UI | SwiftUI |
| Arquitetura | MVVM |
| Backend | AWS Amplify Gen 2 (TypeScript) |
| Auth | AWS Cognito |
| API | AWS AppSync (GraphQL) — a implementar |
| Dependências iOS | Swift Package Manager (SPM) |
| Região AWS | `sa-east-1` (São Paulo) |
| Amplify Swift | 2.58.1 — targets: `Amplify`, `AWSCognitoAuthPlugin` |

---

## Convenções de Código

- Comentários em português quando necessário
- Padrão async/await com `Task {}` + `await MainActor.run {}` para atualizar UI
- Seguir convenções Swift padrão (camelCase, tipos com inicial maiúscula)
- Senha mínima: 8 caracteres (requisito do Cognito configurado)
- Email de confirmação do Cognito cai na pasta **Spam** (remetente: `no-reply@verificationemail.com`)

---

## Estrutura de Pastas

```
FlashChat/
├── Models/          # structs de dados (ex: Message)
├── Views/           # telas SwiftUI
├── ViewModels/      # ObservableObject com lógica de apresentação
├── Services/        # integração com Cognito, AppSync
├── Utils/           # Constants.swift e utilitários
amplify-gen2/        # backend TypeScript (Amplify Gen 2)
└── amplify/
    ├── backend.ts   # define auth + data
    └── data/        # schema GraphQL
```

---

## Comandos

```bash
# Rodar o backend sandbox (manter terminal aberto durante desenvolvimento)
cd amplify-gen2 && npx ampx sandbox

# O arquivo amplify_outputs.json gerado deve ser copiado para a raiz do projeto iOS
```

---

## Restrições Não Óbvias

- **SPM only** — CocoaPods foi removido. Nunca adicionar dependências via CocoaPods.
- **`ENABLE_USER_SCRIPT_SANDBOXING = No`** nas Build Settings — necessário para o Xcode buildar corretamente (configurado no target).
- **`Amplify.configure(with: .amplifyOutputs)`** — sintaxe Gen 2. Não usar a forma antiga `Amplify.configure()`.
- **Import correto**: `import AWSCognitoAuthPlugin` (SPM). Nunca `import AmplifyPlugins` (era CocoaPods).
- **`AWSAPIPlugin`** ainda não está inicializado no `FlashChatApp.swift` — adicionar na Etapa 3.2.
- **Sessão**: o app faz signOut automático ao ir para background (`scenePhase == .background`). Decisão intencional — evita `AuthError.invalidState` sem complexidade de verificação de sessão.
- **`onChange(of:)` depreciado**: `RegisterView.swift` usa a forma antiga (1 parâmetro). Corrigir na Parte 4.

---

## Estado Atual (22/05/2026)

- WelcomeView, RegisterView, LoginView: **implementadas e funcionando** ✅
- Registro com confirmação por email (Alert + código 6 dígitos): **funcionando** ✅
- Login com Cognito: **funcionando** ✅
- Gerenciamento de sessão (signOut no background): **funcionando** ✅
- ChatView: implementada com bolhas, barra de input e logout ✅
- Envio e recebimento de mensagens em tempo real (AppSync): **funcionando** ✅
- Logout retorna para WelcomeView: **funcionando** ✅
- **Próxima tarefa**: Parte 4 — Polish

---

## Plano de Desenvolvimento

### PARTE 1 — Migração Amplify Gen 2 + SPM ✅ CONCLUÍDA
### PARTE 2 — LoginViewModel ✅ CONCLUÍDA
### PARTE 2.5 — Gerenciamento de Sessão ✅ CONCLUÍDA

---

### PARTE 3 — Chat (Model + AppSync + ChatView) ✅ CONCLUÍDA

- Envio e recebimento em tempo real via AppSync subscription ✅
- Bolhas com MeAvatar (direita) e YouAvatar (esquerda) ✅
- Logout retorna para WelcomeView via callback chain ✅

---

### PARTE 4 — Polish

- [ ] `RegisterView.swift` — corrigir `onChange(of:)` depreciado: `{ _, value in ... }`
- [ ] `WelcomeViewModel.swift` — remover `import SwiftUI`, basta `Foundation` + `Combine`
- [ ] `ProgressView` durante operações assíncronas
- [ ] Botão "Resend code" na `RegisterView`
- [ ] Botão de logout na `ChatView` → `Amplify.Auth.signOut()`

---

## Design (referência do app original)

- **Cores**: `BrandBlue`, `BrandLightBlue`, `BrandPurple`, `BrandLightPurple`
- **Avatares**: `YouAvatar` (esquerda), `MeAvatar` (direita)
- **Modelo original Firestore**: campos `sender`, `body`, `date` na collection `messages`

---

_Última atualização: 2026-05-26_
