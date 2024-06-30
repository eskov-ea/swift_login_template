////
////  OTPView.swift
////  LoginTemplate
////
////  Created by john on 19.06.2024.
////

import SwiftUI

struct OTPView: View {
    @Binding var otpText: String
    @Binding var isLoading: Bool
    @Environment(\.dismiss) private var dismiss
    var verifyCompletion: ((String) async throws -> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("An 6 digit code has been sent to your Email")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 5) {
                OTPVerificationView(otpText: $otpText)
                
                GradientButton(isPerformingTask: $isLoading, title: "Verify", sfIcon: "arrow.right") {
                    Task {
                        try? await verifyCompletion!(otpText)
                    }
                }
                .disableWithOpacity(otpText.count < 6)
                .hSpacing(.trailing)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .interactiveDismissDisabled()
    }
}

#Preview {
    @State var otpText: String = ""
    func fake(_ code: String) async throws {
        return
    }
    return OTPView(otpText: $otpText, isLoading: Binding.constant(false), verifyCompletion: fake)
}
