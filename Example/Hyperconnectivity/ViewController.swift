//
//  ViewController.swift
//  Hyperconnectivity
//
//  Created by Ross Butler on 05/07/2020.
//  Copyright (c) 2020 Ross Butler. All rights reserved.
//

import Combine
import UIKit
import Hyperconnectivity

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var notifierButton: UIButton!
    @IBOutlet var statusLabel: UILabel!

    // MARK: Status
    private var cancellable: AnyCancellable?
    fileprivate var isCheckingConnectivity: Bool = false
}

extension ViewController {
    @IBAction func notifierButtonTapped(_: UIButton) {
        isCheckingConnectivity ? stopConnectivityChecks() : startConnectivityChecks()
    }
}

private extension ViewController {
    func startConnectivityChecks() {
        activityIndicator.startAnimating()
        let publisher = Hyperconnectivity.Publisher()
        cancellable = publisher.receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.activityIndicator.stopAnimating()
                strongSelf.isCheckingConnectivity = false
                strongSelf.updateNotifierButton(isCheckingConnectivity: strongSelf.isCheckingConnectivity)
            }, receiveValue: { [weak self] connectivityResult in
                self?.updateConnectionStatus(connectivityResult)
        })
        isCheckingConnectivity = true
        updateNotifierButton(isCheckingConnectivity: isCheckingConnectivity)
    }

    func stopConnectivityChecks() {
        activityIndicator.stopAnimating()
        cancellable?.cancel()
        isCheckingConnectivity = false
        updateNotifierButton(isCheckingConnectivity: isCheckingConnectivity)
    }

    func updateConnectionStatus(_ result: ConnectivityResult) {
        statusLabel.textColor = result.isConnected ? .darkGreen : .red
        statusLabel.text = result.state.description
    }

    func updateNotifierButton(isCheckingConnectivity: Bool) {
        let buttonText = isCheckingConnectivity ? "Stop notifier" : "Start notifier"
        let buttonTextColor = isCheckingConnectivity ? UIColor.red : UIColor.darkGreen
        notifierButton.setTitle(buttonText, for: .normal)
        notifierButton.setTitleColor(buttonTextColor, for: .normal)
    }
}
