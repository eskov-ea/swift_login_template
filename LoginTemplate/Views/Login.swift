//
//  Login.swift
//  LoginTemplate
//
//  Created by john on 18.06.2024.
//

import SwiftUI

struct Login: View {
    enum FocusableField: Hashable, CaseIterable {
        case email, password
    }
    
    @Binding var showSignup: Bool
    @State private var loginVM: LoginViewModel = LoginViewModel()
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetPasswordView: Bool = false
    @StateObject private var storage = NavigationStorage.shared
    
    @FocusState private var focusedField: FocusableField?
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Spacer()
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                CustomViewField(sfIcon: "at", hint: "Email", value: $loginVM.email)
                    .focused($focusedField, equals: .email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .background(.orange.opacity(loginVM.errorMessage == nil ? 0 : 0.1))
                    .clipShape(.capsule)
                    .onSubmit {
                        focusNextField()
                    }
                    .shake($loginVM.shouldShake)
                
                CustomViewField(sfIcon: "lock", hint: "Password", isPassword: true, value: $loginVM.password)
                    .autocapitalization(.none)
                    .focused($focusedField, equals: .password)
                    .background(.orange.opacity(loginVM.errorMessage == nil ? 0 : 0.1))
                    .clipShape(.capsule)
                    .shake($loginVM.shouldShake)
                
                Button("Forgot password?") {
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .foregroundColor(.orange)
                .hSpacing(.trailing)
                
                
                
                GradientButton(isPerformingTask: $loginVM.isLoading, title: "Login", sfIcon: "arrow.right") {
                    if focusedField != .none {
                        focusedField = .none
                    }
                    if loginVM.isLoading { return }
                    print("Try to login")
                    Task {
                        guard let token = try await loginVM.login() else {
                            print("Not logged in")
                            return
                        }
                        
                        print("Auth Token is: \(String(describing: token))")
                        $loginVM.askOTPCode.wrappedValue.toggle()
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(!loginVM.isLoginDataValid)
                
                Text(loginVM.errorMessage ?? " ")
                    .foregroundStyle(.red)
            }
            .padding(.top, 20)
            
            Spacer()
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("Sign up") {
                    showSignup.toggle()
                }
                .fontWeight(.bold)
                .tint(.orange)
            }
            .font(.caption)
            .hSpacing()
            
        }
        .contentShape(Rectangle())
        .padding(.vertical, 15)
        .padding(.horizontal, 10)
        .onTapGesture {
            focusedField = .none
        }
        .toolbar(.hidden, for: .navigationBar)
        /// Askin Email for sending reset link
        .sheet(isPresented: $showForgotPasswordView, content: {
            if #available(iOS 16.4, *) {
                ForgotPassword(showResertPasswordView: $showResetPasswordView)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ForgotPassword(showResertPasswordView: $showResetPasswordView)
                    .presentationDetents([.height(300)])
            }
        })
        /// Reseting the password
        .sheet(isPresented: $showResetPasswordView, content: {
            if #available(iOS 16.4, *) {
                ResetPassword()
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                ResetPassword()
                    .presentationDetents([.height(300)])
            }
        })
        /// Asking OTP
        .sheet(isPresented: $loginVM.askOTPCode, content: {
            if #available(iOS 16.4, *) {
                OTPView(otpText: $loginVM.otpText, isLoading: $loginVM.isLoading, verifyCompletion: loginVM.verifyOTPCode)
                    .presentationDetents([.height(300)])
                    .presentationCornerRadius(30)
            } else {
                OTPView(otpText: $loginVM.otpText, isLoading: $loginVM.isLoading, verifyCompletion: loginVM.verifyOTPCode)
                    .presentationDetents([.height(300)])
            }
        })
    }
    
    func focusNextField() {
        switch focusedField {
        case .email:
            focusedField = .password
        case .password:
            focusedField = .email
        case .none:
            break
        }
    }
}

#Preview {
    ContentView()
}
