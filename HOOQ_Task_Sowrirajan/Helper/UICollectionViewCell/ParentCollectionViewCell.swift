/*
 * VideoDetailViewController
 * This class is used to base class of all collection view cell
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
class ParentCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func makeShadowtoCell() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
}
