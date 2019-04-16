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
    var timer = Timer()
    var offSet: CGFloat = 0
    var feeds = [CSVideoFeeds]()
    var selecedIndex: Int?
    private let bannerImages = ["Banner1", "Banner2", "Banner3", "Banner4"]
    /// view life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: bannerImages.count * Int(self.view.frame.size.width), height: 0)
        callApi()
    }
    override func callApi() {
        self.getFeeds()
    }
    func getFeeds() {
        let param: [String: Any] = [
            "header": "vuliv_mp_an Dalvik/2.1.0 (Linux; U; Android 8.0.0; SM-J600G Build/R16NW)",
            "ip_address": "10.42.0.164",
            "os_version_code": "26",
            "os_version_name": "8.0.0",
            "page": "1",
            "_interface": "AN",
            "deviceId": "358461096297447",
            "model": "SAMSUNGSM-J600G",
            "package": "com.player",
            "region": "in",
            "uid": "358461096297447",
            "version": "5.0.2",
            "versionCode": "28"
        ]
        CSVideoListModel.getVideoFeeds(parent: self,
                                       parameters: param) { (response) in
                                        self.feeds = response.feed.filter { $0.title != "Sponsored" }
                                        DispatchQueue.main.async {
                                            self.tabelView.reloadData()
                                            self.stopAnimate()
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
    deinit {
        print("CSListingViewController is deallocated")
    }
}

// MARK: TableView delegate functions
extension VideoListingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "videolistcell", for: indexPath) as? CSVideoListTableViewCell else {
            return UITableViewCell()
        }
        cell.title.text = self.feeds[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? CSVideoListTableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tablewViewCell = cell as? CSVideoListTableViewCell else { return }
        storedOffsets[indexPath.row] = tablewViewCell.collectionViewOffset
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
// MARK: CollectionView delegate functions
extension VideoListingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds[collectionView.tag].list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcell",
                                                            for: indexPath) as? VideosCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        let videos = self.feeds[collectionView.tag].list
        cell.title.text = videos[indexPath.row].title
        let iconUrl = videos[indexPath.row].image ?? ""
        let placeholderImage = UIImage(named: "videoPlaceHolder")!
        if let url = URL(string: iconUrl) {
            cell.thumbnailImageView.sd_setImage(with: url, placeholderImage: placeholderImage, options: .transformAnimatedImage, completed: nil)
        }
        cell.cellDisplayAnimation()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = WIDTH/2
        return CGSize(width: viewWidth, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selecedIndex = indexPath.row
        performSegue(withIdentifier: "feedtofeeddetail", sender: collectionView.tag)
    }
//    /// Custom methods
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination is VideoDetailViewController {
//            let tag = sender as? Int
//            let controller = segue.destination as? VideoDetailViewController
//            controller?.videoLists = feeds[tag!].list
//            controller?.selecedIndex = selecedIndex
//        }
//    }
}
