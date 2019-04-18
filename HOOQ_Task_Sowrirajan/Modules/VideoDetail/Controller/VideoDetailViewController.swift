/*
 * VideoDetailViewController
 * This class is used for main viewcontroller of video lists.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
class VideoDetailViewController: ParentViewController {
    /// Interface builder outlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var releaseYear: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var videoDetailDataSource: VideoDetailDatasource!
    @IBOutlet weak var backDrop: UIImageView!
    /// poster image url path
    var posterPath: String?
    /// movie title
    var movieeTitle: String?
    /// moview description
    var movieeDescription: String?
    /// release year
    var year: String?
    /// rating
    var rating: Int?
    /// video id
    var videoId: Int?
    /// video list details array
    var videoDetailListarray = [VideoFeeds]()
    /// Page index
    fileprivate var pageIndex: Int = 1
    /// Last Page Index
    fileprivate var lastPageIndex = 1
    /// Pull to refresh declaration
    var refreshManager: PullToRefreshManager!
    /// Pagination manger declaration
    var paginatioManager: PaginationManager!
    // MARK: View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        registerRefreshIndicator()
        callApi()
    }
    func updateUI() {
        let imageUrl = IMAGEBASE + (posterPath ?? "")
        movieTitle.text = movieeTitle
        movieDescription.text = movieeDescription
        releaseYear.text = year
        ratingLabel.text = "\(rating ?? 0) ★"
        backDrop?.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholderImage, options: .transformAnimatedImage, completed: nil)
        poster?.sd_setImage(with: URL(string: imageUrl), placeholderImage: placeholderImage, options: .transformAnimatedImage, completed: nil)
    }
    // MARK: Custom methods
    override func callApi() {
        getVideoDetail(videoId: "\(String(describing: videoId))")
    }
    func getVideoDetail(videoId: String) {
        CSVideoListModel.getSimilarVideodetails(parent: self,
                                                pageNo: pageIndex) { (response) in
                                            if response.results.count > 0 {
                                                self.videoDetailListarray += response.results
                                                self.lastPageIndex = response.total_pages
                                                self.configureTableView()
                                            }
        }
    }
    func configureTableView() {
        videoDetailDataSource.videoLists = videoDetailListarray
        tableView.reloadData()
    }
    /// register Refresh controller adding
    func registerRefreshIndicator() {
        // If you want to use Pull To Refresh
        self.refreshManager = PullToRefreshManager(scrollView: self.tableView,
                                                   delegate: self)
        self.refreshManager.updateActivityIndicatorStyle(.white)
        self.refreshManager.updateActivityIndicatorColor(UIColor.black)
        // If you want to use Pagination
        self.paginatioManager = PaginationManager(scrollView: self.tableView,
                                                  delegate: self)
        self.paginatioManager.updateActivityIndicatorColor(UIColor.black)
    }
    deinit {
        debugPrint("VideoDetailViewController deallocated")
    }
}
// MARK: - Pull to Refresh
extension VideoDetailViewController: PullToRefreshManagerDelegate {
    public func pullToRefreshManagerDidStartLoading(_ controller: PullToRefreshManager,
                                                    onCompletion: @escaping () -> Void) {
        let delayTime = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            onCompletion()
            self.callApi()
        }
    }
}
// MARK: - vertical pagenation for
extension VideoDetailViewController: PaginationManagerDelegate {
    public func paginationManagerDidStartLoading(_ controller: PaginationManager,
                                                 onCompletion: @escaping () -> Void) {
        let delayTime = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: delayTime) { () -> Void in
            onCompletion()
            self.callApi()
        }
    }
    public func paginationManagerShouldStartLoading(_ controller: PaginationManager) ->
        Bool {
            pageIndex  += 1
            if pageIndex > self.lastPageIndex {
                return false
            }
            return true
    }
}
