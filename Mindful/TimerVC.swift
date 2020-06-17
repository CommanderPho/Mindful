//
//  ViewController.swift
//  Mindful
//
//  Created by William Shelley on 6/4/20.
//  Copyright © 2020 William Shelley. All rights reserved.
//

import UIKit

func activateCenteredConstraints(parent: UIView, view: UIView, width: CGFloat, height: CGFloat, xOffset: CGFloat = 0, yOffset: CGFloat = 0){
    
    //allows for autolayout
    
    view.translatesAutoresizingMaskIntoConstraints = false
    
    
    NSLayoutConstraint.activate([
        view.centerXAnchor.constraint(equalTo: parent.centerXAnchor, constant: xOffset),
        view.centerYAnchor.constraint(equalTo: parent.centerYAnchor, constant: yOffset),
        view.widthAnchor.constraint(equalToConstant: width),
        view.heightAnchor.constraint(equalToConstant: height),
    ])
}

class TimerVC: UIViewController {
    
    let interval = 0.1
    var timerLabel: UILabel?
    var timer: Timer?
    var currentTime = 0.0
    var startPauseBtn: UIButton?
    var resetTimerBtn: UIButton?
    var buttonSize: CGSize?
    
    var descriptionLabel: UILabel?
    let descriptionLabelMsg = "Use your phone mindfully for the next 10 minutes. I'll notify you when time is up."
    
    var titleLabel: UILabel?
    let titleLabelMsg = "Pracitce Time!"
    var swipeDirMsgLabel: UILabel?
    let swipeDirMsg = "Swipe to start mindful use"
    let textSize = CGFloat(28)
    
    let blueColor = UIColor(red: 0.3294117647, green: 0.51372549019, blue: 0.74901960784, alpha: 1)
    let redColor = UIColor(red: 0.90196078431, green: 0.10196078431, blue: 0.09019607843, alpha: 1)
    
    var defaults: UserDefaults = UserDefaults.standard
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "timer"), tag: 0)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        let bounds = self.view.bounds
        let buttonHeight = bounds.height / 6
        let buttonWidth = bounds.width / 3
        self.buttonSize = CGSize(width: buttonWidth,
                                 height: buttonHeight)
        
        guard let buttonSize = self.buttonSize else { return }
        
        //swipe gestures
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.onSwipe(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.onSwipe(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.onSwipe(gesture:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.onSwipe(gesture:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        
        
        //label
        let timerLabelWidth = bounds.width
        let timerLabelHeight = bounds.height / 10
        let timerLabelFrame = CGRect(x: 0,
                                     y: bounds.midY - timerLabelHeight / 2,
                                     width: timerLabelWidth,
                                     height: timerLabelHeight)
        
        self.timerLabel = UILabel(frame: timerLabelFrame)
        guard let timerLabel = self.timerLabel else { return }
        timerLabel.backgroundColor = .gray
        timerLabel.text = String(currentTime)
        timerLabel.textAlignment = .center
        timerLabel.font = UIFont.systemFont(ofSize: self.textSize)
        self.view.addSubview(timerLabel)
        
        //timer
        self.initTimer()
        
        //reset timer button
        let resetTimerFrame = CGRect(origin: CGPoint.zero,
                                     size: buttonSize)
        self.resetTimerBtn = UIButton(frame: resetTimerFrame)
        guard let resetTimerBtn = self.resetTimerBtn else { return }
        self.view.addSubview(resetTimerBtn)
        
        
        activateCenteredConstraints(parent: view,
                                    view: resetTimerBtn,
                                    width: resetTimerFrame.width,
                                    height: resetTimerFrame.height,
                                    xOffset: 0, //0 is default
            yOffset: resetTimerFrame.height)
        
        resetTimerBtn.backgroundColor = redColor
        resetTimerBtn.addTarget(self, action: #selector(resetTimerBtnPress), for: .touchUpInside)
        resetTimerBtn.setTitle("Reset", for: .normal)
        resetTimerBtn.setTitleColor(.black, for: .normal)
        resetTimerBtn.showsTouchWhenHighlighted = true
        
        //description label
        let descSize = CGSize(width: bounds.width * 0.8, height: bounds.height / 3)
        let descFrame = CGRect(origin: CGPoint.zero, size: descSize)
        self.descriptionLabel = UILabel(frame: descFrame)
        guard let descriptionLabel = self.descriptionLabel else { return }
        self.view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -descSize.height / 2),
            descriptionLabel.widthAnchor.constraint(equalToConstant: descSize.width),
            descriptionLabel.heightAnchor.constraint(equalToConstant: descSize.height),
        ])
        descriptionLabel.text = self.descriptionLabelMsg
        descriptionLabel.textColor = blueColor
        descriptionLabel.font = UIFont.systemFont(ofSize: textSize)
        descriptionLabel.textAlignment = .center
        descriptionLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descriptionLabel.numberOfLines = 10
        
        //title label
        let titleSize = CGSize(width: bounds.width * 0.9, height: bounds.height / 3)
        let titleFrame = CGRect(origin: CGPoint.zero, size: titleSize)
        self.titleLabel = UILabel(frame: titleFrame)
        guard let titleLabel = self.titleLabel else { return }
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: titleSize.width),
            titleLabel.heightAnchor.constraint(equalToConstant: titleSize.height),
        ])
        titleLabel.text = self.titleLabelMsg
        titleLabel.textColor = blueColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: self.textSize * 1.2)
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        titleLabel.numberOfLines = 10
        
        //swipe direction label
        //        let swipeMsgFrame = CGRect(origin: CGPoint.zero, size: titleSize)
        self.swipeDirMsgLabel = UILabel(frame: titleFrame)
        guard let swipeDirMsgLabel = self.swipeDirMsgLabel else {return}
        self.view.addSubview(swipeDirMsgLabel)
        swipeDirMsgLabel.sizeToFit()
        swipeDirMsgLabel.text = self.swipeDirMsg
        swipeDirMsgLabel.textAlignment = .center
        swipeDirMsgLabel.textColor = redColor
        swipeDirMsgLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swipeDirMsgLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            swipeDirMsgLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,
                                                      constant: bounds.midY - titleSize.height / 2),
            swipeDirMsgLabel.widthAnchor.constraint(equalToConstant: titleSize.width),
            swipeDirMsgLabel.heightAnchor.constraint(equalToConstant: titleSize.height),
        ])
    }
    
    @objc func onSwipe(gesture: UISwipeGestureRecognizer){
        self.startStopTimer()
    }
    
    func initTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: interval,
                                          target: self,
                                          selector: #selector(updateTime),
                                          userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        currentTime += interval
        let roundAmt = 1000.0
        guard let timerLabel = self.timerLabel else {return}
        let rounded = Double(round(roundAmt*currentTime)/roundAmt)
        timerLabel.text = String(rounded)
    }
    
    func startStopTimer(){
        guard let timer = self.timer else {return}
        if timer.isValid {
            timer.invalidate()
        } else {
            self.initTimer()
        }
    }
    
    @objc func resetTimerBtnPress(){
        currentTime = -interval
        updateTime()
        printDefaults()
    }
    
}

