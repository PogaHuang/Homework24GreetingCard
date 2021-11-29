//
//  ViewController.swift
//  Homework24GreetingCard
//
//  Created by 黃柏嘉 on 2021/11/29.
//

import UIKit
enum SetMode:Int{
    case style
    case greetingCardAppearance
    case greetingCardBackgroundColor
}
enum StyleMode:Int{
    case birthdayCard
    case valentineCard
    case XmasCard
}
enum ResetMode{
    case allReset
    case endSet
}

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //setMode
    @IBOutlet weak var setModeScrollView: UIScrollView!
    @IBOutlet weak var setModeSegmentedControl: UISegmentedControl!
    //greetingCardStyle
    @IBOutlet weak var styleSegmentedControl: UISegmentedControl!
    @IBOutlet weak var styleBackView: UIView!
    //birthday
    @IBOutlet weak var birthdayCardView: UIView!
    @IBOutlet weak var birthdayTitleLabel: UILabel!
    @IBOutlet weak var birthdayContentLabel: UILabel!
    //valentine
    @IBOutlet var valentineCardView: UIView!
    @IBOutlet weak var valentineTitleLabel: UILabel!
    @IBOutlet weak var valentineContentLabel: UILabel!
    //Xmas
    @IBOutlet var XmasCardView: UIView!
    @IBOutlet weak var XmasTitleLabel: UILabel!
    @IBOutlet weak var XmasContentLabel: UILabel!
    //IBOutletCollection
    @IBOutlet var textFiledArray: [UITextField]!
    @IBOutlet var sliderArray: [UISlider]!
    @IBOutlet var switchArray: [UISwitch]!
    //greetingCardText
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleCountLabel: UILabel!
    @IBOutlet weak var contentCountLabel: UILabel!
    @IBOutlet weak var titleFontSizeLabel: UILabel!
    @IBOutlet weak var contentFontSizeLabel: UILabel!
    //greetingCardAppearance
    //cornerRadius & borderWidth
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    @IBOutlet weak var cornerRadiusLabel: UILabel!
    @IBOutlet weak var borderwidthSlider: UISlider!
    @IBOutlet weak var borderwidthLabel: UILabel!
    //colorSlider
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var alphaLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setModeScrollView.delegate = self
        styleBackView.addSubview(birthdayCardView)
    }
    
    //切換設定頁面
    @IBAction func changeSetMode(_ sender: UISegmentedControl) {
        let selectIndex = SetMode(rawValue: sender.selectedSegmentIndex)
        switch selectIndex {
        case .style:
            setModeScrollView.contentOffset.x = 0
        case .greetingCardAppearance:
            setModeScrollView.contentOffset.x = 374
        case .greetingCardBackgroundColor:
            setModeScrollView.contentOffset.x = 748
        default:
            return
        }
    }
    
//選單第一頁
    //切換卡片樣式
    //用enum的rawValue帶入segmented的Index去取得目前選擇的卡片種類，然後移除目前的小卡加入新選擇的小卡
    @IBAction func changeGreetingCardStyle(_ sender: UISegmentedControl) {
        let selectIndex = StyleMode(rawValue: sender.selectedSegmentIndex)
        let styleBackSubviews = styleBackView.subviews
        styleBackSubviews[0].removeFromSuperview()
        switch selectIndex {
        case .birthdayCard:
            styleBackView.addSubview(birthdayCardView)
        case .valentineCard:
            styleBackView.addSubview(valentineCardView)
        case .XmasCard:
            styleBackView.addSubview(XmasCardView)
        default:
            return
        }
        
    }
    //顯示字數
    //每當textField編輯只要有改變都會觸發，然後用count獲得字數
    @IBAction func showWordsCount(_ sender: UITextField) {
        let titleCount = titleTextField.text?.count
        let contentCount = contentTextField.text?.count
        if let titleCount = titleCount,let contentCount = contentCount{
            titleCountLabel.text = String(titleCount) + "字"
            contentCountLabel.text = String(contentCount) + "字"
        }
    }
    //變更字體大小
    //用enum的rawValue帶入segmented的Index去取得目前選擇的卡片種類，然後使用我們自己寫好的方法帶入參數，只要滑動slider就能改變目前小卡的Label的字體
    @IBAction func changeFontSize(_ sender: UISlider) {
        let currentCard = StyleMode(rawValue: styleSegmentedControl.selectedSegmentIndex)
        switch currentCard {
        case .birthdayCard:
            checkSliderTag(slider: sender, tag: sender.tag, title: birthdayTitleLabel, content: birthdayContentLabel)
        case .valentineCard:
            checkSliderTag(slider: sender, tag: sender.tag, title: valentineTitleLabel, content: valentineContentLabel)
        case .XmasCard:
            checkSliderTag(slider: sender, tag: sender.tag, title: XmasTitleLabel, content: XmasContentLabel)
        default:
            return
        }
    }
    //辨別滑桿執行
    func checkSliderTag(slider:UISlider,tag:Int,title:UILabel,content:UILabel){
        if tag == 0{
            title.font = title.font.withSize(CGFloat(slider.value))
            titleFontSizeLabel.text = String(Int(slider.value)) + "級"
        }else{
            content.font = content.font.withSize(CGFloat(slider.value))
            contentFontSizeLabel.text = String(Int(slider.value)) + "級"
        }
    }
    //變更卡片文字
    //按下按鈕後讓textField的字出現在小卡的Label
    @IBAction func setGreetCard(_ sender: UIButton) {
        let currentCard = StyleMode(rawValue: styleSegmentedControl.selectedSegmentIndex)
        switch currentCard {
        case .birthdayCard:
            birthdayTitleLabel.text = titleTextField.text
            birthdayContentLabel.text = contentTextField.text
        case .valentineCard:
            valentineTitleLabel.text = titleTextField.text
            valentineContentLabel.text = contentTextField.text
        case .XmasCard:
            XmasTitleLabel.text = titleTextField.text
            XmasContentLabel.text = contentTextField.text
        default:
            return
        }
        reset(mode: .endSet)
    }
   
    //收鍵盤
    @IBAction func closeKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
