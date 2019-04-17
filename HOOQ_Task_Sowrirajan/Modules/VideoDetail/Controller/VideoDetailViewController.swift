/*
 * CSListingViewController.swift
 * This class is used to configure the Video detail page
 * @category   Daimler
 * @package    com.contus.Daimler
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
class VideoDetailViewController: ParentViewController {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet var videoDetailDataSource: VideoListDataSource!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var channelNameLable: UILabel!
    var posterPath: String?
    var movieeTitle: String?
    var movieeDescription: String?
    var year: String?
    var rating: Int?
    var videoId: Int?
    // MARK: View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        callApi()
    }
    func updateUI() {
        movieTitle.text = movieeTitle
        poster.image = UIImage.init(named: "rating")
        movieDescription.text = movieeDescription
        releaseYear.text = year
        ratingLabel.text = "\(rating ?? 0)"
    }
    // MARK: Custom methods
    override func callApi() {
        getVideoDetail(videoId: "\(videoId)")
    }
    func getVideoDetail(videoId: String) {
        CSVideoListModel.getSimilarVideodetails(parent: self,
                                         parameters: [:]) { (response) in
                                            if response != nil {
                                                self.configureTableView(array: response.results)
                                            }
        }
    }
    func configureTableView(array: [VideoFeeds]) {
        videoDetailDataSource.videoLists = array
        tableView.reloadData()
    }
    deinit {
        debugPrint("CSVideoDetailViewController deallocated")
    }
}
