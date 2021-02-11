//
//  DennyLog.swift
//  DennyLog
//
//  Created by denny on 2021/02/11.
//

import Foundation
import UIKit

public class DennyLogImpl: UIViewController, UIGestureRecognizerDelegate {
    struct Constants {
        static let miniModeSize = CGSize(width: 68, height: 44)
        static let badgeViewWidth = CGFloat(22)
    }
    
    private static var activated = false
    
    var mainWindow: UIWindow? {
        if self.view.window != nil {
            return self.view.window
        }
        guard let window = UIApplication.shared.delegate?.window else {
            return nil
        }
        return window
    }
    
    private var windowSize: CGSize {
        if let window = UIApplication.shared.keyWindow {
            return window.bounds.size
        }
        return UIScreen.main.bounds.size
    }
    
    func adjustViewPosition(pos: CGPoint) -> CGPoint {
        var adjustedPos = pos
        
        let safeAreaInsets = self.safeAreaInsets()

        adjustedPos.x = max(pos.x, safeAreaInsets.left)
        adjustedPos.y = max(pos.y, safeAreaInsets.top)
        adjustedPos.x = min(adjustedPos.x,
                            windowSize.width - Constants.miniModeSize.width - safeAreaInsets.right)
        adjustedPos.y = min(adjustedPos.y,
                            windowSize.height - safeAreaInsets.bottom - Constants.miniModeSize.height)
        
        return adjustedPos
    }
    
    func bringToFront() {
        self.view.superview?.bringSubviewToFront(self.view)
    }
    
    static func statusBarHeight() -> CGFloat {
        if UIApplication.shared.isStatusBarHidden {
            return 0.0
        }
        
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
    
    func show() {
        self.view.isHidden = false
    }
    
    func hide() {
        self.view.isHidden = true
    }
}
