/*
 * CSTableViewDelegate
 * This class  is used as a delegate class for all the tableview class
 * @category   EnergyLife
 * @package    com.contus.EnergyLife
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2017 Contus. All rights reserved.
 */
import UIKit
@objc protocol ParentTableViewDelegate: class {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    @objc optional func scrollViewDidScroll(_ scrollView: UIScrollView)
}
