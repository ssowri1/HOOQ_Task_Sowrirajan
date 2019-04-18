/*
 * AppConstants
 * This class contain all the static datas
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import Foundation
import UIKit
/// screen width
let WIDTH = UIScreen.main.bounds.size.width
/// screen height
let HEIGHT = UIScreen.main.bounds.size.height
///
/// TMDB api secret key
let apiKey = "api_key=2a05877de88d08b90c4fed3cf806ca35"
///
/// base url
let BASEURL = "https://api.themoviedb.org/3/"
let IMAGEBASE = "https://image.tmdb.org/t/p/w500"
///
/// API
let NOWPLAYING = BASEURL + "movie/now_playing?" + apiKey
let VIDEODETAIL =  "movie/" + "287947" + "/similar?" + apiKey
///
/// placeholder
let placeholderImage = UIImage(named: "videoPlaceHolder")!
