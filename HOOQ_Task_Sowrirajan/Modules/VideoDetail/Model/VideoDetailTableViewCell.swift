/*
 * VideoDetailTableViewCell
 * This class is used for handling table view cell custom class.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
class VideoDetailTableViewCell: ParentTableViewCell {
    /// poster image view
    @IBOutlet weak var logo: UIImageView!
    /// movie title label
    @IBOutlet weak var title: UILabel!
    /// moview description label
    @IBOutlet weak var overView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
