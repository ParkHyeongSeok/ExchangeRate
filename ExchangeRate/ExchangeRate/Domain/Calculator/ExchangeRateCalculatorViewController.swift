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
    
    private let dummyTextField = UITextField(frame: .zero).then {
        $0.addDoneButtonOnKeyboard()
    }
    
    private let receiptCountryPickerView = UIPickerView().then {
        $0.backgroundColor = .systemBackground
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
    
    private var loadingIndicator = UIActivityIndicatorView().then {
        $0.hidesWhenStopped = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingPickerView()
    }
    
    func bind(reactor: ExchangeRateCalculatorReactor) {
        
        reactor.state
            .map { $0.isLoading }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        Observable.zip(
            reactor.state
                .map { $0.exchangeRate }
                .map { $0.formattingToString },
            reactor.state
                .map { $0.receiptCountry }
                .map { $0.currencyUnit })
            .map { "\($0) \($1) / USD" }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: currentExchangeRate.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(
            reactor.state
                .map { $0.calculations },
            reactor.state
                .map { $0.receiptCountry })
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .bind(onNext: { owner, result in
                owner.showResult(result.0, country: result.1)
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.recentSearchTime }
            .map { $0.formattingToString }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: recentSearchTime.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.receiptCountry }
            .map { $0.rawValue }
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: receiptCountrySelectButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        receiptCountrySelectButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.dummyTextField.becomeFirstResponder()
            }
            .disposed(by: disposeBag)
        
        remittanceTextField.rx.text.orEmpty
            .distinctUntilChanged()
            .compactMap { Double($0) }
            .map { .inputRemittance($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        receiptCountryPickerView.rx.itemSelected
            .map { ReceiptCountry.allCases[$0.0] }
            .map { .changeReceiptCountry($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
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
        
        let exchangeRateHorizontalStackView = UIStackView(
            arrangedSubviews: [
                self.currentExchangeRate,
                self.loadingIndicator
            ]).then {
                $0.spacing = 5
                $0.distribution = .fill
                $0.axis = .horizontal
                $0.alignment = .leading
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
                exchangeRateHorizontalStackView,
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
        
        view.addSubview(self.dummyTextField)
        self.dummyTextField.inputView = self.receiptCountryPickerView
    }
    
    private func settingPickerView() {
        Observable.of(ReceiptCountry.allCases.map { $0.rawValue })
            .bind(to: self.receiptCountryPickerView.rx.itemTitles) { row, item in
                return item
            }
            .disposed(by: disposeBag)
    }
    
    private func showResult(_ calculations: Double, country: ReceiptCountry) {
        if calculations < 0 || calculations > 10000 {
            self.calculationsLabel.textColor = .red
            self.calculationsLabel.text = "송금액이 바르지 않습니다"
        } else {
            self.calculationsLabel.textColor = .black
            self.calculationsLabel.text = "수취금액은 \(calculations.formattingToString) \(country.currencyUnit) 입니다."
        }
    }
    
}
