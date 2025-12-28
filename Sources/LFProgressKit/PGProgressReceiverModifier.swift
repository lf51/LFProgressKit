//
//  AMModifier.swift
//  LFAlertManager
//
//  Created by Calogero Friscia on 24/12/25.
//

import SwiftUI

/// ViewModifier responsible for listening to alert events
/// and presenting SwiftUI alerts accordingly.
internal struct PGProgressReceiverModifier: ViewModifier {
    
    let textColor:Color
    @State private var progressLog: [PGProgressModel]?
    
    init(textColor: Color) {
        
        self.textColor = textColor
    }
    
    func body(content: Content) -> some View {
        
        content
            .overlay(alignment: .center, content: {
                
                if let progressLog {
                    
                    PGProgressView(textColor: textColor, progressLog: progressLog)
                    
                }
            })
            .onReceive(PGProgressManager.shared.publisher) { progress in
                
                withAnimation {
                    if progressLog == nil {
                        self.progressLog = [progress]
                    } else {
                        self.progressLog?.append(progress)
                    }
                }

            }
            .onReceive(PGProgressManager.shared.publisherExpired) { expiredLog in
                
                withAnimation {
                    
                    self.progressLog?.removeAll(where: { $0.id == expiredLog.id })
                    if let progressLog,
                        progressLog.isEmpty {
                        // reset
                        self.progressLog = nil
                    }
                }

            }
    
    }
}

