//
//  LoginTemplateApp.swift
//  LoginTemplate
//
//  Created by john on 18.06.2024.
//

import SwiftUI

@main
struct LoginTemplateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
