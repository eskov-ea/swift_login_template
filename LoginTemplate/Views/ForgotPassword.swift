//
//  ForgotPassword.swift
//  LoginTemplate
//
//  Created by john on 19.06.2024.
//

import SwiftUI

struct ForgotPassword: View {
    @Binding var showResertPasswordView: Bool
    @State private var email: String = ""
    @Environment(\.dismiss) private var dismiss
    var disableOnEmailValidation: Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$")
        return !emailTest.evaluate(with: email)
    }
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
            
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("Please enter your Email to resert password.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomViewField(sfIcon: "at", hint: "Email", value: $email)
                
                GradientButton(isPerformingTask: Binding.constant(false), title: "Send Link", sfIcon: "arrow.right") {
                    
                    Task {
                        dismiss()
                        print(disableOnEmailValidation)
                        
                        try? await Task.sleep(for: .seconds(0))
                        showResertPasswordView = true
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(disableOnEmailValidation)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .interactiveDismissDisabled()
    }
}

#Preview {
    ContentView()
}
