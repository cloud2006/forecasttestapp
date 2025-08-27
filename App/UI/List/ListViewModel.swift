//
//  ListViewModel.swift
//  App
//
//

import Global
import GlobalUI
import Combine

class ListViewModel {
    @Inject var service: ForecastService
    private var bag = Set<AnyCancellable>()

    var datas = CurrentValueSubject<[TableViewSection], Never>([])

    var showDetail: ((ForecastItem) -> Void)?

    var title: String = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String

    init() {
        service.items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.createSection($0) }
            .store(in: &bag)
    }

    private func createSection(_ items: ForecastItems) {
        let datas: [TableViewData] = items.map { item in
            ListCellData(forecast: item)
                .set(trailingActions: [self.trailingAction(item: item)])
                .set(separator: .full)
                .set(separatorColor: .lightGray)
                .did(select: { [weak self] _ in
                    self?.showDetail?(item)
                })

        }
        self.datas.send([TableViewSection(identifier: "section",
                                          datas: datas)])
    }

    private func trailingAction(item: ForecastItem) -> TableViewContextualAction {
        return TableViewContextualAction(
            title: "Delete",
            style: .destructive,
            backgroundColor: .red,
            action: { [weak self] _ in
                self?.delete(item)
        })
    }

    private func delete(_ item: ForecastItem) {
        var current = service.items.value
        //It's better make ForecastItem as Equatable but for test task I will use this simplified approach
        current.removeAll { $0.day == item.day && $0.description == item.description }

        service.items.send(current)
    }
}
