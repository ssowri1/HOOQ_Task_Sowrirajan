/*
 * CSNotificationListApiModel
 * This class is used to show the Videos feed list.
 * @category   com.daimler.daimlerbus
 * @package    com.daimler.daimlerbus
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
import ObjectMapper
class CSVideoListModel: NSObject {
    // API for video feeds model
    //
    // - Parameters:
    //   - parentView: Any object
    //   - parameters
    class func getVideoFeeds(parent: AnyObject,
                             parameters: [String: Any],
                             completionHandler: @escaping (_ response: CSVideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = FEEDS
        apiOwner = Api.vuliv
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .post,
                                                                 path: path, parameters: parameters,
                                                                 completionHandler: { (response) in
                                                                    parentViewController?.stopAnimate()
                                                                    let content = String(data: (response as? Data)!, encoding: String.Encoding.utf8)
                                                                    // call the object mapper
                                                                    let responseData = Mapper<CSVideoFeedListApiModel>().map(JSONString: content!)
                                                                    if responseData?.statusCode == "200" {
                                                                        completionHandler(responseData!)
                                                                    } else {
                                                                        parentViewController?.showAlertWithTitle(title: "Oops!",
                                                                                                                 message: responseData?.statusCode)
                                                                    }
        }, errorOccured: { errorOccured in
            parentViewController?.showAlertWithTitle(title: "Oops!", message: errorOccured?.localizedDescription)
            parentViewController?.stopAnimate()
        })
    }
    // API for video detail model
    //
    // - Parameters:
    //   - parentView: Any object
    //   - parameters
    class func getVideodetails(parent: AnyObject,
                               parameters: [String: Any],
                               completionHandler: @escaping (_ response: CSVideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = FEEDID
        apiOwner = Api.vuliv
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .post,
                                                                 path: path, parameters: parameters,
                                                                 completionHandler: { (response) in
                                                                    parentViewController?.stopAnimate()
                                                                    let content = String(data: (response as? Data)!, encoding: String.Encoding.utf8)
                                                                    // call the object mapper
                                                                    let responseData = Mapper<CSVideoFeedListApiModel>().map(JSONString: content!)
                                                                    if responseData?.statusCode == "200" {
                                                                        completionHandler(responseData!)
                                                                    } else {
                                                                        parentViewController?.showAlertWithTitle(title: "Oops!",
                                                                                                                 message: responseData?.statusCode)
                                                                    }
        }, errorOccured: { errorOccured in
            parentViewController?.showAlertWithTitle(title: "Oops!", message: errorOccured?.localizedDescription)
            parentViewController?.stopAnimate()
        })
    }
}
