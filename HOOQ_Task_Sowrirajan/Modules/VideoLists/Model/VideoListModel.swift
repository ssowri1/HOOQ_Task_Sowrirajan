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
                             completionHandler: @escaping (_ response: VideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = "movie/now_playing?api_key=2a05877de88d08b90c4fed3cf806ca35"
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .get,
                                                                 path: path, parameters: parameters,
                                                                 completionHandler: { (response) in
                                                                    parentViewController?.stopAnimate()
                                                                    let content = String(data: (response as? Data)!, encoding: String.Encoding.utf8)
                                                                    // call the object mapper
                                                                    let responseData = Mapper<VideoFeedListApiModel>().map(JSONString: content!)
                                                                    if responseData != nil {
                                                                        completionHandler(responseData!)
                                                                    } else {
                                                                        parentViewController?.showAlertWithTitle(title: "Oops!",
                                                                                                                 message: "Something went wrong")
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
    class func getSimilarVideodetails(parent: AnyObject,
                               parameters: [String: Any],
                               completionHandler: @escaping (_ response: VideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = VIDEODETAIL
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .post,
                                                                 path: path, parameters: parameters,
                                                                 completionHandler: { (response) in
                                                                    parentViewController?.stopAnimate()
                                                                    let content = String(data: (response as? Data)!, encoding: String.Encoding.utf8)
                                                                    // call the object mapper
                                                                    let responseData = Mapper<VideoFeedListApiModel>().map(JSONString: content!)
                                                                    if responseData != nil {
                                                                        completionHandler(responseData!)
                                                                    } else {
                                                                        parentViewController?.showAlertWithTitle(title: "Oops!",
                                                                                                                 message: "Something went wrong")
                                                                    }
        }, errorOccured: { errorOccured in
            parentViewController?.showAlertWithTitle(title: "Oops!", message: errorOccured?.localizedDescription)
            parentViewController?.stopAnimate()
        })
    }
}
