//
//  ParentViewController.swift
//  HOOQ_Task_Sowrirajan
//
//  Created by user on 16/04/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
class ParentViewController: UIViewController {
    let loaderVw = Loader()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /// This method is used to call the api
    func callApi() {
    }
}
// MARK: - Activity Indicator
extension ParentViewController {
    /// This method is used to start the loader
    func startAnimate() {
        loaderVw.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        loaderVw.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.loaderVw.center = self.view.center
        self.view.addSubview(loaderVw)
        loaderVw.startAnimating()
    }
    /// This method to stop the loader
    func stopAnimate() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.loaderVw.stopAnimating()
            self.loaderVw.removeFromSuperview()
        }
    }
    func resignTextFieldFirstResponders() {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
    }
    func resignAllFirstResponders() {
        view.endEditing(true)
    }
}

extension UIViewController {
    /// Shows alert with no action for ok button
    /// - Parameters:
    ///   - title: Title to show on alert
    ///   - message: Message to show on alert
    ///   - completion: handler function to perform after presenting alert
    func showAlertWithTitle(title: String?, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    /// Shows alert with action for ok button
    /// - Parameters:
    ///   - title: Title to show on alert
    ///   - message: Message to show on alert
    ///   - actionHandler: handler function to perform
    func showAlertWithTitle(title: String?, message: String?, actionHandler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: actionHandler))
        self.present(alert, animated: true, completion: nil)
    }
    /// Shows the alert with alert action
    /// - Parameters:
    ///   - title: Title to show on alert
    ///   - message: Message to show on alert
    ///   - actions: actions for items in alert
    func showAlertWithTitle(title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    /// - Email Validation Function
    /// - emailString: The String which the user has entered for email
    func isValidEmail(emailString: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailString) {
            return true
        } else {
            self.showAlertWithTitle(title: "", message: "Please Enter Valid Email ID !")
            return false
        }
    }
    /// Hide the Keyboard When User tab the View
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    /// Dismiss the Keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

