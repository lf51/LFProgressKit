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
            .overlay(alignment: .top, content: {
                
                if let progressLog {
                    
                    VStack {
                        
                        ProgressView()
                        
                        ForEach(progressLog) { log in
                            
                            VStack(alignment:.leading) {
                                
                                Text("\(log.content.getProgressTitle())")
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                                    .fontDesign(.monospaced)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.75)
                                
                                Text("\(log.content.getBodyMessage())")
                                    .fontWeight(.light)
                                    .font(.body)
                                    .fontDesign(.monospaced)
                                    .multilineTextAlignment(.leading)
                                
                                Text("...")
                                    .bold()
                            }
                           
                            
                        }
                        
                    }
                    .foregroundStyle(textColor)
                    .offset(x: 0, y: 300)
                }
            })
            .onReceive(PGProgressManager.shared.publisher) { progress in
                
                if progressLog == nil {
                    self.progressLog = [progress]
                } else {
                    self.progressLog?.append(progress)
                }

            }
    
    }
}

