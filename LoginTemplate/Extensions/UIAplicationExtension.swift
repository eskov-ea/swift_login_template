//
//  UIAplicationExtension.swift
//  LoginTemplate
//
//  Created by john on 27.06.2024.
//
/// In case we want to pop back by several screens and keep the animation working

import Foundation
import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
    static func enableKeyWindowAnimation() {
        let animation = CATransition()
        animation.isRemovedOnCompletion = true
        animation.type = .push
        animation.subtype = .fromLeft
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: nil)
    }
}
