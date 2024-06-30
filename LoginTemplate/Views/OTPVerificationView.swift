//
//  OTPVerificationView.swift
//  LoginTemplate
//
//  Created by john on 19.06.2024.
//

import SwiftUI

struct OTPVerificationView: View {
    @Binding var otpText: String
    @FocusState private var isKeyboardShown: Bool
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { index in
                OTPTextBox(index)
            }
        }
        .padding(.top, 10)
        .padding(.bottom, 20)
        .background(content: {
            TextField("", text: $otpText.limit(6))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .frame(width: 1, height: 1)
                .opacity(0.0001)
                .blendMode(.screen)
                .focused($isKeyboardShown)
        })
        .contentShape(.rect)
        .onTapGesture {
            isKeyboardShown.toggle()
        }
    }
    
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(.gray, lineWidth: 0.5)
                .fill(.white)
        )
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    @State var otpText: String = ""
    return OTPVerificationView(otpText: $otpText)
}

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}

