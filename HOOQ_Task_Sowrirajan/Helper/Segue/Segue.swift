/*
 * PopSegue
 * This class  is used as Custom segue for PopViewcontrolle
 * @category   Daimler
 * @package    com.contus.Daimler
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2017 Contus. All rights reserved.
 */
import UIKit
class PopSegue: UIStoryboardSegue {
    override func perform() {
        if let navigation = source.navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
