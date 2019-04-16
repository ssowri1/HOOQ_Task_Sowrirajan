/*
 * CSVideoListTableViewCell.swift
 * This class is used to subclass of videolist table view cell
 * @category   Daimler
 * @package    com.contus.Daimler
 * @version    1.0
 * @author     Contus Team <developers@contus.in>
 * @copyright  Copyright (C) 2019 Contus. All rights reserved.
 */
import UIKit
class CSVideoListTableViewCell: ParentTableViewCell {
    /// Collection view inside a table view cell
    @IBOutlet var collectionView: UICollectionView!
    /// header title label for title display
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
/// Custom collection view datasource and delegate methods for collection view inside in tableview
extension CSVideoListTableViewCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate> (_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        // Stops collection view of ot was scrolling
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
        collectionView.reloadData()
    }
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
