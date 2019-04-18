/*
 * VideoDetailViewController
 * This class  is used as custom loader of UIView
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
class Loader: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    // Programatic purposs
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    // Storyboard/Xib purposs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("Loader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    func startAnimating() {
        imageView.rotate360Degrees(duration: 1.7, isRemove: false)
    }
    func stopAnimating() {
        imageView.rotate360Degrees(isRemove: true)
    }
}
