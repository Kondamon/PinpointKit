//
//  UIView+PinpointKit.swift
//  Pods
//
//  Created by Kenneth Parker Ackerson on 4/25/16.
//
//

/// Extends `UIView` to take a snapshot of the screen.
extension UIView {
    
    /// Create image snapshot of view.
    ///
    /// - Parameters:
    ///   - rect: The coordinates (in the view's own coordinate space) to be captured. If omitted, the entire `bounds` will be captured.
    ///   - afterScreenUpdates: A Boolean value that indicates whether the snapshot should be rendered after recent changes have been incorporated. Specify the value false if you want to render a snapshot in the view hierarchy’s current state, which might not include recent changes. Defaults to `true`.
    ///
    /// - Returns: The `UIImage` snapshot.
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(rect?.size ?? bounds.size, true, 0)
        
        var usedBounds = bounds
        if let rect = rect {
            // translate offset from origin for a certain rect
            usedBounds = CGRect(x: -rect.origin.x, y: -rect.origin.y, width: bounds.width, height: bounds.height)
        }
        
        drawHierarchy(in: usedBounds, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            preconditionFailure("`UIGraphicsGetImageFromCurrentImageContext()` should never return `nil` as we satisify the requirements of having a bitmap-based current context created with `UIGraphicsBeginImageContextWithOptions(_:_:_:)`")
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
}
