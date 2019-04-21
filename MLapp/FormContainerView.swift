//
//  FormContainerView.swift
//  yazar.io
//
//  Created by ssaylanc on 11.02.2019.
//  Copyright © 2019 ssaylanc. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

enum CornerSide: Int {
    case all
    case left
    case right
    case top
    case bottom
}

extension UIView {
    func setRoundCorners(_ side: CornerSide, radius: CGFloat = 0) {
        
        let cornerRadius = radius > 0 ? radius:frame.size.height/2
        var corners:UIRectCorner!
        switch side {
        case .left:
            corners = [.topLeft, .bottomLeft]
        case .right:
            corners = [.topRight, .bottomRight]
        case .top:
            corners = [.topLeft, .topRight]
        case .bottom:
            corners = [.bottomLeft, .bottomRight]
        case .all:
            corners = [.topRight, .bottomRight, .topLeft, .bottomLeft]
        }
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    
    //    layerMaxXMaxYCorner - bottom right corner
    //    layerMaxXMinYCorner - top right corner
    //    layerMinXMaxYCorner - bottom left corner
    //    layerMinXMinYCorner - top left corner
    
    func roundCorners(_ corners:UIRectCorner,_ cornerMask:CACornerMask, radius: CGFloat) {
        if #available(iOS 11.0, *){
            self.clipsToBounds = false
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        }else{
            let rectShape = CAShapeLayer()
            rectShape.bounds = self.frame
            rectShape.position = self.center
            rectShape.path = UIBezierPath(roundedRect: self.bounds,    byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
            self.layer.mask = rectShape
        }
    }
    
}



extension UIView {
    //    func roundCorners(_ corners:UIRectCorner,_ cornerMask:CACornerMask, radius: CGFloat) {
    //        if #available(iOS 11.0, *){
    //            self.clipsToBounds = false
    //            self.layer.cornerRadius = radius
    //            self.layer.maskedCorners = cornerMask
    //        }else{
    //            let rectShape = CAShapeLayer()
    //            rectShape.bounds = self.frame
    //            rectShape.position = self.center
    //            rectShape.path = UIBezierPath(roundedRect: self.bounds,  byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
    //            self.layer.mask = rectShape
    //        }
    //    }
    // set corner radius to UIView
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        if #available(iOS 11, *) {
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = corners
        } else {
            var cornerMask = UIRectCorner()
            if(corners.contains(.layerMinXMinYCorner)){
                cornerMask.insert(.topLeft)
            }
            if(corners.contains(.layerMaxXMinYCorner)){
                cornerMask.insert(.topRight)
            }
            if(corners.contains(.layerMinXMaxYCorner)){
                cornerMask.insert(.bottomLeft)
            }
            if(corners.contains(.layerMaxXMaxYCorner)){
                cornerMask.insert(.bottomRight)
            }
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornerMask, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

