/*
 * VideoDetailViewController
 * This class  is used as Custom segue for PopViewcontrolle
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
class PopSegue: UIStoryboardSegue {
    override func perform() {
        if let navigation = source.navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
