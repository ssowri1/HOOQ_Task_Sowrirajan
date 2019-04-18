/*
 * VideoListingViewController
 * This class is used for handling video detail page.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
import SDWebImage
class VideoListingViewController: ParentViewController {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet var videoDataSource: VideoListDataSource!
    /// Video list array
    var feeds = [VideoFeeds]()
    /// Page index
    fileprivate var pageIndex: Int = 1
    /// Last Page Index
    fileprivate var lastPageIndex = 1
    /// Pull to refresh declaration
    var refreshManager: PullToRefreshManager!
    /// Pagination manger declaration
    var paginatioManager: PaginationManager!
    /// view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        registerRefreshIndicator()
        configureVideoListTableView()
    }
    override func callApi() {
        self.getFeeds()
    }
    func getFeeds() {
        CSVideoListModel.getVideoFeeds(parent: self,
                                       pageNo: "\(pageIndex)") { (response) in
                                        self.feeds += response.results
                                        self.lastPageIndex = response.total_pages
                                        DispatchQueue.main.async {
                                            self.configureVideoListTableView()
                                        }
        }
    }
    func configureVideoListTableView() {
        videoDataSource.delegate = self
        videoDataSource.videoLists = self.feeds
        self.tabelView.reloadData()
    }
    /// Custom methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoDetailViewController {
            let tag = sender as? Int
            let feed = feeds[tag!]
            let controller = segue.destination as? VideoDetailViewController
            controller?.movieeTitle = feed.title ?? ""
            controller?.posterPath = feed.poster_path
            controller?.movieeDescription = feed.overview
            controller?.year = feed.release_date
            controller?.rating = feed.rating
            controller?.videoId = feed.videoId
        }
    }
    deinit {
        print("VideoListingViewController is deallocated")
    }
    /// register Refresh controller adding
    func registerRefreshIndicator() {
        // If you want to use Pull To Refresh
        self.refreshManager = PullToRefreshManager(scrollView: self.tabelView,
                                                   delegate: self)
        self.refreshManager.updateActivityIndicatorStyle(.white)
        self.refreshManager.updateActivityIndicatorColor(UIColor.black)
        // If you want to use Pagination
        self.paginatioManager = PaginationManager(scrollView: self.tabelView,
                                                  delegate: self)
        self.paginatioManager.updateActivityIndicatorColor(UIColor.black)
    }
}
extension VideoListingViewController: ParentTableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "listtodetail", sender: indexPath.row)
    }
}
// MARK: - Pull to Refresh
extension VideoListingViewController: PullToRefreshManagerDelegate {
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
extension VideoListingViewController: PaginationManagerDelegate {
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
