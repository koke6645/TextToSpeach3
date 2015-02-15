//
//  ViewController.swift
//  TextToSpeach3
//
//  Created by Red_iMac on 1/29/15.
//  Copyright (c) 2015 Red_iMac. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVSpeechSynthesizerDelegate {
    
    var synthesizer = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    @IBOutlet weak var playButtom: UIButton!
    
    @IBOutlet weak var textBox: UITextView!
    
    
    @IBAction func play(sender: UIButton) {
        if !synthesizer.speaking{
            synthesizer.speakUtterance(utterance)
            println("\n\nclick play to Speaking\npaused: \(synthesizer.paused)\tspeaking: \(synthesizer.speaking)\n")
        } else if synthesizer.paused{
            synthesizer.continueSpeaking()
            println("\n\nclick play to continue\npaused: \(synthesizer.paused)\tspeaking: \(synthesizer.speaking)\n")
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        synthesizer.stopSpeakingAtBoundary(.Immediate)
        println("\n\nclick Stop\npaused: \(synthesizer.paused)\tspeaking: \(synthesizer.speaking)\n")
    }
    
    @IBAction func pause(sender: AnyObject) {
        synthesizer.pauseSpeakingAtBoundary(.Immediate)
        println("\n\nclick Paused\npaused: \(synthesizer.paused)\tspeaking: \(synthesizer.speaking)\n")
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didStartSpeechUtterance utterance: AVSpeechUtterance!) {
        println("starting")
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!) {
        println("finished")
    }
    
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance!) {
        let s = (utterance.speechString as NSString).substringWithRange(characterRange)
        println("about to say \(s)")
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        mutableAttributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: characterRange)
        textBox.attributedText = mutableAttributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textBox.attributedText = NSMutableAttributedString(string: "Step inside magnificent lobbies, corridors, and the underground Pedway system for an in-depth, personal approach to a Chicago architecture walking tour downtown.\n Available six days a week, the Loop Interior Architecture Walking Tour takes you on a creative route that weaves through buildings and secret short-cuts. 95% of the tour takes places in heated interiors.")
        
        utterance = AVSpeechUtterance(string: textBox.text)
        utterance.rate = 0.3
        
        println("\n\nFirst time\n\npaused: \(synthesizer.paused)\tspeaking: \(synthesizer.speaking)\n")
        self.synthesizer.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

