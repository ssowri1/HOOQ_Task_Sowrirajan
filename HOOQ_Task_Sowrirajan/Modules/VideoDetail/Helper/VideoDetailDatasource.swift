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
class VideoDetailDatasource: NSObject, UITableViewDelegate, UITableViewDataSource {
    /// video list array
    var videoLists = [VideoFeeds]()
    /// Table view delegate
    weak var delegate: ParentTableViewDelegate?
    /// Delegate and Datasoure methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videoDetailCell", for: indexPath) as? VideoDetailTableViewCell else {
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
        return 120
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell: VideoDetailTableViewCell = (cell as? VideoDetailTableViewCell)!
        cell.cellDisplayAnimation()
    }
}
