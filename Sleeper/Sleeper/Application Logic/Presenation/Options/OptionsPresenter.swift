//
//  OptionsPresenter.swift
//  Sleeper
//
//  Created by user on 18.08.2020.
//  Copyright © 2020 vpoltave. All rights reserved.
//

import Foundation

protocol OptionsViewProtocol: class, NavigationInitializable, TableViewInitializable {
    
}

final class OptionsPresenter {
    
    private unowned let view: OptionsViewProtocol
    private let coordinator: Coordinator
    private(set) var options: [OptionModel]
    private var optionChosen: ((OptionModel) -> Void)?
    
    
    init(view: OptionsViewProtocol,
         coordinator: Coordinator,
         options: [OptionModel],
         optionChosen: ((OptionModel) -> Void)?) {
        
        self.view = view
        self.coordinator = coordinator
        self.options = options
        self.optionChosen = optionChosen
    }
    
    func viewDidLoad() {
        view.initNavigation()
        view.initTableView()
    }
    
    func userDidSelect(at indexPath: IndexPath) {
        let option = options[indexPath.row]
        optionChosen?(option)
        closePressed()
    }
    
    func closePressed() {
        coordinator.router.dismissViewController(animated: true)
    }
}
