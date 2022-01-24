//
//  ExchangeRateCalculatorViewController.swift
//  ExchangeRate
//
//  Created by 박형석 on 2022/01/24.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

class ExchangeRateCalculatorViewController: BaseViewController, View {
    
    // title
    private let titleLabel = UILabel().then {
        $0.text = "환율 계산"
        $0.font = UIFont.systemFont(ofSize: 40)
        $0.textAlignment = .center
    }
    
    // remit
    private let remitCountryLabel = UILabel().then {
        $0.text = "송금국가 : "
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    private let selectedRemitCountry = UILabel().then {
        $0.text = "미국(USD)"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    // receipt
    private let receiptCountryLabel = UILabel().then {
        $0.text = "수취국가 : "
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    private let receiptCountrySelectButton = UIButton().then {
        $0.setTitle("한국(KRW)", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemGray
        $0.layer.cornerRadius = 8
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 15)
        $0.snp.makeConstraints { make in
            make.height.equalTo(20.5)
            make.width.equalTo(100)
        }
    }
    
    private let receiptCountryPickerView = UIPickerView().then {
        $0.backgroundColor = .clear
    }
    
    // exchange rate
    private let exchangeRateLabel = UILabel().then {
        $0.text = "환율 : "
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    private let currentExchangeRate = UILabel().then {
        $0.text = "1,130.05 KRW / USD"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    // search time
    private let searchTimeLabel = UILabel().then {
        $0.text = "조회시간 : "
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    private let recentSearchTime = UILabel().then {
        $0.text = "2019-03-20 16:13"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    // remittance
    private let remittanceLabel = UILabel().then {
        $0.text = "송금액 : "
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    private let remittanceTextField = UITextField().then {
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.borderStyle = .line
        $0.keyboardType = .numberPad
        $0.addDoneButtonOnKeyboard()
        $0.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(100)
        }
    }
    
    private let currencyLabel = UILabel().then {
        $0.text = "USD"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    // calculations
    private let calculationsLabel = UILabel().then {
        $0.text = "수취금액은 113,004.98 KRW 입니다"
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textAlignment = .center
    }


    override func viewDidLoad() {
        super.viewDidLoad()

    }
   
    override func makeConstraints() {
        super.makeConstraints()
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        
        let verticalLabelStackView = UIStackView(
            arrangedSubviews: [
                self.remitCountryLabel,
                self.receiptCountryLabel,
                self.exchangeRateLabel,
                self.searchTimeLabel,
                self.remittanceLabel
            ])
            .then {
                $0.spacing = 10
                $0.distribution = .fillEqually
                $0.axis = .vertical
                $0.alignment = .trailing
            }
        
        let remittanceHorizontalStackView = UIStackView(
            arrangedSubviews: [
                self.remittanceTextField,
                self.currencyLabel
            ]).then {
                $0.spacing = 5
                $0.distribution = .fill
                $0.axis = .horizontal
                $0.alignment = .leading
            }
        
        let verticalResultStackView = UIStackView(
            arrangedSubviews: [
                self.selectedRemitCountry,
                self.receiptCountrySelectButton,
                self.currentExchangeRate,
                self.recentSearchTime,
                remittanceHorizontalStackView
            ])
            .then {
                $0.spacing = 10
                $0.distribution = .fillEqually
                $0.axis = .vertical
                $0.alignment = .leading
            }
        
        let wholeStackView = UIStackView(
            arrangedSubviews: [
                verticalLabelStackView,
                verticalResultStackView
            ])
            .then {
                $0.spacing = 5
                $0.distribution = .fill
                $0.axis = .horizontal
                $0.alignment = .leading
            }
        
        self.view.addSubview(wholeStackView)
        wholeStackView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        
        self.view.addSubview(self.calculationsLabel)
        self.calculationsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(wholeStackView.snp.bottom).offset(90)
        }
        
    }
    
    func bind(reactor: ExchangeRateCalculatorReactor) {
        receiptCountrySelectButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                print("receiptCountrySelectButton tapped")
            }
            .disposed(by: disposeBag)
        
        remittanceTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .withUnretained(self)
            .bind { owner, text in
                print(text)
            }
            .disposed(by: disposeBag)
    }

}
