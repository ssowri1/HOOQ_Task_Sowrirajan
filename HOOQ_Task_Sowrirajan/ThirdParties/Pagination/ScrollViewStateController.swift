//
//  ScrollViewStateController.swift
//  PullToRefreshPaginationManager
//
//  Created by Ritesh-Gupta on 17/04/16.
//  Copyright © 2016 Ritesh. All rights reserved.
//

import Foundation
import UIKit
/*
 -ScrollViewStateController manages the state of your scrollView
 irrespective of whether its used as a pull-to-refresh or paginator (load more) or something else.
 -One can design their own pull-to-refresh or
 paginator by implementing ScrollViewStateController's datasource methods
 */
enum ScrollViewStateControllerState: Int {
    case normal         // when user is simply scrolling to see data
    case ready          // when user has pulled the scrollView enough i.e.
    //beyond a threshold and loading could begin if released at this stage
    case willBeLoading  // when user has released the scrollView (beyond a threshold)
    //and it is about to get stablise at a threshold
    case loading        // when user has started loading
}
public typealias CompletionHandler = () -> Void
public protocol ScrollViewStateControllerDataSource: NSObjectProtocol {
    // it defines the condition whether to use y or x point for content offset
    func stateControllerWillObserveVerticalScrolling() -> Bool
    // it defines the condition when to enter the loading zone
    func stateControllerShouldInitiateLoading(_ offset: CGFloat) -> Bool
    // it defines the condition when the loader stablises (after releasing) and loading can start
    func stateControllerDidReleaseToStartLoading(_ offset: CGFloat) -> Bool
    // it defines the condition when to cancel loading
    func stateControllerDidReleaseToCancelLoading(_ offset: CGFloat) -> Bool
    // it will return the loader frame
    func stateControllerLoaderFrame() -> CGRect
    // it will return the loader inset
    func stateControllerInsertLoaderInsets(_ startAnimation: Bool) -> UIEdgeInsets
}
extension ScrollViewStateControllerDataSource {
    public func stateControllerWillObserveVerticalScrolling() -> Bool {
        // default implementation
        return true
    }
}
public protocol ScrollViewStateControllerDelegate: NSObjectProtocol {
    func stateControllerWillStartLoading(_ controller: ScrollViewStateController,
                                         loadingView: UIActivityIndicatorView)
    func stateControllerShouldStartLoading(_ controller: ScrollViewStateController) -> Bool
    func stateControllerDidStartLoading(_ controller: ScrollViewStateController,
                                        onCompletion: @escaping CompletionHandler)
    func stateControllerDidFinishLoading(_ controller: ScrollViewStateController)
}
extension ScrollViewStateControllerDelegate {
    public func stateControllerShouldStartLoading(_ controller: ScrollViewStateController) -> Bool {
        // default implementation
        return true
    }
    public func stateControllerWillStartLoading(_ controller: ScrollViewStateController,
                                                loadingView: UIActivityIndicatorView) {
        // default imlpementation
    }
    public func stateControllerDidFinishLoading(_ controller: ScrollViewStateController) {
        // default imlpementation
    }
}
public class StateConfiguration: NSObject {
    var thresholdInitiateLoading: CGFloat = 0
    var thresholdStartLoading: CGFloat = 0
    var loaderFrame: CGRect = CGRect.zero
    var showDefaultLoader = true
    public init(thresholdInitiateLoading: CGFloat,
                loaderFrame: CGRect,
                thresholdStartLoading: CGFloat,
                showDefaultLoader: Bool = true) {
        self.loaderFrame = loaderFrame
        self.showDefaultLoader = showDefaultLoader
        self.thresholdInitiateLoading = thresholdInitiateLoading
        self.thresholdStartLoading = thresholdStartLoading
    }
}
open class ScrollViewStateController: NSObject {
    let kDefaultLoadingHeight: CGFloat = 64.0
    let kInsetInsertAnimationDuration: TimeInterval = 0.7
    let kInsetRemoveAnimationDuration: TimeInterval = 0.3
    weak var dataSource: ScrollViewStateControllerDataSource!
    weak var delegate: ScrollViewStateControllerDelegate!
    var loadingView = UIActivityIndicatorView(style: .gray)
    var scrollView: UIScrollView!
    var state: ScrollViewStateControllerState = .normal
    var observer: NSKeyValueObservation?
    public init(scrollView: UIScrollView?,
                dataSource: ScrollViewStateControllerDataSource?,
                delegate: ScrollViewStateControllerDelegate?, showDefaultLoader: Bool = true) {
        super.init()
        self.scrollView = scrollView
        self.dataSource = dataSource
        self.delegate = delegate
        self.state = .normal
        keyValueChangeObserser()
        if showDefaultLoader {
            addDefaultLoadView()
        }
    }
    convenience override init() {
        self.init(scrollView: nil, dataSource: nil, delegate: nil)
    }
    /// Key value Path Obserser
    func keyValueChangeObserser() {
        let handler = { (scrollView: UIScrollView,
            change: NSKeyValueObservedChange<CGPoint>) in
            if self.delegate != nil, self.dataSource != nil {
                if let contentPoint = change.newValue {
                    var newOffset: CGFloat = 0
                    if self.dataSource.stateControllerWillObserveVerticalScrolling() {
                        newOffset = contentPoint.y
                    } else {
                        newOffset = contentPoint.y
                    }
                    self.handleLoadingCycle(newOffset)
                }
            }
        }
        observer = scrollView.observe(\UIScrollView.contentOffset,
                                      options: [NSKeyValueObservingOptions.new],
                                      changeHandler: handler)
    }
    fileprivate func addDefaultLoadView() {
        self.loadingView.frame = self.dataSource.stateControllerLoaderFrame()
        self.scrollView.addSubview(self.loadingView)
    }
    func updateActivityIndicatorStyle(_ newStyle: UIActivityIndicatorView.Style) {
        self.loadingView.removeFromSuperview()
        self.loadingView = UIActivityIndicatorView(style: newStyle)
        self.loadingView.hidesWhenStopped = false
        addDefaultLoadView()
    }
    func updateActivityIndicatorColor(_ color: UIColor) {
        self.loadingView.color = color
    }
    fileprivate func handleLoadingCycle(_ offset: CGFloat) {
        if self.dataSource.stateControllerShouldInitiateLoading(offset) {
            self.delegate.stateControllerWillStartLoading(self, loadingView: self.loadingView)
        }
        if self.scrollView.isDragging {
            self.loadingView.alpha = abs(self.scrollView.contentOffset.y)/128.0
            self.loadingView.transform =
                CGAffineTransform(rotationAngle:
                    (2*CGFloat.pi)*(abs(self.scrollView.contentOffset.y)/128))
            switch self.state {
            case .normal:
                if self.dataSource.stateControllerDidReleaseToStartLoading(offset) {
                    self.state = .ready
                }
            case .ready:
                if self.dataSource.stateControllerDidReleaseToCancelLoading(offset) {
                    self.state = .normal
                }
            default: break
            }
        } else if scrollView.isDecelerating {
            if self.state == .ready {
                handleReadyState()
            }
        }
    }
    fileprivate func handleReadyState() {
        self.state = .willBeLoading
        if self.delegate.stateControllerShouldStartLoading(self) {
            self.loadingView.frame = self.dataSource.stateControllerLoaderFrame()
            DispatchQueue.main.async { () -> Void in
                self.startUIAnimation({ [weak self] () -> Void in
                    if let weakSelf = self {
                        weakSelf.startLoading()
                    }
                })
            }
        } else {
            self.state = .normal
        }
    }
    fileprivate func startLoading() {
        self.state = .loading
        self.delegate.stateControllerDidStartLoading(self, onCompletion: {[weak self] () -> Void in
            if let weakSelf = self {
                weakSelf.stopLoading()
            }
        })
    }
    fileprivate func stopLoading() {
        self.state = .normal
        DispatchQueue.main.async { () -> Void in
            self.stopUIAnimation({ [weak self] () -> Void in
                if let weakSelf = self {
                    if weakSelf.delegate != nil, weakSelf.dataSource != nil {
                        weakSelf.delegate.stateControllerDidFinishLoading(weakSelf)
                    }
                }
            })
        }
    }
    fileprivate func startUIAnimation(_ onCompletion: @escaping CompletionHandler) {
        handleAnimation(startAnimation: true) { () -> Void in
            onCompletion()
        }
    }
    fileprivate func stopUIAnimation(_ onCompletion: @escaping CompletionHandler) {
        handleAnimation(startAnimation: false) { () -> Void in
            onCompletion()
        }
    }
    fileprivate func handleAnimation(startAnimation: Bool,
                                     onCompletion: @escaping CompletionHandler) {
        if startAnimation {
            DispatchQueue.main.async { () -> Void in
                self.loadingView.startAnimating()
                let oldContentOffset = self.scrollView.contentOffset
                self.scrollView.contentInset =
                    self.dataSource.stateControllerInsertLoaderInsets(startAnimation)
                self.scrollView.contentOffset = oldContentOffset
                /* this has been done to make the animation
                 smoother as just animating the content inset has little glitch */
                onCompletion()
            }
        } else {
            DispatchQueue.main.async { () -> Void in
                self.loadingView.stopAnimating()
                UIView.animate(withDuration: self.kInsetRemoveAnimationDuration,
                               animations: {[weak self] () -> Void in
                                if let weakSelf = self {
                                    if weakSelf.delegate != nil {
                                        weakSelf.scrollView.contentInset =
                                            weakSelf.dataSource.stateControllerInsertLoaderInsets(startAnimation)
                                    }
                                }
                    }, completion: { (_: Bool) -> Void in
                        onCompletion()
                })
            }
        }
    }
    deinit {
        observer?.invalidate()
        //self.scrollView.removeObserver(self, forKeyPath: "contentOffset")
    }
}