//選單第二頁
    //設定卡片外觀
    //得到當前的小卡種類然後用switch作流程控制，使用我們寫好的方法把只需要填入目前的view
    @IBAction func setGreetingCardAppearance(_ sender: UISlider) {
        let currentCard = StyleMode(rawValue: styleSegmentedControl.selectedSegmentIndex)
        switch currentCard {
        case .birthdayCard:
            slideToSetAppearance(view: birthdayCardView)
        case .valentineCard:
            slideToSetAppearance(view: valentineCardView)
        case .XmasCard:
            slideToSetAppearance(view: XmasCardView)
        default:
            return
        }
        
    }
    func slideToSetAppearance(view:UIView){
        view.layer.cornerRadius = CGFloat(cornerRadiusSlider.value)
        cornerRadiusLabel.text = String(Int(cornerRadiusSlider.value))
        view.layer.borderWidth = CGFloat(borderwidthSlider.value)
        borderwidthLabel.text = String(Int(borderwidthSlider.value))
    }
    
    
   //鎖定外觀滑桿
    @IBAction func appearanceSwitch(_ sender: UISwitch) {
        if sender.tag == 0{
            if sender.isOn == false{
                cornerRadiusSlider.isEnabled = true
            }else{
                cornerRadiusSlider.isEnabled = false
            }
        }else if sender.tag == 1{
            if sender.isOn == false{
                borderwidthSlider.isEnabled = true
            }else{
                borderwidthSlider.isEnabled = false
            }
        }
    }
//選單第三頁
    //鎖定顏色滑桿
    @IBAction func colorSwitch(_ sender: UISwitch) {
        switch sender.tag{
        case 2:
            sliderSwitch(colorSwitch: sender, colorSlider: redSlider)
        case 3:
            sliderSwitch(colorSwitch: sender, colorSlider: greenSlider)
        case 4:
            sliderSwitch(colorSwitch: sender, colorSlider: blueSlider)
        case 5:
            sliderSwitch(colorSwitch: sender, colorSlider: alphaSlider)
        default:
            return
        }
    }
    func sliderSwitch(colorSwitch:UISwitch,colorSlider:UISlider){
        if colorSwitch.isOn == false{
            colorSlider.isEnabled = true
        }else{
            colorSlider.isEnabled = false
        }
    }
    //調整卡片顏色
    //三個顏色的slider都連進這個IBAction，然後辨別目前的小卡使用下方自己寫好的方法帶入目前的小卡種類，用slider的value改變RGB，滑動就能改變顏色
    @IBAction func changeCardBackgrounColor(_ sender: UISlider) {
        let currentCard = StyleMode(rawValue: styleSegmentedControl.selectedSegmentIndex)
        switch currentCard {
        case .birthdayCard:
            setColor(view: birthdayCardView)
        case .valentineCard:
            setColor(view: valentineCardView)
        case .XmasCard:
            setColor(view: XmasCardView)
        default:
            return
        }
        
    }
    func setColor(view:UIView){
        view.backgroundColor = UIColor(red: CGFloat(redSlider.value/255), green: CGFloat(greenSlider.value/255), blue: CGFloat(blueSlider.value/255), alpha: CGFloat(alphaSlider.value/1))
        redLabel.text = String(Int(redSlider.value))
        greenLabel.text = String(Int(greenSlider.value))
        blueLabel.text = String(Int(blueSlider.value))
        alphaLabel.text = String(format: "%.1f", alphaSlider.value)
        
    }

    //重設
    @IBAction func resetGreetingCard(_ sender: UIButton) {
        reset(mode: .allReset)
    }
    //重設
    func reset(mode:ResetMode){
        let titleLabelArray = [birthdayTitleLabel,valentineTitleLabel,XmasTitleLabel]
        let contentLabelArray = [birthdayContentLabel,valentineContentLabel,XmasContentLabel]
        let colorLabelArray = [redLabel,greenLabel,blueLabel,alphaLabel]
        let viewArray = [birthdayCardView,valentineCardView,XmasCardView]
        titleCountLabel.text = "0字"
        contentCountLabel.text = "0字"
        titleFontSizeLabel.text = "25級"
        contentFontSizeLabel.text = "17級"
        cornerRadiusLabel.text = "0"
        borderwidthLabel.text = "0"
        for i in textFiledArray{
            i.text = ""
        }
        for i in sliderArray{
            i.value = 0
        }
        for i in switchArray{
            i.isOn = false
        }
        for i in colorLabelArray{
            i?.text = "0"
        }
        alphaSlider.value = 1
        alphaLabel.text = "1"
        if mode == .allReset{
            setModeSegmentedControl.selectedSegmentIndex = 0
            styleSegmentedControl.selectedSegmentIndex = 0
            styleBackView.subviews[0].removeFromSuperview()
            styleBackView.addSubview(birthdayCardView)
            for i in titleLabelArray{
                i?.text = "Title"
                i?.font = i?.font.withSize(25)
            }
            for i in contentLabelArray{
                i?.text = "Content"
                i?.font = i?.font.withSize(17)
            }
            for i in viewArray{
                i?.layer.cornerRadius = 0
                i?.layer.borderWidth = 0
            }
            birthdayCardView.backgroundColor = .systemYellow
            valentineCardView.backgroundColor = .systemPink
            XmasCardView.backgroundColor = .red
        }
    }
}

