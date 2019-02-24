//
//  HappinessViewController.swift
//  Happy Jai
//
//  Created by Tony Cheng on 27/1/2019.
//  Copyright © 2019 Happy Jai. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {

    let AI = ClassificationService.instance
    let duration: Double = 1.5
    var startTime = Date()
    var step: Double = 0
    var fromValue: Double = 0
    var toValue: Double = 0 {
        didSet {
            step = (toValue - fromValue) / (duration * 60)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        let displayLink = CADisplayLink(target: self, selector: #selector(calculateHappiness))
        displayLink.add(to: .main, forMode: .default)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        startTime = Date()
        fromValue = AI.getCommitedIndex()
        toValue = AI.getIndex()

        calculateHappiness()
    }

    @objc func calculateHappiness() {
//        let percentage = startTime.timeIntervalSinceNow / duration
//        let index = (toValue - fromValue) * percentage
        fromValue += step
        let value = step > 0 ? min(fromValue, toValue) : max(fromValue, toValue)
        percentageLabel.text = String(NSString(format:"%.2f", value*100)) + "%"

        if value < 0.3 {
            emojiLabel.text = "🤦‍♂️"
        }
        else if value < 0.7 {
            emojiLabel.text = "😐"
        }
        else {
            emojiLabel.text = "😄"
        }
    }
    let dialogueLabel: UILabel = {
        let label = UILabel()
        label.text = "Your hapiness today is"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "😄"
        label.font = UIFont.systemFont(ofSize: 120)
        return label
    }()
    
    let percentageLabel: UILabel = {
        let label = UILabel()
        
        label.text = "87%"
        label.font = UIFont.systemFont(ofSize: 60)
        return label
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7019607843, blue: 0, alpha: 1)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Refresh", for: .normal)
        button.layer.cornerRadius = 24
        //        button.layer.masksToBounds = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.addTarget(self, action: #selector(pressedRefresh(_:)), for: .touchUpInside)
        return button
    }()
    @objc func pressedRefresh(_ sender: UIButton){
        print("button")
        calculateHappiness()
    }
    func setupViews() {
        view.addSubview(dialogueLabel)
        view.addSubview(emojiLabel)
        view.addSubview(percentageLabel)
        view.addSubview(clearButton)
        
        view.addConstraintsWithFormat(format: "V:|-200-[v0]-48-[v1]-12-[v2]-36-[v3(48)]", views: dialogueLabel, emojiLabel, percentageLabel, clearButton)
        
        NSLayoutConstraint(item: dialogueLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: emojiLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: percentageLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: clearButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        view.addConstraintsWithFormat(format: "H:[v0(120)]", views: clearButton)
       
        
        

    }
    
    
}
