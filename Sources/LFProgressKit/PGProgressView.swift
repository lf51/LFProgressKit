//
//  PGProgressView.swift
//  LFProgressKit
//
//  Created by Calogero Friscia on 28/12/25.
//

import SwiftUI

internal struct PGProgressView: View {
    
    let textColor: Color
    let progressLog: [PGProgressModel]
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .fill(Color.black.gradient)
                .opacity(0.6)
                .ignoresSafeArea()
                .zIndex(0)
                
            VStack {
                
                ProgressView()
                
                ScrollView {
                    
                    VStack(alignment:.leading) {
                        
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
                }.scrollIndicators(.never)
                
            }
            .foregroundStyle(textColor)
            .padding(.horizontal,20)
            .offset(x: 0, y: 150)
            .zIndex(1)
        }
        
    }
}
