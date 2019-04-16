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
import SDWebImage
class CSVideoDetailDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var videoLists: [CSVideoLists]?
    weak var delegate: ParentTableViewDelegate?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLists?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VideoDetailTableViewCell else {
            return UITableViewCell()
        }
        let video = videoLists![indexPath.row]
        let url = URL(string: video.image ?? "")
        let placeholderImage = UIImage(named: "videoPlaceHolder")!
//        cell.logoView?.af_setImage(withURL: url!, placeholderImage: placeholderImage)
        cell.logoView.sd_setImage(with: url!, placeholderImage: placeholderImage, options: .transformAnimatedImage, completed: nil)
        cell.title?.text = video.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tableView(tableView, didSelectRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
