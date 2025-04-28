# Credit Union Mobile App (Flutter)

## Overview

The **Credit Union Mobile App** is designed to provide credit union members with a convenient, secure, and seamless way to manage their accounts, loans, and transactions directly from their mobile devices. With this app, members can check account balances, transfer funds, view transaction history, manage loans, and much more, all from the palm of their hands.

Built with **Flutter**, this app is optimized for both iOS and Android devices, offering a smooth cross-platform experience.

## Features

- **Account Overview**: View balances of checking, savings, and loan accounts.
- **Fund Transfers**: Easily transfer funds between accounts or to other members.
- **Loan Management**: Track loan status, repayments, and outstanding balances.
- **Transaction History**: Search and view past transactions with sorting filters.
- **Push Notifications**: Receive push notifications for account activities, transfers, payments, and more.
- **Bill Payments**: Pay bills from your credit union account to supported vendors.
- **Secure Login**: Multi-factor authentication (MFA) for secure access to your account.
- **Account Statements**: Download and view monthly account statements.

## Technologies

- **Frontend**: Flutter (Dart)
- **Backend**: NestJS (API services)
- **Database**: PostgreSQL / MySQL (depending on implementation)
- **Authentication**: JWT with OAuth 2.0
- **Push Notifications**: Firebase Cloud Messaging (FCM)
- **State Management**: Provider or Riverpod
- **Dependency Injection**: GetIt (for service management)

## Setup Instructions

### Prerequisites

- Install **Flutter SDK** (version >= 3.x):
  - Follow the Flutter installation guide: [Flutter Installation](https://flutter.dev/docs/get-started/install)
- Install **Android Studio** or **Xcode** (for iOS) for building the app on respective platforms.
- Make sure **Dart** is properly installed and configured.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/credit-union-mobile-app.git
   cd credit-union-mobile-app
   ```
