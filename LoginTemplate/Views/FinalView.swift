//
//  FinalView.swift
//  LoginTemplate
//
//  Created by john on 27.06.2024.
//

import SwiftUI

struct FinalView: View {
    var body: some View {
        VStack {
            Text("Congratulation!")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            Text("You have reached the end of the app")
                .font(.callout)
            
            
            Text("The main purpose of the app is build Login Template which can be extended and reused. It includes features such as async calls, password and email validation, navigation wrapper, keychain wrapper to save and read user credentials. The app has space for improvements e.g errors handling.")
                .font(.callout)
                .foregroundStyle(.gray)
                .padding(.top, 50)
                .padding(.horizontal, 20)
            
            Button("Start over") {
                Task {
                    NavigationStorage.shared.popToRoot()
                }
            }
            .buttonStyle(.bordered)
            .foregroundStyle(.white)
            .background(.red.gradient)
            .clipShape(.capsule(style: .circular))
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .hSpacing(.trailing)
        }
        .padding(15)
    }
}

#Preview {
    FinalView()
}
