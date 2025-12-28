# LFAlertKit

> **Note**  
> All public types exposed by this package use the `AM` prefix to clearly identify the alert domain and avoid naming collisions when multiple LF packages are imported into the same project.

---

## Overview

`LFAlertKit` is a lightweight and reusable alert management system designed for SwiftUI applications.

It provides a clean abstraction to trigger and present alerts from anywhere in the app, without coupling business logic to SwiftUI views or manually propagating state across the view hierarchy.

The package is intentionally small and focused, making it easy to integrate and reuse across multiple projects.

---

## Key Features

- Centralized alert dispatching via a shared manager
- Decoupled alert content and presentation logic
- Native SwiftUI `.alert` integration
- Safe execution on the `MainActor`
- Minimal public API surface
- Designed as a reusable Swift Package

---

## Design Philosophy

`LFAlertKit` follows a few simple principles:

- **Minimal API**: only what is required to use the package is public
- **Separation of concerns**: alert triggering is separated from UI presentation
- **Concurrency safety**: all UI-related operations are isolated on the `MainActor`
- **Reusability**: the package is designed to be dropped into multiple apps without changes

---

## Installation

Add `LFAlertKit` using Swift Package Manager:

.package(url: "https://github.com/yourusername/LFAlertKit.git", from: "1.0.0")

---

## Usage

### 1. Define an alert content type

enum NetworkErrorAlert: AMAlertCasePro {
    
    case networkCrash
    case urlInvalid
    
    func getAlertTitle() -> String {
        switch self {
        case .networkCrash:
            return "Network Connection"
        case .urlInvalid:
            return "URL Connection"
      
        }
    }
    
    func getBodyMessage() -> String {
        switch self {
        case .networkCrash:
            return "Network crash..."
        case .urlInvalid:
            return "this url is invalid...."
     
        }
    }
}

2. Post an alert

AMAlertManager.shared.post(
    AMAlertModel(
        content: NetworkErrorAlert.urlInvalid,
        actions: [
            AMAlertActionModel(label: "Retry", role: .none) {
                print("Retry tapped")
            },
            AMAlertActionModel(label: "Cancel", role: .cancel)
        ]
    )
)

3. Attach the alert receiver to a view

struct ContentView: View {

    var body: some View {
        RootView()
            .amAlertReceiver()
    }
}
