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
class CSVideoFeedListApiModel: Mappable {
    var statusCode: String!
    var feed = [CSVideoFeeds]()
    var content = [CSVideoDetails]()
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        statusCode <- map["status"]
        feed <- map["feed"]
        content <- map["content"]
    }
}
class CSVideoFeeds: Mappable {
    var title: String!
    var list = [CSVideoLists]()
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        title <- map["title"]
        list <- map["list"]
    }
}
class CSVideoLists: Mappable {
    var title: String?
    var videoId: String?
    var type: String?
    var icon: String?
    var image: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        title <- map["title"]
        videoId <- map["id"]
        type <- map["type"]
        icon <- map["icon"]
        image <- map["image"]
    }
}
/// Video details api model
class CSVideoDetails: Mappable {
    var channelname: String?
    var thumbnail: String?
    var videoName: String?
    var videoUrl: String?
    var shareUrl: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        channelname <- map["channelname"]
        thumbnail <- map["thumbnail"]
        videoName <- map["videoName"]
        videoUrl <- map["videoUrl"]
        shareUrl <- map["share_url"]
    }
}
