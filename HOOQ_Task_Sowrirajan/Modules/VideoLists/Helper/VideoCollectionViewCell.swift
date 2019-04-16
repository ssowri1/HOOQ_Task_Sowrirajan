/*
 * CSVideosCollectionViewCell.swift
 * This class is used to subclass of videolist collection view cell
 * @category   Daimler
 * @package    com.contus.Daimler
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
class VideosCollectionViewCell: ParentCollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        makeShadowtoCell()
    }
    /// Card view animtion of 3d
    let translate3DAnimate: CATransform3D = {
        let offset = CGPoint(x: CGFloat(0), y: CGFloat(0))
        var rotationAndPerspectiveTransform: CATransform3D = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -1000.0
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, .pi * 0.1, 1.0, 0.0, 0.0)
        rotationAndPerspectiveTransform = CATransform3DTranslate(rotationAndPerspectiveTransform, offset.x,
                                                                 offset.y, 0.0)
        return rotationAndPerspectiveTransform
    }()
    /// Function for tableview cell will appear
    func cellDisplayAnimation() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(10), height: CGFloat(10))
        self.layer.transform = CATransform3DMakeScale(0.85, 0.85, 0.85)
        UIView.beginAnimations("scaleTableViewCellAnimationID", context: nil)
        UIView.setAnimationDuration(0.5)
        self.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
        self.alpha = 1
        self.layer.transform = CATransform3DIdentity
        UIView.commitAnimations()
    }
    /// CardView animation effect
    func cardAnimation() {
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            self.layer.anchorPoint = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
            self.layer.transform = self.translate3DAnimate
        }, completion: {(_ finished: Bool) -> Void in
            // code to be executed when flip is completed
        })
    }
}
