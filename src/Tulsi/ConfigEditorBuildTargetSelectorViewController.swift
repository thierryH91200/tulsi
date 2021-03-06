// Copyright 2016 The Tulsi Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Cocoa


/// View controller allowing certain Bazel build targets from the project to be selected for Xcode
/// project generation.
final class ConfigEditorBuildTargetSelectorViewController: NSViewController, WizardSubviewProtocol {
  // This list needs to be kept up to date with whatever Bazel supports and determines the set of
  // user-selectable target types displayed in the Tulsi UI.
  // This filter does not limit Tulsi from generating targets for other types, however. Notably,
  // since watchos_applications are tightly bound to their host binary, Tulsi automatically
  // generates all targets referenced in an ios_application's "extensions" attribute rather than
  // risk the user accidentally selecting the extension without the host. For this reason,
  // ios_extension and watchos_extension are omitted as well.
  static let filteredFileTypes = [
      "apple_unit_test",
      "apple_ui_test",
      "cc_binary",
      "cc_library",
      "objc_binary",  // TODO(abaire): Remove when app-related attributes are removed from Bazel.
      "objc_library",
      "ios_application",
      "ios_framework",
      "ios_legacy_test",
      "ios_test",
      "macos_application",
      "macos_extension",
      "macos_command_line_application",
      "swift_library",
      "test_suite",
      "tvos_application",
  ]

  @IBOutlet weak var buildTargetTable: NSTableView!

  dynamic let typeFilter: NSPredicate? = NSPredicate.init(format: "(SELF.type IN %@) OR (SELF.selected == TRUE)",
                                                          argumentArray: [filteredFileTypes])

  var selectedRuleInfoCount: Int = 0 {
    didSet {
      presentingWizardViewController?.setNextButtonEnabled(selectedRuleInfoCount > 0)
    }
  }

  override var representedObject: Any? {
    didSet {
      unbind("selectedRuleInfoCount")
      guard let document = representedObject as? TulsiGeneratorConfigDocument else { return }
      bind("selectedRuleInfoCount",
           to: document,
           withKeyPath: "selectedRuleInfoCount",
           options: nil)
    }
  }

  deinit {
    unbind("selectedRuleInfoCount")
  }

  override func loadView() {
    super.loadView()

    let typeColumn = buildTargetTable.tableColumn(withIdentifier: "Type")!
    let labelColumn = buildTargetTable.tableColumn(withIdentifier: "Label")!
    buildTargetTable.sortDescriptors = [typeColumn.sortDescriptorPrototype!,
                                        labelColumn.sortDescriptorPrototype!]
  }

  // MARK: - WizardSubviewProtocol

  weak var presentingWizardViewController: ConfigEditorWizardViewController? = nil {
    didSet {
      presentingWizardViewController?.setNextButtonEnabled(selectedRuleInfoCount > 0)
    }
  }

  func wizardSubviewDidDeactivate() {
    unbind("selectedRuleInfoCount")
  }
}
