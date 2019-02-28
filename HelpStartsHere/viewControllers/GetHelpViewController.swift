//
//  GetHelpViewController.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

//
//  GetHelpViewController.swift
//  HelpStartsHere
//
//  Created by mac on 13/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//

import UIKit
import SideMenu
import SMTPLite
import Speech

class GetHelpViewController: UIViewController {
    //outlets
    @IBOutlet weak var servicesNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneFIeld: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var addressField: PlaceholderUITextView!
    @IBOutlet weak var discriptionField: PlaceholderUITextView!
    @IBOutlet var customViews: [CustomView]!
    //speech object
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    var isRecording = false{
        didSet{
            if isRecording{
                view.endEditing(true)
            }
        }
    }
    var option:launchOptions = .describe
    var serviceSelected = [String]()
    var message = SMTPMessage()
    var focussesTextField : Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            
            
            switch authStatus {  //5
            case .authorized: break
                
            case .denied:
                print("User denied access to speech recognition")
                
            case .restricted:
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                print("Speech recognition not yet authorized")
            }
        }
    }
    func setDelegates(){
        firstNameField.delegate = self
        emailField.delegate = self
        phoneFIeld.delegate = self
        dateField.delegate = self
        addressField.textView.delegate = self
        for view in customViews{
            view.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setDelegates()
        switch option {
        case .describe:
            ShowDiscriptionPopUP()
        case .selectService:
            ShowServicePopUP()
        case .client:
            firstNameField.becomeFirstResponder()
        }
    }
    func ShowDiscriptionPopUP(){
        let popvc = (self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController)
        popvc.delegate = self
        self.addChild(popvc)
        
        popvc.view.frame = self.view.frame
        
        self.view.addSubview(popvc.view)
        
        popvc.didMove(toParent: self)
    }
    func ShowServicePopUP(){
        let servicePopvc = (self.storyboard?.instantiateViewController(withIdentifier: "ServicesPopUpViewController") as! ServicesPopUpViewController)
        servicePopvc.delegate = self
        servicePopvc.selectedData = serviceSelected
        self.addChild(servicePopvc)
        
        servicePopvc.view.frame = self.view.frame
        
        self.view.addSubview(servicePopvc.view)
        
        servicePopvc.didMove(toParent: self)
    }
    func unHideCustomViewWithTag(tag :Int , field:UITextField){
        if let view = customViews.filter({$0.tag == tag}).first
        {
            view.label.text = field.text
            view.isHidden = false
        }
    }
    func hideFocussedTextField(){
        if let textField = self.focussesTextField as? UITextField{
            if textField.text != "Listening..." && textField.text != ""{
                unHideCustomViewWithTag(tag: textField.tag - 100, field: textField)
            }else{
                textField.text = ""
            }
        }else if self.focussesTextField != nil{
            let placeholderTextField = self.focussesTextField as! PlaceholderUITextView
            if placeholderTextField.textView.text != "Listening..." && placeholderTextField.textView.text != ""{
                if let view = customViews.filter({$0.tag == placeholderTextField.tag - 100}).first
                {
                    view.label.text = placeholderTextField.textView.text
                    view.isHidden = false
                }
            }else{
                placeholderTextField.textView.text = ""
            }
        }
    }
    //FIXME: textField Management.
    @IBAction func fieldMicClicked(_ sender: UIButton) {
        switch sender.tag {
        case 100:
             if isRecording{
                if firstNameField == (focussesTextField as? UITextField){
                    if firstNameField.text == "Listening..."{
                        firstNameField.text = ""
                    }else if !(firstNameField.text?.isEmpty ?? true){
                        unHideCustomViewWithTag(tag: 1, field: firstNameField)
                    }
                    stopRecording()
                }else{
                    stopRecording()
                    hideFocussedTextField()
                }
            }else{
                startRecording(forTextField: firstNameField)
                isRecording = true
            }
        case 102:
            if isRecording{
                if emailField == (focussesTextField as? UITextField){
                    if emailField.text == "Listening..."{
                        emailField.text = ""
                    }else if !(emailField.text?.isEmpty ?? true){
                        unHideCustomViewWithTag(tag: 3, field: emailField)
                    }
                    stopRecording()
                }else{
                    stopRecording()
                    hideFocussedTextField()
                }
            }else{
                startRecording(forTextField: emailField)
                isRecording = true
            }
        case 103:
            if isRecording{
                if phoneFIeld == (focussesTextField as? UITextField){
                    if phoneFIeld.text == "Listening..."{
                        phoneFIeld.text = ""
                    }else if !(phoneFIeld.text?.isEmpty ?? true){
                        unHideCustomViewWithTag(tag: 4, field: phoneFIeld)
                    }
                    stopRecording()
                }else{
                    stopRecording()
                    hideFocussedTextField()
                }
            }else{
                startRecording(forTextField: phoneFIeld)
                isRecording = true
            }
        case 104:
            if isRecording{
                if dateField == (focussesTextField as? UITextField){
                    if dateField.text == "Listening..."{
                        dateField.text = ""
                    }else if !(dateField.text?.isEmpty ?? true){
                        unHideCustomViewWithTag(tag: 5, field: dateField)
                    }
                    stopRecording()
                }else{
                    stopRecording()
                    hideFocussedTextField()
                }
            }else{
                startRecording(forTextField: dateField)
                isRecording = true
            }
        case 105:
            if isRecording{
                if addressField == (focussesTextField as? PlaceholderUITextView){
                    if addressField.textView.text == "Listening..."{
                        addressField.textView.text = ""
                    }
                    stopRecording()
                }else{
                    stopRecording()
                    hideFocussedTextField()
                    isRecording = true
                }
                stopRecording()
            }else{
                startRecording(forTextField: addressField)
                isRecording = true
            }
            if addressField.textView.tag == 1999{
                if !(addressField.textView.hasText) {
                    addressField.labelPlaceholder?.isHidden = false
                }
                else {
                    addressField.labelPlaceholder?.isHidden = true
                }
            }
            
        default:
            print("tag incorrect",sender)
        }
        
    }
    func stopRecording(){
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
        recognitionRequest?.endAudio()
        isRecording = false
    }
    @IBAction func serviceButtonClicked(_ sender: Any) {
        ShowServicePopUP()
    }
    @IBAction func discriptionButtonClicked(_ sender: Any) {
        ShowDiscriptionPopUP()
    }
    @IBAction func send(_ sender: UIButton) {
        //validation.
        if !(servicesNameField.text?.isEmpty ?? true){
            if !(firstNameField.text?.isEmpty ?? true){
                if (!(emailField.text?.isEmpty ?? true)){
                    if (emailField.text?.isValidEmail() ?? false){
                        if !(phoneFIeld.text?.isEmpty ?? true) && (phoneFIeld.text!.count >= 10){
                            if !(dateField.text?.isEmpty ?? true){
                                if !discriptionField.textView.text.isEmpty{
                                    sendMail(sender: sender)
                                }else{
                                    discriptionField.shake()
                                }
                            }else{
                                dateField.shake()
                            }
                        }else{
                            phoneFIeld.shake()
                        }
                    }else{
                        emailField.shake()
                    }
                }else{
                    emailField.shake()
                }
            }else{
                firstNameField.shake()
            }
        }else{
            servicesNameField.shake()
        }
    }
    
    @IBAction func saveAndExit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.didSetOption = { withOption in
            self.option = withOption
        }
        self.navigationController?.pushViewController(vc, animated: false)
        clearAllField()
    }
    func clearAllField(){
        self.servicesNameField.text = ""
        self.firstNameField.text = ""
//        self.lastNameField.text = ""
        self.emailField.text = ""
        self.phoneFIeld.text = ""
        self.dateField.text = ""
        self.addressField.textView.text = ""
        self.discriptionField.textView.text = ""
        for view in customViews{
            view.label.text = ""
            view.isHidden = true
        }
        serviceSelected = []
    }
    func sendMail(sender:UIButton){
        message.from = fromMailId
        message.to = toMailId
        message.bccs = bccs
        message.host = "smtp.gmail.com"
        message.account = fromMailId
        message.pwd = fromPass
        message.subject = "Need Help!"
        message.content = "<html><body><p>Services : \(servicesNameField.text!)</br>Name : \(firstNameField.text!)\nEmail Id : \(emailField.text!)</br>Phone Number : \(phoneFIeld.text!)</br>Date : \(dateField.text!)</br>Address Field : \(addressField.textView.text!)</br>Description : \(discriptionField.textView.text!)</p></body></html>"
        sender.showSpinner()
        message.send({ message, now, total in
        }, success: { message in
            if let response = message?.response {
                print("response = \(String(data: response as Data, encoding: .utf8) ?? "")")
            }
            DispatchQueue.main.async {
                sender.hideSpinner()
                Alert.toast(title: "SUCCESS!", message: "We have recieved your message we will contact you soon.", vc: self, time: 2, CompletionHandler: {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    vc.didSetOption = { withOption in
                        self.option = withOption
                    }
                    self.navigationController?.pushViewController(vc, animated: false)
                    self.clearAllField()
                })
                
            }
        }, failure: { message, error in
            if let error = error {
                DispatchQueue.main.async {
                    sender.hideSpinner()
                    Alert.showBasic(title: "Unable to send", message: "Error occured!", vc: self, CompletionHandler: nil)
                    print("error = \(error)")
                }
            }
        })
        
    }
    
}
extension GetHelpViewController : PopUpViewDelegate,ServicesPopUpDelegate,UITextFieldDelegate,UITextViewDelegate,CustomViewDelegate,SFSpeechRecognizerDelegate{
    func buttonClicked(withTag: Int) {
        
        switch withTag {
        case 1:
            firstNameField.becomeFirstResponder()
//        case 2:
//            lastNameField.becomeFirstResponder()
        case 3:
            emailField.becomeFirstResponder()
        case 4:
            phoneFIeld.becomeFirstResponder()
        case 5:
            dateField.becomeFirstResponder()
        case 6:
            addressField.becomeFirstResponder()
        default:
            break
        }
    }
    
