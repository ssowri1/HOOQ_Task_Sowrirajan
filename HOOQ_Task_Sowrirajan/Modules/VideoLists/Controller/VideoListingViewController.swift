/*
 * CSListingViewController.swift
 * This class is used to configure the Video listing page
 * @category   Daimler
 * @package    com.contus.Daimler
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
import SDWebImage
class VideoListingViewController: ParentViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tabelView: UITableView!
    /// Use to store offset values
    var storedOffsets = [Int: CGFloat]()
    @IBOutlet var videoDataSource: VideoListDataSource!
    var timer = Timer()
    var offSet: CGFloat = 0
    var feeds = [VideoFeeds]()
    var selecedIndex: Int?
    private let bannerImages = ["Banner1", "Banner2", "Banner3", "Banner4"]
    /// view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: bannerImages.count * Int(self.view.frame.size.width), height: 0)
        callApi()
        configureVideoListTableView()
    }
    override func callApi() {
        self.getFeeds()
    }
    func getFeeds() {
        CSVideoListModel.getVideoFeeds(parent: self,
                                       parameters: [:]) { (response) in
                                        self.feeds = response.results
                                        DispatchQueue.main.async {
                                            self.configureVideoListTableView()
                                        }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        autoScroll()
    }
    override func viewDidAppear(_ animated: Bool) {
        allocateScrollView()
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    func configureVideoListTableView() {
        videoDataSource.delegate = self
        videoDataSource.videoLists = self.feeds
        self.tabelView.reloadData()
    }
    func allocateScrollView() {
        for (index, item) in bannerImages.enumerated() {
            let containerView = UIView(frame: CGRect(x: index * Int(WIDTH), y: 0, width: Int(WIDTH),
                                                     height: Int(scrollView.frame.size.height)))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Int(containerView.frame.size.width),
                                                      height: Int(containerView.frame.size.height)))
            imageView.image = UIImage.init(named: item)
            imageView.contentMode = .scaleToFill
            let button = UIButton(frame: CGRect(x: 10,
                                                y: Int((containerView.frame.size.height)-50),
                                                width: 40,
                                                height: 40))
            button.setImage(UIImage.init(named: "play"), for: .normal)
            containerView.addSubview(imageView)
            containerView.addSubview(button)
            scrollView.addSubview(containerView)
        }
    }
    @objc func autoScroll() {
        let totalPossibleOffset = CGFloat(bannerImages.count - 1) * WIDTH
        if offSet == totalPossibleOffset {
            offSet = 0 // come back to the first image after the last image
        } else {
            offSet += WIDTH
        }
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                self.scrollView.contentOffset.x = CGFloat(self.offSet)
            }, completion: nil)
        }
    }
    /// Custom methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoDetailViewController {
            let tag = sender as? Int
            let feed = feeds[tag!]
            let controller = segue.destination as? VideoDetailViewController
            controller?.movieeTitle = feed.title ?? "sdscsd"
            controller?.posterPath = feed.poster_path
            controller?.movieeDescription = feed.overview
            controller?.year = feed.release_date
            controller?.rating = feed.rating
            controller?.videoId = feed.videoId
        }
    }
    deinit {
        print("CSListingViewController is deallocated")
    }
}
extension VideoListingViewController: ParentTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "listtodetail", sender: indexPath.row)
    }
}
