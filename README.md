🇺🇸 [English](#english) · 🇧🇷 [Português](#português)

---

<a name="english"></a>

# ⚡ FlashChat

A real-time iOS chat application built with SwiftUI and AWS, developed as a hands-on learning project to explore mobile development and cloud architecture.

## About

FlashChat lets users create an account, verify their email, sign in, and exchange messages in real time. The project follows the MVVM architecture pattern and uses AWS cloud services for both authentication and real-time messaging.

## Features

- User registration with email verification
- Secure sign-in and automatic session management
- Animated welcome screen
- Real-time chat *(in development)*

## AWS Architecture

AWS is at the core of this project's backend:

| Service | Role |
|---|---|
| **AWS Amplify Gen 2** | Backend defined as code using TypeScript and AWS CDK |
| **AWS Cognito** | User Pools for registration, email verification, and authentication |
| **AWS AppSync** | GraphQL API with real-time subscriptions for messaging *(in development)* |

The backend is fully managed through **AWS Amplify Gen 2**, where infrastructure is declared in TypeScript and provisioned via AWS CDK — making it reproducible and version-controlled alongside the app code.

Authentication uses **AWS Cognito User Pools**, handling the complete auth flow: sign up, email confirmation code, sign in, and session lifecycle. The Amplify Swift SDK integrates Cognito directly into the iOS app using async/await.

## Tech Stack

- **Swift** · SwiftUI · iOS 16+
- **Architecture**: MVVM
- **Dependency Manager**: Swift Package Manager (SPM)
- **AWS Amplify Swift SDK** 2.x
- **Async/Await** for all asynchronous operations

## What I Learned

- Building iOS apps with SwiftUI and the MVVM pattern
- AWS Cognito authentication flow: sign up, email verification, and sign in
- Defining cloud infrastructure as code with AWS Amplify Gen 2 (TypeScript + CDK)
- Integrating AWS services into a native iOS app using the Amplify Swift SDK
- Swift concurrency with `async/await`, `Task`, and `MainActor`
- SwiftUI state management: `@StateObject`, `@Published`, `@Environment`
- Navigation with `NavigationStack` and `.navigationDestination`

---

<a name="português"></a>

# ⚡ FlashChat

Aplicativo iOS de chat em tempo real desenvolvido com SwiftUI e AWS, criado como projeto de aprendizado prático para explorar desenvolvimento mobile e arquitetura em nuvem.

## Sobre

O FlashChat permite que usuários criem uma conta, verifiquem o email, façam login e troquem mensagens em tempo real. O projeto segue o padrão de arquitetura MVVM e utiliza serviços AWS para autenticação e mensagens em tempo real.

## Funcionalidades

- Cadastro de usuário com verificação por email
- Login seguro e gerenciamento automático de sessão
- Tela de boas-vindas com animação
- Chat em tempo real *(em desenvolvimento)*

## Arquitetura AWS

A AWS é o núcleo do backend deste projeto:

| Serviço | Função |
|---|---|
| **AWS Amplify Gen 2** | Backend definido como código usando TypeScript e AWS CDK |
| **AWS Cognito** | User Pools para cadastro, verificação de email e autenticação |
| **AWS AppSync** | API GraphQL com subscriptions em tempo real para mensagens *(em desenvolvimento)* |

O backend é gerenciado pelo **AWS Amplify Gen 2**, onde a infraestrutura é declarada em TypeScript e provisionada via AWS CDK — tornando-a reproduzível e versionada junto ao código do app.

A autenticação utiliza **AWS Cognito User Pools**, cobrindo todo o fluxo: cadastro, confirmação por código de email, login e ciclo de vida da sessão. O Amplify Swift SDK integra o Cognito diretamente ao app iOS usando async/await.

## Tecnologias

- **Swift** · SwiftUI · iOS 16+
- **Arquitetura**: MVVM
- **Gerenciador de dependências**: Swift Package Manager (SPM)
- **AWS Amplify Swift SDK** 2.x
- **Async/Await** para todas as operações assíncronas

## O que aprendi

- Criação de apps iOS com SwiftUI e o padrão MVVM
- Fluxo de autenticação com AWS Cognito: cadastro, verificação de email e login
- Definição de infraestrutura em nuvem como código com AWS Amplify Gen 2 (TypeScript + CDK)
- Integração de serviços AWS em um app iOS nativo usando o Amplify Swift SDK
- Concorrência em Swift com `async/await`, `Task` e `MainActor`
- Gerenciamento de estado no SwiftUI: `@StateObject`, `@Published`, `@Environment`
- Navegação com `NavigationStack` e `.navigationDestination`
