//
//  ResetPassword.swift
//  LoginTemplate
//
//  Created by john on 19.06.2024.
//

import SwiftUI

struct ResetPassword: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
                CustomViewField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                
                CustomViewField(sfIcon: "lock", hint: "Confirm Password", isPassword: true, value: $confirmPassword)
                    .padding(.top, 5)
                
                GradientButton(isPerformingTask: Binding.constant(false), title: "Reset Password", sfIcon: "arrow.right") {
                    
                }
                .hSpacing(.trailing)
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .interactiveDismissDisabled()
    }
}

#Preview {
    return ResetPassword()
}
