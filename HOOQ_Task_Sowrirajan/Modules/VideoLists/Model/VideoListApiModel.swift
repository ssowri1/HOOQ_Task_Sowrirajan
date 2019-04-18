/*
 * VideoFeedListApiModel
 * This class is used for handling api models.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
import ObjectMapper
class VideoFeedListApiModel: Mappable {
    var results = [VideoFeeds]()
    var page: Int!
    var total_results: Int!
    var dates: VideoDates?
    var total_pages: Int!
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        results <- map["results"]
        page <- map["page"]
        total_results <- map["total_results"]
        dates <- map["dates"]
        total_pages <- map["total_pages"]
    }
}
class VideoDates: Mappable {
    var minimum: String!
    var maximum: String!
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        minimum <- map["minimum"]
        maximum <- map["maximum"]
    }
}
class VideoFeeds: Mappable {
    var title: String?
    var videoId: Int?
    var overview: String?
    var poster_path: String?
    var release_date: String?
    var rating: Int?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        title <- map["title"]
        videoId <- map["id"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        rating <- map["vote_average"]
    }
}
