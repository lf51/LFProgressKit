//
//  AMAlertModel.swift
//  LFAlertManager
//
//  Created by Calogero Friscia on 24/12/25.
//
import Foundation

/// Model representing a single alert presentation.
public struct PGProgressModel: Identifiable {
    
    /// Unique identifier used by SwiftUI.
    public let id: String
    
    /// Alert content provider.
    let content: any PGProgressCasePro
    
    public init(
        content: any PGProgressCasePro
    ) {
        self.id = UUID().uuidString
        self.content = content
    }
}
