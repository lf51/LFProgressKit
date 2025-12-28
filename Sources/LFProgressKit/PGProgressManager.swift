// The Swift Programming Language
// https://docs.swift.org/swift-book

import Combine

/// Centralized alert dispatcher.
///
/// Acts as a single source of truth for alert events and exposes
/// a Combine publisher that SwiftUI views can subscribe to.
@MainActor
public class PGProgressManager {
    
    /// Shared singleton instance.
    public static let shared = PGProgressManager()
    
    /// Internal subject used to broadcast alert events.
    private let subject = PassthroughSubject<PGProgressModel, Never>()
    
    private let subjectExpired = PassthroughSubject<PGProgressModel, Never>()

    /// Public read-only publisher for alert events.
    internal var publisher: AnyPublisher<PGProgressModel, Never> {
        subject.eraseToAnyPublisher()
    }
    
    internal var publisherExpired: AnyPublisher<PGProgressModel, Never> {
        subjectExpired.eraseToAnyPublisher()
    }

    /// Posts a new alert event.
    public func startLog(_ log: PGProgressModel) {
        subject.send(log)
    }
    
    public func endLog(_ log:PGProgressModel) {
        subjectExpired.send(log)
    }
}
