/*
 * CSNotificationListApiModel
 * This class is used to show for Videos feed list tble view cell.
 * @category   com.daimler.daimlerbus
 * @package    com.daimler.daimlerbus
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
class VideoListTableViewCell: ParentTableViewCell {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var overView: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
