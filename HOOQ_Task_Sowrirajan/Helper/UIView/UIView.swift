/*
 * VideoDetailViewController
 * This class  is used as extension of UIView
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
/// Spin animation
extension UIView {
    func rotate360Degrees(duration: CFTimeInterval = 2, isRemove: Bool) {
        if isRemove {
            self.layer.removeAllAnimations()
        } else {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(Double.pi * 2)
            rotateAnimation.isRemovedOnCompletion = isRemove
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount=Float.infinity
            self.layer.add(rotateAnimation, forKey: nil)
        }
    }
}
class customView: UIView {
    override func awakeFromNib() {
        self.setCustomGradient(colorsArray:[UIColor.white.cgColor, UIColor.blue.cgColor])
    }
    /// To set custom gradient to an UIView
    func setCustomGradient(colorsArray: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colorsArray
        gradientLayer.frame = self.bounds
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.clipsToBounds = true
    }
}
//// Story board Extra Feature for create border radius, border width and border Color
extension UIView {
    /// corner radius
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}
