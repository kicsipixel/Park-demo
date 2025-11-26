<p align="center">
  <img src="./imgages/pop.png" alt="Leaf" width="250"/>
</p>

# Parks of Prague - SwiftUI JWT Authentication Demo

This sample **SwiftUI iOS app** demonstrating how to integrate **JWT (JSON Web Token) authentication** with a backend built using [Hummingbird](https://github.com/kicsipixel/oracle-nio-examples/tree/main/authentication/JWTAuth).  
This project is designed as a learning resource for developers who want to understand secure login flows, token verification, and state management in SwiftUI.

---

## Features

- **JWT Authentication Flow**  
  Login with credentials, receive a JWT from the server, and persist it securely.

- **Token Verification**  
  Validate tokens on app launch and refresh UI state accordingly.

- **SwiftUI State Management**  
  Use `@AppStorage`, `@Environment`, and `@State` to propagate authentication state.

- **Reusable Components**  
  Custom views, modifiers, and toolbar integration for clean UI/UX.

- **Error Handling**  
  Graceful alerts and fallback UI when authentication fails.

---

## Screenshots

<p align="center">
    <img src="./imgages/demo1.png" alt="Leaf" width="250" style="margin: 0 35px 35px 0;"/>
    <img src="./imgages/demo4.png" alt="Leaf" width="250" style="margin: 0 35px 35px 0;"/>
</p>

<p align="center">
    <img src="./imgages/demo5.png" alt="Leaf" width="250" style="margin: 0 35px 0 0;" />
    <img src="./imgages/demo2.png" alt="Leaf" width="250" style="margin: 0 35px 0 0;"/>
</p>

---

## Tech Stack

- **SwiftUI** — Declarative UI framework for iOS/macOS.
- **Hummingbird** — Lightweight server-side Swift framework used to issue and verify JWTs.
- **JWT** — Secure token-based authentication standard.
- **MapKit** — Demo integration showing park details with coordinates.
- **Custom Components** — Toolbar, modifiers, and reusable views.

---

## Getting Started

### Prerequisites

- Xcode 15+
- iOS 17+ (minimum deployment target)
- Swift 5.9+
- A running Hummingbird backend configured to issue JWTs

<br />
<p align="center">
    <img src="./imgages/leaf.png" alt="Leaf" width="50"/>
</p>
