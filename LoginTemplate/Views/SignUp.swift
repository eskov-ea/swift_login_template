//
//  SignUp.swift
//  LoginTemplate
//
//  Created by john on 18.06.2024.
//

import SwiftUI

struct SignUp: View {
    @Binding var showSignup: Bool
    @State private var signUpVM: SignUpViewModel = SignUpViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomViewField(sfIcon: "at", hint: "Email", value: $signUpVM.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                CustomViewField(sfIcon: "person", hint: "Full name", value: $signUpVM.fullname)
                
                CustomViewField(sfIcon: "lock", hint: "Password", isPassword: true, value: $signUpVM.password)
                    .autocapitalization(.none)
                
                GradientButton(isPerformingTask: $signUpVM.isLoading, title: "Continue", sfIcon: "arrow.right") {
                    Task {
                        try? await signUpVM.signUp()
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(!signUpVM.isFormValid)
            }
            .padding(.top, 20)
            
            Spacer()
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("Login") {
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.orange)
            }
            .font(.caption)
            .hSpacing()
            
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .toolbar(.hidden, for: .navigationBar)
        /// Asking OTP
        .sheet(isPresented: $signUpVM.askOTPCode, content: {
            if #available(iOS 16.4, *) {
                OTPView(otpText: $signUpVM.otpText, isLoading: $signUpVM.isLoading, verifyCompletion: verifyOTPCode)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                OTPView(otpText: $signUpVM.otpText, isLoading: $signUpVM.isLoading, verifyCompletion: verifyOTPCode)
                    .presentationDetents([.height(300)])
            }
        })
    }
    func verifyOTPCode(_ code: String) async throws {
        $signUpVM.isLoading.wrappedValue = true
        guard let result = try? await ApiRepository().verifyOTPCode(code) else {
            print("Error::")
            return
        }
        
        print("Verify::")
        $signUpVM.isLoading.wrappedValue = false
        $signUpVM.askOTPCode.wrappedValue = false
        showSignup.toggle()

        signUpVM.clearState()
    }
}

#Preview {
    ContentView()
}
