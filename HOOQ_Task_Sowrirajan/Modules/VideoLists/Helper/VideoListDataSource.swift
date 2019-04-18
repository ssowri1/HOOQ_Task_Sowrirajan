/*
 * VideoDetailDatasource
 * This class is used for handling table view data source methods.
 * @category   Entertainment
 * @package    com.ssowri1.HOOQ-Task-Sowrirajan
 * @version    1.0
 * @author     ssowri1@gmail.com
 */
import UIKit
import SDWebImage
class VideoListDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    /// video list array
    var videoLists = [VideoFeeds]()
    /// table view delegate
    weak var delegate: ParentTableViewDelegate?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedsCell", for: indexPath) as? VideoListTableViewCell else {
            return UITableViewCell()
        }
        let video = videoLists[indexPath.row]
        let image = IMAGEBASE + (video.poster_path ?? "")
        let url = URL(string: image)
        if let url = url {
            cell.logo.sd_setImage(with: url, placeholderImage: placeholderImage, options: .transformAnimatedImage, completed: nil)
        }
        cell.title?.text = video.title
        cell.overView.text = video.overview
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView(tableView, didSelectRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell: VideoListTableViewCell = (cell as? VideoListTableViewCell)!
        cell.cellDisplayAnimation()
    }
}