    func done(withText: String) {
        ShowServicePopUP()
        discriptionField.textView.text = withText
        if !discriptionField.textView.hasText {
            discriptionField.labelPlaceholder?.isHidden = false
        }
        else {
            discriptionField.labelPlaceholder?.isHidden = true
        }
    }
    func serviceDone(with: [String]) {
        serviceSelected = with
        var text = ""
        for service in with{
            if service == with.first || service == with.last{
                text += service
            }else{
                text += "," + service
            }
        }
        servicesNameField.text = text
        firstNameField.becomeFirstResponder()
    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        if textField.text == "Listening..."{
//            textField.text = ""
//        }
//        switch textField {
//        case firstNameField:
//            if !(firstNameField.text?.isEmpty ?? true){
//                if let view = customViews.filter({$0.tag == 1}).first
//                {
//                    view.label.text = firstNameField.text
//                    view.isHidden = false
//                }
//            }
//            emailField.becomeFirstResponder()
////        case lastNameField:
////            if !(lastNameField.text?.isEmpty ?? true){
////                if let view = customViews.filter({$0.tag == 2}).first
////                {
////                    view.label.text = lastNameField.text
////                    view.isHidden = false
////                }
////            }
////            emailField.becomeFirstResponder()
//        case emailField:
//            if !(emailField.text?.isEmpty ?? true){
//                if let view = customViews.filter({$0.tag == 3}).first
//                {
//                    view.label.text = emailField.text
//                    view.isHidden = false
//                }
//            }
//            phoneFIeld.becomeFirstResponder()
//        case phoneFIeld:
//            if !(phoneFIeld.text?.isEmpty ?? true){
//                if let formatedNumber = format(phoneNumber: phoneFIeld.text!){
//                    phoneFIeld.text = formatedNumber
//                }
//                if let view = customViews.filter({$0.tag == 4}).first
//                {
//                    view.label.text = phoneFIeld.text
//                    view.isHidden = false
//                }
//            }
//            dateField.becomeFirstResponder()
//        case dateField:
//            if !(dateField.text?.isEmpty ?? true){
//                if let view = customViews.filter({$0.tag == 5}).first
//                {
//                    view.label.text = dateField.text
//                    view.isHidden = false
//                }
//            }
//            addressField.becomeFirstResponder()
//        default:
//            break
//        }
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if !textView.text.isEmpty{
//            if let view = customViews.filter({$0.tag == 6}).first
//            {
//                view.label.text = addressField.textView.text
//                view.isHidden = false
//            }
//        }
//    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 1999{
            if !textView.hasText {
                addressField.labelPlaceholder?.isHidden = false
            }
            else {
                addressField.labelPlaceholder?.isHidden = true
            }
        }
        
    }
    
    func startRecording(forTextField textField:UITextField) {
        stopRecording()
        focussesTextField = textField
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: [])
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            switch textField{
            case self.phoneFIeld:
                if result != nil {
                    let text = result?.bestTranscription.formattedString
                    if let formattedText = format(phoneNumber: text!){
                        textField.text = formattedText
                    }else{
                        textField.text = text
                    }
                    isFinal = (result?.isFinal)!
                }
            case self.emailField:
                if let text = result?.bestTranscription.formattedString{
                    var tempText = text
                    tempText = tempText.replacingOccurrences(of: "Add", with: "@")
                    tempText = tempText.replacingOccurrences(of: "At the rate", with: "@")
                    tempText = tempText.replacingOccurrences(of: " ", with: "")
                    textField.text = tempText
                }
                
            default:
                if result != nil {
                    
                    textField.text = result?.bestTranscription.formattedString
                    isFinal = (result?.isFinal)!
                }
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        textField.text = "Listening..."
    }
    func startRecording(forTextField textField:PlaceholderUITextView) {
        stopRecording()
        focussesTextField = textField
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: [])
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                textField.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        })

        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        textField.textView.text = "Listening..."
    }
}
