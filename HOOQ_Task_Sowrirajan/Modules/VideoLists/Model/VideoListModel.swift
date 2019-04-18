/*
 * CSVideoListModel
 * This class is used for handling service call back requests.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
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
                             pageNo: String,
                             completionHandler: @escaping (_ response: VideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = "movie/now_playing?api_key=2a05877de88d08b90c4fed3cf806ca35" + "&page=\(pageNo)"
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .get,
                                                                 path: path, parameters: [:],
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
                               pageNo: Int,
                               completionHandler: @escaping (_ response: VideoFeedListApiModel) -> Void) {
        let parentViewController = parent as? ParentViewController
        parentViewController?.startAnimate()
        let path = VIDEODETAIL + "&page=\(pageNo)"
        CSApiHttpRequest.sharedInstance.executeRequestWithMethod(httpMethod: .get,
                                                                 path: path, parameters: [:],
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
