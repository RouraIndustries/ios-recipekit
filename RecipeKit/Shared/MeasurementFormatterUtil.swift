//
//  MeasurementFormatterUtil.swift
//  RecipeKit
//
//  Created by Christopher J. Roura on 5/4/24.
//

import SwiftUI

struct MeasurementFormatterUtil {
    static func formatMeasurement(from quantity: Double? = nil, unit: String? = nil, metricQuantity: Double? = nil, metricUnit: String? = nil) -> String {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .medium

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        formatter.numberFormatter = numberFormatter

        var measurementQuantity: Double = 0
        var measurementUnit: String = ""

        if UserDefaults.standard.bool(forKey: "isUsingMetricUnits") {
            measurementQuantity = metricQuantity ?? 0
            measurementUnit = metricUnit ?? ""
        } else {
            measurementQuantity = quantity ?? 0
            measurementUnit = unit ?? ""
        }

        guard let unitIdentifier = measurementUnit.unitIdentifier else {
            return measurementQuantity > 0 ? "\(measurementQuantity)" : ""
        }

        let measurement = Measurement(value: measurementQuantity, unit: UnitConverterUtil.unit(from: unitIdentifier))
        return formatter.string(from: measurement)
    }
}
