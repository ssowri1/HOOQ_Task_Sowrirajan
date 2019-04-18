/*
 * VideoDetailViewController
 * This class  is used as a delegate class for all the tableview class
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
@objc protocol ParentTableViewDelegate: class {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
}
