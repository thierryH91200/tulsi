// Copyright 2017 The Tulsi Authors. All rights reserved.
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

let bazelBuildSettingsFeatures = [
  // TODO(b/67857886): Remove after this feature has been tested.
  "TULSI_COLLECT_DSYM",
  // TODO(b/69180212): Remove when all issues around this flag are resolved after release.
  "TULSI_BAZEL_EXECROOT",
  // TODO(b/69180247): Remove when all issues around this flag are resolved after release.
  "TULSI_DEBUG_PREFIX_MAP",
  // TODO(b/69552312): Remove if this feature causes no issues for four weeks after release.
  "TULSI_QUEUE_BUILDS",
]
