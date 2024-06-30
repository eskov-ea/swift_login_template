//
//  NavigationPathItem.swift
//  LoginTemplate
//
//  Created by john on 27.06.2024.
//

import SwiftUI

final class NavigationPathItem: Identifiable, Hashable {
    
    let id: String
    let title: String?
    var isShown: Bool
    var destination: () -> AnyView
    
    init(id: String, title: String?, isShown: Bool = false, destination: @escaping () -> AnyView) {
        self.id = id
        self.title = title
        self.isShown = isShown
        self.destination = destination
    }
    
    static func == (lhs: NavigationPathItem, rhs: NavigationPathItem) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
