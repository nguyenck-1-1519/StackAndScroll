//
//  ViewController.swift
//  StackAndScrollView
//
//  Created by Can Khac Nguyen on 2/19/19.
//  Copyright © 2019 Can Khac Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let insets = UIEdgeInsets(top: 20, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
    
    @objc func deleteStackView(sender: UIButton) {
        guard let entryView = sender.superview else { return }
        
        UIView.animate(withDuration: 0.25, animations: {
            entryView.isHidden = true
        }, completion: { _ in
            entryView.removeFromSuperview()
        })
    }
    
    private func createEntryView() -> UIView {
        let date = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let number = NSUUID().uuidString
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        
        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        let numberLabel = UILabel()
        numberLabel.text = number
        numberLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        numberLabel.setContentHuggingPriority(UILayoutPriority.defaultLow - 1.0, for: .horizontal)
        numberLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh - 1.0, for: .horizontal)
        
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteStackView(sender:)), for: .touchUpInside)
        
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(numberLabel)
        stack.addArrangedSubview(deleteButton)
        
        return stack
    }

    @IBAction func onAddItemClicked(_ sender: Any) {
        guard let addButtonContainerView = stackView.arrangedSubviews.last else {
            fatalError("")
        }
        let nextEntryIndex = stackView.arrangedSubviews.count - 1
        
        let offset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.contentOffset.y + addButtonContainerView.bounds.size.height)
        
        let newEntryView = createEntryView()
        newEntryView.isHidden = true
        
        stackView.insertArrangedSubview(newEntryView, at: nextEntryIndex)
        
        UIView.animate(withDuration: 0.25) {
            newEntryView.isHidden = false
            self.scrollView.contentOffset = offset
        }
    }
    
    
}

