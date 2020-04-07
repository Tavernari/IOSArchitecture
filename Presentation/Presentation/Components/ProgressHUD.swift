//
//  ProgressHUD.swift
//  Presentation
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//
//https://stackoverflow.com/questions/28785715/how-to-display-an-activity-indicator-with-text-on-ios-8-with-swift

import UIKit

extension UIViewController {
    func showLoadingIndicator(text: String) {
        guard isLoadingIndicatorShowing() == false else {
            return
        }

        let progressHUD = ProgressHUD(text: text)
        self.view.addSubview(progressHUD)
    }

    func removeLoadingIndicator() {
        for view in self.view.subviews where view is ProgressHUD {
            view.removeFromSuperview()
        }
    }

    func isLoadingIndicatorShowing() -> Bool {
        for view in self.view.subviews where view is ProgressHUD {
            return true
        }

        return false
    }
}

class ProgressHUD: UIVisualEffectView {

    var text: String?

    let activityIndicatorSize: CGFloat = 40

    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .regular)
    let vibrancyView: UIVisualEffectView

    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }

    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        activityIndictor.startAnimating()
    }

    override func updateConstraints() {
        super.updateConstraints()

        guard let superview = self.superview else {
            return
        }

        let width = superview.frame.size.width / 2.3
        let height: CGFloat = 50.0
        self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                      y: superview.frame.height / 2 - height / 2,
                      width: width,
                      height: height)
        vibrancyView.frame = self.bounds

        activityIndictor.frame = CGRect(x: 5,
                                      y: height / 2 - activityIndicatorSize / 2,
                                      width: activityIndicatorSize,
                                      height: activityIndicatorSize)

        label.frame = CGRect(x: activityIndicatorSize + 5,
                                      y: 0,
                                      width: width - activityIndicatorSize - 15,
                                      height: height)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        label.text = text
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.gray
        label.font = UIFont.boldSystemFont(ofSize: 16)

    }
}
