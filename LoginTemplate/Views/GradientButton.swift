//
//  GradientButton.swift
//  LoginTemplate
//
//  Created by john on 18.06.2024.
//

import SwiftUI

struct GradientButton: View {
    @Binding var isPerformingTask: Bool
    var title: String
    var sfIcon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            ZStack {
                HStack(spacing: 10) {
                    Text(title)
                    Image(systemName: sfIcon)
                }
                .opacity(isPerformingTask ? 0 : 1)
                
                if isPerformingTask {
                    ProgressView()
                }
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom), in: .capsule)
        })
    }
}
