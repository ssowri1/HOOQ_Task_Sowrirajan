//
//  Loader.swift
//  testAnimateLoader
//
//  Created by user on 28/01/19.
//  Copyright © 2019 user. All rights reserved.
//
import UIKit
class Loader: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    // Programatic purposs
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    // Storyboard/Xib purposs
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("Loader", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    func startAnimating() {
        imageView.rotate360Degrees(duration: 1.7, isRemove: false)
    }
    func stopAnimating() {
        imageView.rotate360Degrees(isRemove: true)
    }
}
