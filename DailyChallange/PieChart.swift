//
//  PieChart.swift
//  DailyChallange
//
//  Created by Daniele Donia on 18/07/22.
//
import SwiftUI
import Charts

struct PieChart: UIViewRepresentable {

    var total: Int
    var entries: [PieChartDataEntry]
    @Binding var category: ChallengeData.Category
    let pieChart = PieChartView()
    func makeUIView(context: Context) -> PieChartView {
        pieChart.delegate = context.coordinator
        return pieChart
    }
    func updateUIView(_ uiView: PieChartView, context: Context) {
        let dataSet = PieChartDataSet(entries: entries)
        dataSet.colors = [ChartColorTemplates.colorFromString("#0096FF"), ChartColorTemplates.colorFromString("#B6D0E2")]
        let pieChartData = PieChartData(dataSet: dataSet)
        uiView.data = pieChartData
        configureChart(uiView)
        formatCenter(uiView)
        formatDescription(uiView.chartDescription)
        formatLegend(uiView.legend)
        formatDataSet(dataSet)
        uiView.notifyDataSetChanged()
    }

    class Coordinator: NSObject, ChartViewDelegate {
        var parent: PieChart
        init(parent: PieChart) {
            self.parent = parent
        }
        func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
            let labelText = entry.value(forKey: "label")! as! String
            let num = Int(entry.value(forKey: "value")! as! Double)
            parent.pieChart.centerText = """
                \(labelText)
                \(num)
                """
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func configureChart( _ pieChart: PieChartView) {
        pieChart.rotationEnabled = false
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.drawEntryLabelsEnabled = false
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
    }

    func formatCenter(_ pieChart: PieChartView) {
        pieChart.holeColor = UIColor.systemBackground
        pieChart.centerText = "\(total) challenges"
        pieChart.centerTextRadiusPercent = 0.95
    }

    func formatDescription( _ description: Description) {
        description.text = category.rawValue.capitalized
        description.font = UIFont.boldSystemFont(ofSize: 17)
    }

    func formatLegend(_ legend: Legend) {
        legend.enabled = false
    }

    func formatDataSet(_ dataSet: ChartDataSet) {
        dataSet.drawValuesEnabled = false
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart(total:100, entries: ChallengeData.entriesForChallenges(ChallengeData.allChallenges, category: .calories),
                 category: .constant(.calories))
            .frame(height: 400)
            .padding()    }
}
