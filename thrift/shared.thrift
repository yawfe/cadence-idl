// Copyright (c) 2017 Uber Technologies, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

namespace java com.uber.cadence

exception BadRequestError {
  1: required string message
}

exception InternalServiceError {
  1: required string message
}

exception InternalDataInconsistencyError {
  1: required string message
}

exception DomainAlreadyExistsError {
  1: required string message
}

exception WorkflowExecutionAlreadyStartedError {
  10: optional string message
  20: optional string startRequestId
  30: optional string runId
}

exception WorkflowExecutionAlreadyCompletedError {
  1: required string message
}

exception EntityNotExistsError {
  1: required string message
  2: optional string currentCluster
  3: optional string activeCluster
  // activeClusters is a list of active clusters for active-active domain
  4: required list<string> activeClusters
}

exception ServiceBusyError {
  1: required string message
  2: optional string reason
}

exception CancellationAlreadyRequestedError {
  1: required string message
}

exception QueryFailedError {
  1: required string message
}

exception DomainNotActiveError {
  1: required string message
  2: required string domainName
  3: required string currentCluster
  4: required string activeCluster
  // activeClusters is a list of active clusters for active-active domain
  5: required list<string> activeClusters
}

exception LimitExceededError {
  1: required string message
}

exception AccessDeniedError {
  1: required string message
}

exception RetryTaskV2Error {
  1: required string message
  2: optional string domainId
  3: optional string workflowId
  4: optional string runId
  5: optional i64 (js.type = "Long") startEventId
  6: optional i64 (js.type = "Long") startEventVersion
  7: optional i64 (js.type = "Long") endEventId
  8: optional i64 (js.type = "Long") endEventVersion
}

exception ClientVersionNotSupportedError {
  1: required string featureVersion
  2: required string clientImpl
  3: required string supportedVersions
}

exception FeatureNotEnabledError {
  1: required string featureFlag
}

exception CurrentBranchChangedError {
  10: required string message
  20: required binary currentBranchToken
}

exception RemoteSyncMatchedError {
  10: required string message
}

exception StickyWorkerUnavailableError {
  1: required string message
}

exception TaskListNotOwnedByHostError {
    1: required string ownedByIdentity
    2: required string myIdentity
    3: required string tasklistName
}

enum WorkflowIdReusePolicy {
  /*
   * allow start a workflow execution using the same workflow ID,
   * when workflow not running, and the last execution close state is in
   * [terminated, cancelled, timeouted, failed].
   */
  AllowDuplicateFailedOnly,
  /*
   * allow start a workflow execution using the same workflow ID,
   * when workflow not running.
   */
  AllowDuplicate,
  /*
   * do not allow start a workflow execution using the same workflow ID at all
   */
  RejectDuplicate,
  /*
   * if a workflow is running using the same workflow ID, terminate it and start a new one
   */
  TerminateIfRunning,
}

enum DomainStatus {
  REGISTERED,
  DEPRECATED,
  DELETED,
}

enum TimeoutType {
  START_TO_CLOSE,
  SCHEDULE_TO_START,
  SCHEDULE_TO_CLOSE,
  HEARTBEAT,
}

enum ParentClosePolicy {
	ABANDON,
	REQUEST_CANCEL,
	TERMINATE,
}


// whenever this list of decision is changed
// do change the mutableStateBuilder.go
// function shouldBufferEvent
// to make sure wo do the correct event ordering
enum DecisionType {
  ScheduleActivityTask,
  RequestCancelActivityTask,
  StartTimer,
  CompleteWorkflowExecution,
  FailWorkflowExecution,
  CancelTimer,
  CancelWorkflowExecution,
  RequestCancelExternalWorkflowExecution,
  RecordMarker,
  ContinueAsNewWorkflowExecution,
  StartChildWorkflowExecution,
  SignalExternalWorkflowExecution,
  UpsertWorkflowSearchAttributes,
}

enum EventType {
  WorkflowExecutionStarted,
  WorkflowExecutionCompleted,
  WorkflowExecutionFailed,
  WorkflowExecutionTimedOut,
  DecisionTaskScheduled,
  DecisionTaskStarted,
  DecisionTaskCompleted,
  DecisionTaskTimedOut
  DecisionTaskFailed,
  ActivityTaskScheduled,
  ActivityTaskStarted,
  ActivityTaskCompleted,
  ActivityTaskFailed,
  ActivityTaskTimedOut,
  ActivityTaskCancelRequested,
  RequestCancelActivityTaskFailed,
  ActivityTaskCanceled,
  TimerStarted,
  TimerFired,
  CancelTimerFailed,
  TimerCanceled,
  WorkflowExecutionCancelRequested,
  WorkflowExecutionCanceled,
  RequestCancelExternalWorkflowExecutionInitiated,
  RequestCancelExternalWorkflowExecutionFailed,
  ExternalWorkflowExecutionCancelRequested,
  MarkerRecorded,
  WorkflowExecutionSignaled,
  WorkflowExecutionTerminated,
  WorkflowExecutionContinuedAsNew,
  StartChildWorkflowExecutionInitiated,
  StartChildWorkflowExecutionFailed,
  ChildWorkflowExecutionStarted,
  ChildWorkflowExecutionCompleted,
  ChildWorkflowExecutionFailed,
  ChildWorkflowExecutionCanceled,
  ChildWorkflowExecutionTimedOut,
  ChildWorkflowExecutionTerminated,
  SignalExternalWorkflowExecutionInitiated,
  SignalExternalWorkflowExecutionFailed,
  ExternalWorkflowExecutionSignaled,
  UpsertWorkflowSearchAttributes,
}

enum DecisionTaskFailedCause {
  UNHANDLED_DECISION,
  BAD_SCHEDULE_ACTIVITY_ATTRIBUTES,
  BAD_REQUEST_CANCEL_ACTIVITY_ATTRIBUTES,
  BAD_START_TIMER_ATTRIBUTES,
  BAD_CANCEL_TIMER_ATTRIBUTES,
  BAD_RECORD_MARKER_ATTRIBUTES,
  BAD_COMPLETE_WORKFLOW_EXECUTION_ATTRIBUTES,
  BAD_FAIL_WORKFLOW_EXECUTION_ATTRIBUTES,
  BAD_CANCEL_WORKFLOW_EXECUTION_ATTRIBUTES,
  BAD_REQUEST_CANCEL_EXTERNAL_WORKFLOW_EXECUTION_ATTRIBUTES,
  BAD_CONTINUE_AS_NEW_ATTRIBUTES,
  START_TIMER_DUPLICATE_ID,
  RESET_STICKY_TASKLIST,
  WORKFLOW_WORKER_UNHANDLED_FAILURE,
  BAD_SIGNAL_WORKFLOW_EXECUTION_ATTRIBUTES,
  BAD_START_CHILD_EXECUTION_ATTRIBUTES,
  FORCE_CLOSE_DECISION,
  FAILOVER_CLOSE_DECISION,
  BAD_SIGNAL_INPUT_SIZE,
  RESET_WORKFLOW,
  BAD_BINARY,
  SCHEDULE_ACTIVITY_DUPLICATE_ID,
  BAD_SEARCH_ATTRIBUTES,
}

enum DecisionTaskTimedOutCause {
  TIMEOUT,
  RESET,
}

enum CancelExternalWorkflowExecutionFailedCause {
  UNKNOWN_EXTERNAL_WORKFLOW_EXECUTION,
  WORKFLOW_ALREADY_COMPLETED,
}

enum SignalExternalWorkflowExecutionFailedCause {
  UNKNOWN_EXTERNAL_WORKFLOW_EXECUTION,
  WORKFLOW_ALREADY_COMPLETED,
}

enum ChildWorkflowExecutionFailedCause {
  WORKFLOW_ALREADY_RUNNING,
}

// TODO: when migrating to gRPC, add a running / none status,
//  currently, customer is using null / nil as an indication
//  that workflow is still running
enum WorkflowExecutionCloseStatus {
  COMPLETED,
  FAILED,
  CANCELED,
  TERMINATED,
  CONTINUED_AS_NEW,
  TIMED_OUT,
}

enum QueryTaskCompletedType {
  COMPLETED,
  FAILED,
}

enum QueryResultType {
  ANSWERED,
  FAILED,
}

enum PendingActivityState {
  SCHEDULED,
  STARTED,
  CANCEL_REQUESTED,
}

enum PendingDecisionState {
  SCHEDULED,
  STARTED,
}

enum HistoryEventFilterType {
  ALL_EVENT,
  CLOSE_EVENT,
}

enum TaskListKind {
  NORMAL,
  STICKY,
  EPHEMERAL,
}

enum ArchivalStatus {
  DISABLED,
  ENABLED,
}

enum CronOverlapPolicy {
  SKIPPED,
  BUFFERONE,
}

enum IndexedValueType {
  STRING,
  KEYWORD,
  INT,
  DOUBLE,
  BOOL,
  DATETIME,
}

struct Header {
    10: optional map<string, binary> fields
}

struct WorkflowType {
  10: optional string name
}

struct ActivityType {
  10: optional string name
}

struct TaskList {
  10: optional string name
  20: optional TaskListKind kind
}

enum EncodingType {
  ThriftRW,
  JSON,
}

enum QueryRejectCondition {
  // NOT_OPEN indicates that query should be rejected if workflow is not open
  NOT_OPEN
  // NOT_COMPLETED_CLEANLY indicates that query should be rejected if workflow did not complete cleanly
  NOT_COMPLETED_CLEANLY
}

enum QueryConsistencyLevel {
  // EVENTUAL indicates that query should be eventually consistent
  EVENTUAL
  // STRONG indicates that any events that came before query should be reflected in workflow state before running query
  STRONG
}

struct DataBlob {
  10: optional EncodingType EncodingType
  20: optional binary Data
}

struct TaskListMetadata {
  10: optional double maxTasksPerSecond
}

struct WorkflowExecution {
  10: optional string workflowId
  20: optional string runId
}

struct Memo {
  10: optional map<string,binary> fields
}

struct SearchAttributes {
  10: optional map<string,binary> indexedFields
}

struct WorkerVersionInfo {
  10: optional string impl
  20: optional string featureVersion
}

struct WorkflowExecutionInfo {
  10: optional WorkflowExecution execution
  20: optional WorkflowType type
  30: optional i64 (js.type = "Long") startTime
  40: optional i64 (js.type = "Long") closeTime
  50: optional WorkflowExecutionCloseStatus closeStatus
  60: optional i64 (js.type = "Long") historyLength
  70: optional string parentDomainId
  71: optional string parentDomainName
  72: optional i64 parentInitatedId
  80: optional WorkflowExecution parentExecution
  90: optional i64 (js.type = "Long") executionTime
  100: optional Memo memo
  101: optional SearchAttributes searchAttributes
  110: optional ResetPoints autoResetPoints
  120: optional string taskList
  121: optional TaskList taskListInfo
  130: optional bool isCron
  140: optional i64 (js.type = "Long") updateTime
  150: optional map<string, string> partitionConfig
  160: optional CronOverlapPolicy cronOverlapPolicy
  170: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct WorkflowExecutionConfiguration {
  10: optional TaskList taskList
  20: optional i32 executionStartToCloseTimeoutSeconds
  30: optional i32 taskStartToCloseTimeoutSeconds
//  40: optional ChildPolicy childPolicy -- Removed but reserve the IDL order number
}

struct TransientDecisionInfo {
  10: optional HistoryEvent scheduledEvent
  20: optional HistoryEvent startedEvent
}

struct ScheduleActivityTaskDecisionAttributes {
  10: optional string activityId
  20: optional ActivityType activityType
  25: optional string domain
  30: optional TaskList taskList
  40: optional binary input
  45: optional i32 scheduleToCloseTimeoutSeconds
  50: optional i32 scheduleToStartTimeoutSeconds
  55: optional i32 startToCloseTimeoutSeconds
  60: optional i32 heartbeatTimeoutSeconds
  70: optional RetryPolicy retryPolicy
  80: optional Header header
  90: optional bool requestLocalDispatch
}

struct ActivityLocalDispatchInfo{
  10: optional string activityId
  20: optional i64 (js.type = "Long") scheduledTimestamp
  30: optional i64 (js.type = "Long") startedTimestamp
  40: optional i64 (js.type = "Long") scheduledTimestampOfThisAttempt
  50: optional binary taskToken
}

struct RequestCancelActivityTaskDecisionAttributes {
  10: optional string activityId
}

struct StartTimerDecisionAttributes {
  10: optional string timerId
  20: optional i64 (js.type = "Long") startToFireTimeoutSeconds
}

struct CompleteWorkflowExecutionDecisionAttributes {
  10: optional binary result
}

struct FailWorkflowExecutionDecisionAttributes {
  10: optional string reason
  20: optional binary details
}

struct CancelTimerDecisionAttributes {
  10: optional string timerId
}

struct CancelWorkflowExecutionDecisionAttributes {
  10: optional binary details
}

struct RequestCancelExternalWorkflowExecutionDecisionAttributes {
  10: optional string domain
  20: optional string workflowId
  30: optional string runId
  40: optional binary control
  50: optional bool childWorkflowOnly
}

struct SignalExternalWorkflowExecutionDecisionAttributes {
  10: optional string domain
  20: optional WorkflowExecution execution
  30: optional string signalName
  40: optional binary input
  50: optional binary control
  60: optional bool childWorkflowOnly
}

struct UpsertWorkflowSearchAttributesDecisionAttributes {
  10: optional SearchAttributes searchAttributes
}

struct RecordMarkerDecisionAttributes {
  10: optional string markerName
  20: optional binary details
  30: optional Header header
}

struct ContinueAsNewWorkflowExecutionDecisionAttributes {
  10: optional WorkflowType workflowType
  20: optional TaskList taskList
  30: optional binary input
  40: optional i32 executionStartToCloseTimeoutSeconds
  50: optional i32 taskStartToCloseTimeoutSeconds
  60: optional i32 backoffStartIntervalInSeconds
  70: optional RetryPolicy retryPolicy
  80: optional ContinueAsNewInitiator initiator
  90: optional string failureReason
  100: optional binary failureDetails
  110: optional binary lastCompletionResult
  120: optional string cronSchedule
  130: optional Header header
  140: optional Memo memo
  150: optional SearchAttributes searchAttributes
  160: optional i32 jitterStartSeconds
  170: optional CronOverlapPolicy cronOverlapPolicy
  180: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct StartChildWorkflowExecutionDecisionAttributes {
  10: optional string domain
  20: optional string workflowId
  30: optional WorkflowType workflowType
  40: optional TaskList taskList
  50: optional binary input
  60: optional i32 executionStartToCloseTimeoutSeconds
  70: optional i32 taskStartToCloseTimeoutSeconds
//  80: optional ChildPolicy childPolicy -- Removed but reserve the IDL order number
  81: optional ParentClosePolicy parentClosePolicy
  90: optional binary control
  100: optional WorkflowIdReusePolicy workflowIdReusePolicy
  110: optional RetryPolicy retryPolicy
  120: optional string cronSchedule
  130: optional Header header
  140: optional Memo memo
  150: optional SearchAttributes searchAttributes
  160: optional CronOverlapPolicy cronOverlapPolicy
  170: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct Decision {
  10:  optional DecisionType decisionType
  20:  optional ScheduleActivityTaskDecisionAttributes scheduleActivityTaskDecisionAttributes
  25:  optional StartTimerDecisionAttributes startTimerDecisionAttributes
  30:  optional CompleteWorkflowExecutionDecisionAttributes completeWorkflowExecutionDecisionAttributes
  35:  optional FailWorkflowExecutionDecisionAttributes failWorkflowExecutionDecisionAttributes
  40:  optional RequestCancelActivityTaskDecisionAttributes requestCancelActivityTaskDecisionAttributes
  50:  optional CancelTimerDecisionAttributes cancelTimerDecisionAttributes
  60:  optional CancelWorkflowExecutionDecisionAttributes cancelWorkflowExecutionDecisionAttributes
  70:  optional RequestCancelExternalWorkflowExecutionDecisionAttributes requestCancelExternalWorkflowExecutionDecisionAttributes
  80:  optional RecordMarkerDecisionAttributes recordMarkerDecisionAttributes
  90:  optional ContinueAsNewWorkflowExecutionDecisionAttributes continueAsNewWorkflowExecutionDecisionAttributes
  100: optional StartChildWorkflowExecutionDecisionAttributes startChildWorkflowExecutionDecisionAttributes
  110: optional SignalExternalWorkflowExecutionDecisionAttributes signalExternalWorkflowExecutionDecisionAttributes
  120: optional UpsertWorkflowSearchAttributesDecisionAttributes upsertWorkflowSearchAttributesDecisionAttributes
}

struct WorkflowExecutionStartedEventAttributes {
  10: optional WorkflowType workflowType
  12: optional string parentWorkflowDomain
  14: optional WorkflowExecution parentWorkflowExecution
  16: optional i64 (js.type = "Long") parentInitiatedEventId
  20: optional TaskList taskList
  30: optional binary input
  40: optional i32 executionStartToCloseTimeoutSeconds
  50: optional i32 taskStartToCloseTimeoutSeconds
//  52: optional ChildPolicy childPolicy -- Removed but reserve the IDL order number
  54: optional string continuedExecutionRunId
  55: optional ContinueAsNewInitiator initiator
  56: optional string continuedFailureReason
  57: optional binary continuedFailureDetails
  58: optional binary lastCompletionResult
  59: optional string originalExecutionRunId // This is the runID when the WorkflowExecutionStarted event is written
  60: optional string identity
  61: optional string firstExecutionRunId // This is the very first runID along the chain of ContinueAsNew and Reset.
  62: optional i64 (js.type = "Long") firstScheduledTimeNano
  70: optional RetryPolicy retryPolicy
  80: optional i32 attempt
  90: optional i64 (js.type = "Long") expirationTimestamp
  100: optional string cronSchedule
  110: optional i32 firstDecisionTaskBackoffSeconds
  120: optional Memo memo
  121: optional SearchAttributes searchAttributes
  130: optional ResetPoints prevAutoResetPoints
  140: optional Header header
  150: optional map<string, string> partitionConfig
  160: optional string requestId
  170: optional CronOverlapPolicy cronOverlapPolicy
  180: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct ResetPoints{
  10: optional list<ResetPointInfo> points
}

 struct ResetPointInfo{
  10: optional string binaryChecksum
  20: optional string runId
  30: optional i64 firstDecisionCompletedId
  40: optional i64 (js.type = "Long") createdTimeNano
  50: optional i64 (js.type = "Long") expiringTimeNano //the time that the run is deleted due to retention
  60: optional bool resettable                         // false if the resset point has pending childWFs/reqCancels/signalExternals.
}

struct WorkflowExecutionCompletedEventAttributes {
  10: optional binary result
  20: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct WorkflowExecutionFailedEventAttributes {
  10: optional string reason
  20: optional binary details
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct WorkflowExecutionTimedOutEventAttributes {
  10: optional TimeoutType timeoutType
}

enum ContinueAsNewInitiator {
  Decider,
  RetryPolicy,
  CronSchedule,
}

struct WorkflowExecutionContinuedAsNewEventAttributes {
  10: optional string newExecutionRunId
  20: optional WorkflowType workflowType
  30: optional TaskList taskList
  40: optional binary input
  50: optional i32 executionStartToCloseTimeoutSeconds
  60: optional i32 taskStartToCloseTimeoutSeconds
  70: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  80: optional i32 backoffStartIntervalInSeconds
  90: optional ContinueAsNewInitiator initiator
  100: optional string failureReason
  110: optional binary failureDetails
  120: optional binary lastCompletionResult
  130: optional Header header
  140: optional Memo memo
  150: optional SearchAttributes searchAttributes
}

struct DecisionTaskScheduledEventAttributes {
  10: optional TaskList taskList
  20: optional i32 startToCloseTimeoutSeconds
  30: optional i64 (js.type = "Long") attempt
}

struct DecisionTaskStartedEventAttributes {
  10: optional i64 (js.type = "Long") scheduledEventId
  20: optional string identity
  30: optional string requestId
}

struct DecisionTaskCompletedEventAttributes {
  10: optional binary executionContext
  20: optional i64 (js.type = "Long") scheduledEventId
  30: optional i64 (js.type = "Long") startedEventId
  40: optional string identity
  50: optional string binaryChecksum
}

struct DecisionTaskTimedOutEventAttributes {
  10: optional i64 (js.type = "Long") scheduledEventId
  20: optional i64 (js.type = "Long") startedEventId
  30: optional TimeoutType timeoutType
  // for reset workflow
  40: optional string baseRunId
  50: optional string newRunId
  60: optional i64 (js.type = "Long") forkEventVersion
  70: optional string reason
  80: optional DecisionTaskTimedOutCause cause
  90: optional string requestId
}

struct DecisionTaskFailedEventAttributes {
  10: optional i64 (js.type = "Long") scheduledEventId
  20: optional i64 (js.type = "Long") startedEventId
  30: optional DecisionTaskFailedCause cause
  35: optional binary details
  40: optional string identity
  50: optional string reason
  // for reset workflow
  60: optional string baseRunId
  70: optional string newRunId
  80: optional i64 (js.type = "Long") forkEventVersion
  90: optional string binaryChecksum
  100: optional string requestId
}

struct ActivityTaskScheduledEventAttributes {
  10: optional string activityId
  20: optional ActivityType activityType
  25: optional string domain
  30: optional TaskList taskList
  40: optional binary input
  45: optional i32 scheduleToCloseTimeoutSeconds
  50: optional i32 scheduleToStartTimeoutSeconds
  55: optional i32 startToCloseTimeoutSeconds
  60: optional i32 heartbeatTimeoutSeconds
  90: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  110: optional RetryPolicy retryPolicy
  120: optional Header header
}

struct ActivityTaskStartedEventAttributes {
  10: optional i64 (js.type = "Long") scheduledEventId
  20: optional string identity
  30: optional string requestId
  40: optional i32 attempt
  50: optional string lastFailureReason
  60: optional binary lastFailureDetails
}

struct ActivityTaskCompletedEventAttributes {
  10: optional binary result
  20: optional i64 (js.type = "Long") scheduledEventId
  30: optional i64 (js.type = "Long") startedEventId
  40: optional string identity
}

struct ActivityTaskFailedEventAttributes {
  10: optional string reason
  20: optional binary details
  30: optional i64 (js.type = "Long") scheduledEventId
  40: optional i64 (js.type = "Long") startedEventId
  50: optional string identity
}

struct ActivityTaskTimedOutEventAttributes {
  05: optional binary details
  10: optional i64 (js.type = "Long") scheduledEventId
  20: optional i64 (js.type = "Long") startedEventId
  30: optional TimeoutType timeoutType
  // For retry activity, it may have a failure before timeout. It's important to keep those information for debug.
  // Client can also provide the info for making next decision
  40: optional string lastFailureReason
  50: optional binary lastFailureDetails
}

struct ActivityTaskCancelRequestedEventAttributes {
  10: optional string activityId
  20: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct RequestCancelActivityTaskFailedEventAttributes{
  10: optional string activityId
  20: optional string cause
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct ActivityTaskCanceledEventAttributes {
  10: optional binary details
  20: optional i64 (js.type = "Long") latestCancelRequestedEventId
  30: optional i64 (js.type = "Long") scheduledEventId
  40: optional i64 (js.type = "Long") startedEventId
  50: optional string identity
}

struct TimerStartedEventAttributes {
  10: optional string timerId
  20: optional i64 (js.type = "Long") startToFireTimeoutSeconds
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct TimerFiredEventAttributes {
  10: optional string timerId
  20: optional i64 (js.type = "Long") startedEventId
}

struct TimerCanceledEventAttributes {
  10: optional string timerId
  20: optional i64 (js.type = "Long") startedEventId
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  40: optional string identity
}

struct CancelTimerFailedEventAttributes {
  10: optional string timerId
  20: optional string cause
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  40: optional string identity
}

struct WorkflowExecutionCancelRequestedEventAttributes {
  10: optional string cause
  20: optional i64 (js.type = "Long") externalInitiatedEventId
  30: optional WorkflowExecution externalWorkflowExecution
  40: optional string identity
  50: optional string requestId
}

struct WorkflowExecutionCanceledEventAttributes {
  10: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  20: optional binary details
}

struct MarkerRecordedEventAttributes {
  10: optional string markerName
  20: optional binary details
  30: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  40: optional Header header
}

struct WorkflowExecutionSignaledEventAttributes {
  10: optional string signalName
  20: optional binary input
  30: optional string identity
  40: optional string requestId
}

struct WorkflowExecutionTerminatedEventAttributes {
  10: optional string reason
  20: optional binary details
  30: optional string identity
}

struct RequestCancelExternalWorkflowExecutionInitiatedEventAttributes {
  10: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional binary control
  50: optional bool childWorkflowOnly
}

struct RequestCancelExternalWorkflowExecutionFailedEventAttributes {
  10: optional CancelExternalWorkflowExecutionFailedCause cause
  20: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  30: optional string domain
  40: optional WorkflowExecution workflowExecution
  50: optional i64 (js.type = "Long") initiatedEventId
  60: optional binary control
}

struct ExternalWorkflowExecutionCancelRequestedEventAttributes {
  10: optional i64 (js.type = "Long") initiatedEventId
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
}

struct SignalExternalWorkflowExecutionInitiatedEventAttributes {
  10: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional string signalName
  50: optional binary input
  60: optional binary control
  70: optional bool childWorkflowOnly
}

struct SignalExternalWorkflowExecutionFailedEventAttributes {
  10: optional SignalExternalWorkflowExecutionFailedCause cause
  20: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  30: optional string domain
  40: optional WorkflowExecution workflowExecution
  50: optional i64 (js.type = "Long") initiatedEventId
  60: optional binary control
}

struct ExternalWorkflowExecutionSignaledEventAttributes {
  10: optional i64 (js.type = "Long") initiatedEventId
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional binary control
}

struct UpsertWorkflowSearchAttributesEventAttributes {
  10: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  20: optional SearchAttributes searchAttributes
}

struct StartChildWorkflowExecutionInitiatedEventAttributes {
  10:  optional string domain
  20:  optional string workflowId
  30:  optional WorkflowType workflowType
  40:  optional TaskList taskList
  50:  optional binary input
  60:  optional i32 executionStartToCloseTimeoutSeconds
  70:  optional i32 taskStartToCloseTimeoutSeconds
//  80:  optional ChildPolicy childPolicy -- Removed but reserve the IDL order number
  81:  optional ParentClosePolicy parentClosePolicy
  90:  optional binary control
  100: optional i64 (js.type = "Long") decisionTaskCompletedEventId
  110: optional WorkflowIdReusePolicy workflowIdReusePolicy
  120: optional RetryPolicy retryPolicy
  130: optional string cronSchedule
  140: optional Header header
  150: optional Memo memo
  160: optional SearchAttributes searchAttributes
  170: optional i32 delayStartSeconds
  180: optional i32 jitterStartSeconds
  190: optional i64 (js.type = "Long") firstRunAtTimestamp
  200: optional CronOverlapPolicy cronOverlapPolicy
  210: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct StartChildWorkflowExecutionFailedEventAttributes {
  10: optional string domain
  20: optional string workflowId
  30: optional WorkflowType workflowType
  40: optional ChildWorkflowExecutionFailedCause cause
  50: optional binary control
  60: optional i64 (js.type = "Long") initiatedEventId
  70: optional i64 (js.type = "Long") decisionTaskCompletedEventId
}

struct ChildWorkflowExecutionStartedEventAttributes {
  10: optional string domain
  20: optional i64 (js.type = "Long") initiatedEventId
  30: optional WorkflowExecution workflowExecution
  40: optional WorkflowType workflowType
  50: optional Header header
}

struct ChildWorkflowExecutionCompletedEventAttributes {
  10: optional binary result
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional WorkflowType workflowType
  50: optional i64 (js.type = "Long") initiatedEventId
  60: optional i64 (js.type = "Long") startedEventId
}

struct ChildWorkflowExecutionFailedEventAttributes {
  10: optional string reason
  20: optional binary details
  30: optional string domain
  40: optional WorkflowExecution workflowExecution
  50: optional WorkflowType workflowType
  60: optional i64 (js.type = "Long") initiatedEventId
  70: optional i64 (js.type = "Long") startedEventId
}

struct ChildWorkflowExecutionCanceledEventAttributes {
  10: optional binary details
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional WorkflowType workflowType
  50: optional i64 (js.type = "Long") initiatedEventId
  60: optional i64 (js.type = "Long") startedEventId
}

struct ChildWorkflowExecutionTimedOutEventAttributes {
  10: optional TimeoutType timeoutType
  20: optional string domain
  30: optional WorkflowExecution workflowExecution
  40: optional WorkflowType workflowType
  50: optional i64 (js.type = "Long") initiatedEventId
  60: optional i64 (js.type = "Long") startedEventId
}

struct ChildWorkflowExecutionTerminatedEventAttributes {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional WorkflowType workflowType
  40: optional i64 (js.type = "Long") initiatedEventId
  50: optional i64 (js.type = "Long") startedEventId
}

struct HistoryEvent {
  10:  optional i64 (js.type = "Long") eventId
  20:  optional i64 (js.type = "Long") timestamp
  30:  optional EventType eventType
  35:  optional i64 (js.type = "Long") version
  36:  optional i64 (js.type = "Long") taskId
  40:  optional WorkflowExecutionStartedEventAttributes workflowExecutionStartedEventAttributes
  50:  optional WorkflowExecutionCompletedEventAttributes workflowExecutionCompletedEventAttributes
  60:  optional WorkflowExecutionFailedEventAttributes workflowExecutionFailedEventAttributes
  70:  optional WorkflowExecutionTimedOutEventAttributes workflowExecutionTimedOutEventAttributes
  80:  optional DecisionTaskScheduledEventAttributes decisionTaskScheduledEventAttributes
  90:  optional DecisionTaskStartedEventAttributes decisionTaskStartedEventAttributes
  100: optional DecisionTaskCompletedEventAttributes decisionTaskCompletedEventAttributes
  110: optional DecisionTaskTimedOutEventAttributes decisionTaskTimedOutEventAttributes
  120: optional DecisionTaskFailedEventAttributes decisionTaskFailedEventAttributes
  130: optional ActivityTaskScheduledEventAttributes activityTaskScheduledEventAttributes
  140: optional ActivityTaskStartedEventAttributes activityTaskStartedEventAttributes
  150: optional ActivityTaskCompletedEventAttributes activityTaskCompletedEventAttributes
  160: optional ActivityTaskFailedEventAttributes activityTaskFailedEventAttributes
  170: optional ActivityTaskTimedOutEventAttributes activityTaskTimedOutEventAttributes
  180: optional TimerStartedEventAttributes timerStartedEventAttributes
  190: optional TimerFiredEventAttributes timerFiredEventAttributes
  200: optional ActivityTaskCancelRequestedEventAttributes activityTaskCancelRequestedEventAttributes
  210: optional RequestCancelActivityTaskFailedEventAttributes requestCancelActivityTaskFailedEventAttributes
  220: optional ActivityTaskCanceledEventAttributes activityTaskCanceledEventAttributes
  230: optional TimerCanceledEventAttributes timerCanceledEventAttributes
  240: optional CancelTimerFailedEventAttributes cancelTimerFailedEventAttributes
  250: optional MarkerRecordedEventAttributes markerRecordedEventAttributes
  260: optional WorkflowExecutionSignaledEventAttributes workflowExecutionSignaledEventAttributes
  270: optional WorkflowExecutionTerminatedEventAttributes workflowExecutionTerminatedEventAttributes
  280: optional WorkflowExecutionCancelRequestedEventAttributes workflowExecutionCancelRequestedEventAttributes
  290: optional WorkflowExecutionCanceledEventAttributes workflowExecutionCanceledEventAttributes
  300: optional RequestCancelExternalWorkflowExecutionInitiatedEventAttributes requestCancelExternalWorkflowExecutionInitiatedEventAttributes
  310: optional RequestCancelExternalWorkflowExecutionFailedEventAttributes requestCancelExternalWorkflowExecutionFailedEventAttributes
  320: optional ExternalWorkflowExecutionCancelRequestedEventAttributes externalWorkflowExecutionCancelRequestedEventAttributes
  330: optional WorkflowExecutionContinuedAsNewEventAttributes workflowExecutionContinuedAsNewEventAttributes
  340: optional StartChildWorkflowExecutionInitiatedEventAttributes startChildWorkflowExecutionInitiatedEventAttributes
  350: optional StartChildWorkflowExecutionFailedEventAttributes startChildWorkflowExecutionFailedEventAttributes
  360: optional ChildWorkflowExecutionStartedEventAttributes childWorkflowExecutionStartedEventAttributes
  370: optional ChildWorkflowExecutionCompletedEventAttributes childWorkflowExecutionCompletedEventAttributes
  380: optional ChildWorkflowExecutionFailedEventAttributes childWorkflowExecutionFailedEventAttributes
  390: optional ChildWorkflowExecutionCanceledEventAttributes childWorkflowExecutionCanceledEventAttributes
  400: optional ChildWorkflowExecutionTimedOutEventAttributes childWorkflowExecutionTimedOutEventAttributes
  410: optional ChildWorkflowExecutionTerminatedEventAttributes childWorkflowExecutionTerminatedEventAttributes
  420: optional SignalExternalWorkflowExecutionInitiatedEventAttributes signalExternalWorkflowExecutionInitiatedEventAttributes
  430: optional SignalExternalWorkflowExecutionFailedEventAttributes signalExternalWorkflowExecutionFailedEventAttributes
  440: optional ExternalWorkflowExecutionSignaledEventAttributes externalWorkflowExecutionSignaledEventAttributes
  450: optional UpsertWorkflowSearchAttributesEventAttributes upsertWorkflowSearchAttributesEventAttributes
}

struct History {
  10: optional list<HistoryEvent> events
}

struct WorkflowExecutionFilter {
  10: optional string workflowId
  20: optional string runId
}

struct WorkflowTypeFilter {
  10: optional string name
}

struct StartTimeFilter {
  10: optional i64 (js.type = "Long") earliestTime
  20: optional i64 (js.type = "Long") latestTime
}

struct DomainInfo {
  10: optional string name
  20: optional DomainStatus status
  30: optional string description
  40: optional string ownerEmail
  // A key-value map for any customized purpose
  50: optional map<string,string> data
  60: optional string uuid
}

struct DomainConfiguration {
  10: optional i32 workflowExecutionRetentionPeriodInDays
  20: optional bool emitMetric
  60: optional IsolationGroupConfiguration isolationgroups
  70: optional BadBinaries badBinaries
  80: optional ArchivalStatus historyArchivalStatus
  90: optional string historyArchivalURI
  100: optional ArchivalStatus visibilityArchivalStatus
  110: optional string visibilityArchivalURI
  120: optional AsyncWorkflowConfiguration AsyncWorkflowConfiguration
}

struct FailoverInfo {
    10: optional i64 (js.type = "Long") failoverVersion
    20: optional i64 (js.type = "Long") failoverStartTimestamp
    30: optional i64 (js.type = "Long") failoverExpireTimestamp
    40: optional i32 completedShardCount
    50: optional list<i32> pendingShards
}

struct BadBinaries{
  10: optional map<string, BadBinaryInfo> binaries
}

struct BadBinaryInfo{
  10: optional string reason
  20: optional string operator
  30: optional i64 (js.type = "Long") createdTimeNano
}

struct UpdateDomainInfo {
  10: optional string description
  20: optional string ownerEmail
  // A key-value map for any customized purpose
  30: optional map<string,string> data
}

struct ClusterReplicationConfiguration {
 10: optional string clusterName
}

struct DomainReplicationConfiguration {
 // activeClusterName is the name of the active cluster for active-passive domain
 10: optional string activeClusterName

 //  clusters is list of all active and passive clusters of domain
 20: optional list<ClusterReplicationConfiguration> clusters

 // activeClusters contains active cluster(s) information for active-active domain
 30: optional ActiveClusters activeClusters
}

struct ActiveClusters {
  // activeClustersByRegion is a map of region name to active cluster info for active-active domain
  10: optional map<string, ActiveClusterInfo> activeClustersByRegion
}

// ActiveClusterInfo contains the configuration of active-active domain's active cluster & failover version for a specific region
struct ActiveClusterInfo {
  10: optional string activeClusterName
  20: optional i64 (js.type = "Long") failoverVersion
}

struct RegisterDomainRequest {
  10: optional string name
  20: optional string description
  30: optional string ownerEmail
  40: optional i32 workflowExecutionRetentionPeriodInDays
  50: optional bool emitMetric = true
  60: optional list<ClusterReplicationConfiguration> clusters
  70: optional string activeClusterName
  // activeClusters is a map of region name to active cluster name for active-active domain
  75: optional map<string, string> activeClustersByRegion
  // A key-value map for any customized purpose
  80: optional map<string,string> data
  90: optional string securityToken
  120: optional bool isGlobalDomain
  130: optional ArchivalStatus historyArchivalStatus
  140: optional string historyArchivalURI
  150: optional ArchivalStatus visibilityArchivalStatus
  160: optional string visibilityArchivalURI
}

struct ListDomainsRequest {
  10: optional i32 pageSize
  20: optional binary nextPageToken
}

struct ListDomainsResponse {
  10: optional list<DescribeDomainResponse> domains
  20: optional binary nextPageToken
}

struct DescribeDomainRequest {
  10: optional string name
  20: optional string uuid
}

struct DescribeDomainResponse {
  10: optional DomainInfo domainInfo
  20: optional DomainConfiguration configuration
  30: optional DomainReplicationConfiguration replicationConfiguration
  40: optional i64 (js.type = "Long") failoverVersion
  50: optional bool isGlobalDomain
  60: optional FailoverInfo failoverInfo
}

struct UpdateDomainRequest {
 10: optional string name
 20: optional UpdateDomainInfo updatedInfo
 30: optional DomainConfiguration configuration
 40: optional DomainReplicationConfiguration replicationConfiguration
 50: optional string securityToken
 60: optional string deleteBadBinary
 70: optional i32 failoverTimeoutInSeconds
}

struct UpdateDomainResponse {
  10: optional DomainInfo domainInfo
  20: optional DomainConfiguration configuration
  30: optional DomainReplicationConfiguration replicationConfiguration
  40: optional i64 (js.type = "Long") failoverVersion
  50: optional bool isGlobalDomain
}

struct DeprecateDomainRequest {
 10: optional string name
 20: optional string securityToken
}

struct DeleteDomainRequest {
 10: optional string name
 20: optional string securityToken
}

struct StartWorkflowExecutionRequest {
  10: optional string domain
  20: optional string workflowId
  30: optional WorkflowType workflowType
  40: optional TaskList taskList
  50: optional binary input
  60: optional i32 executionStartToCloseTimeoutSeconds
  70: optional i32 taskStartToCloseTimeoutSeconds
  80: optional string identity
  90: optional string requestId
  100: optional WorkflowIdReusePolicy workflowIdReusePolicy
//  110: optional ChildPolicy childPolicy -- Removed but reserve the IDL order number
  120: optional RetryPolicy retryPolicy
  130: optional string cronSchedule
  140: optional Memo memo
  141: optional SearchAttributes searchAttributes
  150: optional Header header
  160: optional i32 delayStartSeconds
  170: optional i32 jitterStartSeconds
  180: optional i64 (js.type = "Long") firstRunAtTimestamp
  190: optional CronOverlapPolicy cronOverlapPolicy
  200: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct StartWorkflowExecutionResponse {
  10: optional string runId
}

struct StartWorkflowExecutionAsyncRequest {
  10: optional StartWorkflowExecutionRequest request
}

struct StartWorkflowExecutionAsyncResponse {
}

struct RestartWorkflowExecutionResponse {
  10: optional string runId
}

struct DiagnoseWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string identity
}

struct DiagnoseWorkflowExecutionResponse {
  10: optional string domain
  20: optional WorkflowExecution diagnosticWorkflowExecution
}

struct PollForDecisionTaskRequest {
  10: optional string domain
  20: optional TaskList taskList
  30: optional string identity
  40: optional string binaryChecksum
}

struct PollForDecisionTaskResponse {
  10: optional binary taskToken
  20: optional WorkflowExecution workflowExecution
  30: optional WorkflowType workflowType
  40: optional i64 (js.type = "Long") previousStartedEventId
  50: optional i64 (js.type = "Long") startedEventId
  51: optional i64 (js.type = 'Long') attempt
  54: optional i64 (js.type = "Long") backlogCountHint
  60: optional History history
  70: optional binary nextPageToken
  80: optional WorkflowQuery query
  90: optional TaskList WorkflowExecutionTaskList
  100: optional i64 (js.type = "Long") scheduledTimestamp
  110: optional i64 (js.type = "Long") startedTimestamp
  120: optional map<string, WorkflowQuery> queries
  130: optional i64 (js.type = 'Long') nextEventId
  140: optional i64 (js.type = 'Long') totalHistoryBytes
  150: optional AutoConfigHint autoConfigHint
}

struct StickyExecutionAttributes {
  10: optional TaskList workerTaskList
  20: optional i32 scheduleToStartTimeoutSeconds
}

struct RespondDecisionTaskCompletedRequest {
  10: optional binary taskToken
  20: optional list<Decision> decisions
  30: optional binary executionContext
  40: optional string identity
  50: optional StickyExecutionAttributes stickyAttributes
  60: optional bool returnNewDecisionTask
  70: optional bool forceCreateNewDecisionTask
  80: optional string binaryChecksum
  90: optional map<string, WorkflowQueryResult> queryResults
}

struct RespondDecisionTaskCompletedResponse {
  10: optional PollForDecisionTaskResponse decisionTask
  20: optional map<string,ActivityLocalDispatchInfo> activitiesToDispatchLocally
}

struct RespondDecisionTaskFailedRequest {
  10: optional binary taskToken
  20: optional DecisionTaskFailedCause cause
  30: optional binary details
  40: optional string identity
  50: optional string binaryChecksum
}

struct PollForActivityTaskRequest {
  10: optional string domain
  20: optional TaskList taskList
  30: optional string identity
  40: optional TaskListMetadata taskListMetadata
}

struct PollForActivityTaskResponse {
  10:  optional binary taskToken
  20:  optional WorkflowExecution workflowExecution
  30:  optional string activityId
  40:  optional ActivityType activityType
  50:  optional binary input
  70:  optional i64 (js.type = "Long") scheduledTimestamp
  80:  optional i32 scheduleToCloseTimeoutSeconds
  90:  optional i64 (js.type = "Long") startedTimestamp
  100: optional i32 startToCloseTimeoutSeconds
  110: optional i32 heartbeatTimeoutSeconds
  120: optional i32 attempt
  130: optional i64 (js.type = "Long") scheduledTimestampOfThisAttempt
  140: optional binary heartbeatDetails
  150: optional WorkflowType workflowType
  160: optional string workflowDomain
  170: optional Header header
  180: optional AutoConfigHint autoConfigHint
}

struct RecordActivityTaskHeartbeatRequest {
  10: optional binary taskToken
  20: optional binary details
  30: optional string identity
}

struct RecordActivityTaskHeartbeatByIDRequest {
  10: optional string domain
  20: optional string workflowID
  30: optional string runID
  40: optional string activityID
  50: optional binary details
  60: optional string identity
}

struct RecordActivityTaskHeartbeatResponse {
  10: optional bool cancelRequested
}

struct RespondActivityTaskCompletedRequest {
  10: optional binary taskToken
  20: optional binary result
  30: optional string identity
}

struct RespondActivityTaskFailedRequest {
  10: optional binary taskToken
  20: optional string reason
  30: optional binary details
  40: optional string identity
}

struct RespondActivityTaskCanceledRequest {
  10: optional binary taskToken
  20: optional binary details
  30: optional string identity
}

struct RespondActivityTaskCompletedByIDRequest {
  10: optional string domain
  20: optional string workflowID
  30: optional string runID
  40: optional string activityID
  50: optional binary result
  60: optional string identity
}

struct RespondActivityTaskFailedByIDRequest {
  10: optional string domain
  20: optional string workflowID
  30: optional string runID
  40: optional string activityID
  50: optional string reason
  60: optional binary details
  70: optional string identity
}

struct RespondActivityTaskCanceledByIDRequest {
  10: optional string domain
  20: optional string workflowID
  30: optional string runID
  40: optional string activityID
  50: optional binary details
  60: optional string identity
}

struct RequestCancelWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string identity
  40: optional string requestId
  50: optional string cause
  60: optional string firstExecutionRunID
}

struct GetWorkflowExecutionHistoryRequest {
  10: optional string domain
  20: optional WorkflowExecution execution
  30: optional i32 maximumPageSize
  40: optional binary nextPageToken
  50: optional bool waitForNewEvent
  60: optional HistoryEventFilterType HistoryEventFilterType
  70: optional bool skipArchival
  80: optional QueryConsistencyLevel queryConsistencyLevel
}

struct GetWorkflowExecutionHistoryResponse {
  10: optional History history
  11: optional list<DataBlob> rawHistory
  20: optional binary nextPageToken
  30: optional bool archived
}

struct SignalWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string signalName
  40: optional binary input
  50: optional string identity
  60: optional string requestId
  70: optional binary control
}

struct SignalWithStartWorkflowExecutionRequest {
  10: optional string domain
  20: optional string workflowId
  30: optional WorkflowType workflowType
  40: optional TaskList taskList
  50: optional binary input
  60: optional i32 executionStartToCloseTimeoutSeconds
  70: optional i32 taskStartToCloseTimeoutSeconds
  80: optional string identity
  90: optional string requestId
  100: optional WorkflowIdReusePolicy workflowIdReusePolicy
  110: optional string signalName
  120: optional binary signalInput
  130: optional binary control
  140: optional RetryPolicy retryPolicy
  150: optional string cronSchedule
  160: optional Memo memo
  161: optional SearchAttributes searchAttributes
  170: optional Header header
  180: optional i32 delayStartSeconds
  190: optional i32 jitterStartSeconds
  200: optional i64 (js.type = "Long") firstRunAtTimestamp
  210: optional CronOverlapPolicy cronOverlapPolicy
  220: optional ActiveClusterSelectionPolicy activeClusterSelectionPolicy
}

struct SignalWithStartWorkflowExecutionAsyncRequest {
  10: optional SignalWithStartWorkflowExecutionRequest request
}

struct SignalWithStartWorkflowExecutionAsyncResponse {
}

struct RestartWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string reason
  40: optional string identity
}
struct TerminateWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string reason
  40: optional binary details
  50: optional string identity
  60: optional string firstExecutionRunID
}

struct ResetWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution workflowExecution
  30: optional string reason
  40: optional i64 (js.type = "Long") decisionFinishEventId
  50: optional string requestId
  60: optional bool skipSignalReapply
}

struct ResetWorkflowExecutionResponse {
  10: optional string runId
}

struct ListOpenWorkflowExecutionsRequest {
  10: optional string domain
  20: optional i32 maximumPageSize
  30: optional binary nextPageToken
  40: optional StartTimeFilter StartTimeFilter
  50: optional WorkflowExecutionFilter executionFilter
  60: optional WorkflowTypeFilter typeFilter
}

struct ListOpenWorkflowExecutionsResponse {
  10: optional list<WorkflowExecutionInfo> executions
  20: optional binary nextPageToken
}

struct ListClosedWorkflowExecutionsRequest {
  10: optional string domain
  20: optional i32 maximumPageSize
  30: optional binary nextPageToken
  40: optional StartTimeFilter StartTimeFilter
  50: optional WorkflowExecutionFilter executionFilter
  60: optional WorkflowTypeFilter typeFilter
  70: optional WorkflowExecutionCloseStatus statusFilter
}

struct ListClosedWorkflowExecutionsResponse {
  10: optional list<WorkflowExecutionInfo> executions
  20: optional binary nextPageToken
}

struct ListWorkflowExecutionsRequest {
  10: optional string domain
  20: optional i32 pageSize
  30: optional binary nextPageToken
  40: optional string query
}

struct ListWorkflowExecutionsResponse {
  10: optional list<WorkflowExecutionInfo> executions
  20: optional binary nextPageToken
}

struct ListArchivedWorkflowExecutionsRequest {
  10: optional string domain
  20: optional i32 pageSize
  30: optional binary nextPageToken
  40: optional string query
}

struct ListArchivedWorkflowExecutionsResponse {
  10: optional list<WorkflowExecutionInfo> executions
  20: optional binary nextPageToken
}

struct CountWorkflowExecutionsRequest {
  10: optional string domain
  20: optional string query
}

struct CountWorkflowExecutionsResponse {
  10: optional i64 count
}

struct GetSearchAttributesResponse {
  10: optional map<string, IndexedValueType> keys
}

struct QueryWorkflowRequest {
  10: optional string domain
  20: optional WorkflowExecution execution
  30: optional WorkflowQuery query
  // QueryRejectCondition can used to reject the query if workflow state does not satisify condition
  40: optional QueryRejectCondition queryRejectCondition
  50: optional QueryConsistencyLevel queryConsistencyLevel
}

struct QueryRejected {
  10: optional WorkflowExecutionCloseStatus closeStatus
}

struct QueryWorkflowResponse {
  10: optional binary queryResult
  20: optional QueryRejected queryRejected
}

struct WorkflowQuery {
  10: optional string queryType
  20: optional binary queryArgs
}

struct ResetStickyTaskListRequest {
  10: optional string domain
  20: optional WorkflowExecution execution
}

struct ResetStickyTaskListResponse {
    // The reason to keep this response is to allow returning
    // information in the future.
}

struct RespondQueryTaskCompletedRequest {
  10: optional binary taskToken
  20: optional QueryTaskCompletedType completedType
  30: optional binary queryResult
  40: optional string errorMessage
  50: optional WorkerVersionInfo workerVersionInfo
}

struct WorkflowQueryResult {
  10: optional QueryResultType resultType
  20: optional binary answer
  30: optional string errorMessage
}

struct DescribeWorkflowExecutionRequest {
  10: optional string domain
  20: optional WorkflowExecution execution
  30: optional QueryConsistencyLevel queryConsistencyLevel
}

struct PendingActivityInfo {
  10: optional string activityID
  20: optional ActivityType activityType
  30: optional PendingActivityState state
  40: optional binary heartbeatDetails
  50: optional i64 (js.type = "Long") lastHeartbeatTimestamp
  60: optional i64 (js.type = "Long") lastStartedTimestamp
  70: optional i32 attempt
  80: optional i32 maximumAttempts
  90: optional i64 (js.type = "Long") scheduledTimestamp
  100: optional i64 (js.type = "Long") expirationTimestamp
  110: optional string lastFailureReason
  120: optional string lastWorkerIdentity
  130: optional binary lastFailureDetails
  140: optional string startedWorkerIdentity
  150: optional i64 (js.type = "Long") scheduleID
}

struct PendingDecisionInfo {
  10: optional PendingDecisionState state
  20: optional i64 (js.type = "Long") scheduledTimestamp
  30: optional i64 (js.type = "Long") startedTimestamp
  40: optional i64 attempt
  50: optional i64 (js.type = "Long") originalScheduledTimestamp
  60: optional i64 (js.type = "Long") scheduleID
}

struct PendingChildExecutionInfo {
  1: optional string domain
  10: optional string workflowID
  20: optional string runID
  30: optional string workflowTypName
  40: optional i64 (js.type = "Long") initiatedID
  50: optional ParentClosePolicy parentClosePolicy
}

struct DescribeWorkflowExecutionResponse {
  10: optional WorkflowExecutionConfiguration executionConfiguration
  20: optional WorkflowExecutionInfo workflowExecutionInfo
  30: optional list<PendingActivityInfo> pendingActivities
  40: optional list<PendingChildExecutionInfo> pendingChildren
  50: optional PendingDecisionInfo pendingDecision
}

struct DescribeTaskListRequest {
  10: optional string domain
  20: optional TaskList taskList
  30: optional TaskListType taskListType
  40: optional bool includeTaskListStatus
}

struct DescribeTaskListResponse {
  10: optional list<PollerInfo> pollers
  20: optional TaskListStatus taskListStatus
  // The TaskList being described
  30: optional TaskList taskList
}

struct GetTaskListsByDomainRequest {
  10: optional string domainName
}

struct GetTaskListsByDomainResponse {
  10: optional map<string,DescribeTaskListResponse> decisionTaskListMap
  20: optional map<string,DescribeTaskListResponse> activityTaskListMap
}

struct ListTaskListPartitionsRequest {
  10: optional string domain
  20: optional TaskList taskList
}

struct TaskListPartitionMetadata {
  10: optional string key
  20: optional string ownerHostName
}

struct ListTaskListPartitionsResponse {
  10: optional list<TaskListPartitionMetadata> activityTaskListPartitions
  20: optional list<TaskListPartitionMetadata> decisionTaskListPartitions
}

struct IsolationGroupMetrics {
  10: optional double newTasksPerSecond
  20: optional i64 (js.type = "Long") pollerCount
}

struct TaskListStatus {
  10: optional i64 (js.type = "Long") backlogCountHint
  20: optional i64 (js.type = "Long") readLevel
  30: optional i64 (js.type = "Long") ackLevel
  35: optional double ratePerSecond
  40: optional TaskIDBlock taskIDBlock
  50: optional map<string, IsolationGroupMetrics> isolationGroupMetrics
  60: optional double newTasksPerSecond
  70: optional bool empty
}

struct TaskIDBlock {
  10: optional i64 (js.type = "Long")  startID
  20: optional i64 (js.type = "Long")  endID
}

//At least one of the parameters needs to be provided
struct DescribeHistoryHostRequest {
  10: optional string               hostAddress //ip:port
  20: optional i32                  shardIdForHost
  30: optional WorkflowExecution    executionForHost
}

struct RemoveTaskRequest {
  10: optional i32                      shardID
  20: optional i32                      type
  30: optional i64 (js.type = "Long")   taskID
  40: optional i64 (js.type = "Long")   visibilityTimestamp
  50: optional string                   clusterName
}

struct CloseShardRequest {
  10: optional i32               shardID
}

struct ResetQueueRequest {
  10: optional i32    shardID
  20: optional string clusterName
  30: optional i32    type
}

struct DescribeQueueRequest {
  10: optional i32    shardID
  20: optional string clusterName
  30: optional i32    type
}

struct DescribeQueueResponse {
  10: optional list<string> processingQueueStates
}

struct DescribeShardDistributionRequest {
  10: optional i32 pageSize
  20: optional i32 pageID
}

struct DescribeShardDistributionResponse {
  10: optional i32              numberOfShards

  // ShardID to Address (ip:port) map
  20: optional map<i32, string> shards
}

struct DescribeHistoryHostResponse{
  10: optional i32                  numberOfShards
  20: optional list<i32>            shardIDs
  30: optional DomainCacheInfo      domainCache
  40: optional string               shardControllerStatus
  50: optional string               address
}

struct DomainCacheInfo{
  10: optional i64 numOfItemsInCacheByID
  20: optional i64 numOfItemsInCacheByName
}

enum TaskListType {
  /*
   * Decision type of tasklist
   */
  Decision,
  /*
   * Activity type of tasklist
   */
  Activity,
}

struct PollerInfo {
  // Unix Nano
  10: optional i64 (js.type = "Long")  lastAccessTime
  20: optional string identity
  30: optional double ratePerSecond
}

struct RetryPolicy {
  // Interval of the first retry. If coefficient is 1.0 then it is used for all retries.
  10: optional i32 initialIntervalInSeconds

  // Coefficient used to calculate the next retry interval.
  // The next retry interval is previous interval multiplied by the coefficient.
  // Must be 1 or larger.
  20: optional double backoffCoefficient

  // Maximum interval between retries. Exponential backoff leads to interval increase.
  // This value is the cap of the increase. Default is 100x of initial interval.
  30: optional i32 maximumIntervalInSeconds

  // Maximum number of attempts. When exceeded the retries stop even if not expired yet.
  // Must be 1 or bigger. Default is unlimited.
  40: optional i32 maximumAttempts

  // Non-Retriable errors. Will stop retrying if error matches this list.
  50: optional list<string> nonRetriableErrorReasons

  // Expiration time for the whole retry process.
  60: optional i32 expirationIntervalInSeconds
}

// HistoryBranchRange represents a piece of range for a branch.
struct HistoryBranchRange{
  // branchID of original branch forked from
  10: optional string branchID
  // beinning node for the range, inclusive
  20: optional i64 beginNodeID
  // ending node for the range, exclusive
  30: optional i64 endNodeID
}

// For history persistence to serialize/deserialize branch details
struct HistoryBranch{
  10: optional string treeID
  20: optional string branchID
  30: optional list<HistoryBranchRange> ancestors
}

// VersionHistoryItem contains signal eventID and the corresponding version
struct VersionHistoryItem{
  10: optional i64 (js.type = "Long") eventID
  20: optional i64 (js.type = "Long") version
}

// VersionHistory contains the version history of a branch
struct VersionHistory{
  10: optional binary branchToken
  20: optional list<VersionHistoryItem> items
}

// VersionHistories contains all version histories from all branches
struct VersionHistories{
  10: optional i32 currentVersionHistoryIndex
  20: optional list<VersionHistory> histories
}

// ReapplyEventsRequest is the request for reapply events API
struct ReapplyEventsRequest{
  10: optional string domainName
  20: optional WorkflowExecution workflowExecution
  30: optional DataBlob events
}

// SupportedClientVersions contains the support versions for client library
struct SupportedClientVersions{
  10: optional string goSdk
  20: optional string javaSdk
}

// ClusterInfo contains information about cadence cluster
struct ClusterInfo{
  10: optional SupportedClientVersions supportedClientVersions
}

struct RefreshWorkflowTasksRequest {
  10: optional string domain
  20: optional WorkflowExecution execution
}

struct FeatureFlags {
	10: optional bool WorkflowExecutionAlreadyCompletedErrorEnabled
}

enum CrossClusterTaskType {
  StartChildExecution
  CancelExecution
  SignalExecution
  RecordChildWorkflowExecutionComplete
  ApplyParentClosePolicy
}

enum CrossClusterTaskFailedCause {
  DOMAIN_NOT_ACTIVE
  DOMAIN_NOT_EXISTS
  WORKFLOW_ALREADY_RUNNING
  WORKFLOW_NOT_EXISTS
  WORKFLOW_ALREADY_COMPLETED
  UNCATEGORIZED
}

enum GetTaskFailedCause {
  SERVICE_BUSY
  TIMEOUT
  SHARD_OWNERSHIP_LOST
  UNCATEGORIZED
}

struct CrossClusterTaskInfo {
  10: optional string domainID
  20: optional string workflowID
  30: optional string runID
  40: optional CrossClusterTaskType taskType
  50: optional i16 taskState
  60: optional i64 (js.type = "Long") taskID
  70: optional i64 (js.type = "Long") visibilityTimestamp
}

struct CrossClusterStartChildExecutionRequestAttributes {
  10: optional string targetDomainID
  20: optional string requestID
  30: optional i64 (js.type = "Long") initiatedEventID
  40: optional StartChildWorkflowExecutionInitiatedEventAttributes initiatedEventAttributes
  // targetRunID is for scheduling first decision task
  // targetWorkflowID is available in initiatedEventAttributes
  50: optional string targetRunID
  60: optional map<string, string> partitionConfig
}

struct CrossClusterStartChildExecutionResponseAttributes {
  10: optional string runID
}

struct CrossClusterCancelExecutionRequestAttributes {
  10: optional string targetDomainID
  20: optional string targetWorkflowID
  30: optional string targetRunID
  40: optional string requestID
  50: optional i64 (js.type = "Long") initiatedEventID
  60: optional bool childWorkflowOnly
}

struct CrossClusterCancelExecutionResponseAttributes {
}

struct CrossClusterSignalExecutionRequestAttributes {
  10: optional string targetDomainID
  20: optional string targetWorkflowID
  30: optional string targetRunID
  40: optional string requestID
  50: optional i64 (js.type = "Long") initiatedEventID
  60: optional bool childWorkflowOnly
  70: optional string signalName
  80: optional binary signalInput
  90: optional binary control
}

struct CrossClusterSignalExecutionResponseAttributes {
}

struct CrossClusterRecordChildWorkflowExecutionCompleteRequestAttributes {
  10: optional string targetDomainID
  20: optional string targetWorkflowID
  30: optional string targetRunID
  40: optional i64 (js.type = "Long") initiatedEventID
  50: optional HistoryEvent completionEvent
}

struct CrossClusterRecordChildWorkflowExecutionCompleteResponseAttributes {
}

struct ApplyParentClosePolicyAttributes {
  10: optional string childDomainID
  20: optional string childWorkflowID
  30: optional string childRunID
  40: optional ParentClosePolicy parentClosePolicy
}

struct ApplyParentClosePolicyStatus {
  10: optional bool completed
  20: optional CrossClusterTaskFailedCause failedCause
}

struct ApplyParentClosePolicyRequest {
  10: optional ApplyParentClosePolicyAttributes child
  20: optional ApplyParentClosePolicyStatus status
}

struct CrossClusterApplyParentClosePolicyRequestAttributes {
  10: optional list<ApplyParentClosePolicyRequest> children
}

struct ApplyParentClosePolicyResult {
  10: optional ApplyParentClosePolicyAttributes child
  20: optional CrossClusterTaskFailedCause failedCause
}

struct CrossClusterApplyParentClosePolicyResponseAttributes {
  10: optional list<ApplyParentClosePolicyResult> childrenStatus
}

struct CrossClusterTaskRequest {
  10: optional CrossClusterTaskInfo taskInfo
  20: optional CrossClusterStartChildExecutionRequestAttributes startChildExecutionAttributes
  30: optional CrossClusterCancelExecutionRequestAttributes cancelExecutionAttributes
  40: optional CrossClusterSignalExecutionRequestAttributes signalExecutionAttributes
  50: optional CrossClusterRecordChildWorkflowExecutionCompleteRequestAttributes recordChildWorkflowExecutionCompleteAttributes
  60: optional CrossClusterApplyParentClosePolicyRequestAttributes applyParentClosePolicyAttributes
}

struct CrossClusterTaskResponse {
  10: optional i64 (js.type = "Long") taskID
  20: optional CrossClusterTaskType taskType
  30: optional i16 taskState
  40: optional CrossClusterTaskFailedCause failedCause
  50: optional CrossClusterStartChildExecutionResponseAttributes startChildExecutionAttributes
  60: optional CrossClusterCancelExecutionResponseAttributes cancelExecutionAttributes
  70: optional CrossClusterSignalExecutionResponseAttributes signalExecutionAttributes
  80: optional CrossClusterRecordChildWorkflowExecutionCompleteResponseAttributes recordChildWorkflowExecutionCompleteAttributes
  90: optional CrossClusterApplyParentClosePolicyResponseAttributes applyParentClosePolicyAttributes
}

struct GetCrossClusterTasksRequest {
  10: optional list<i32> shardIDs
  20: optional string targetCluster
}

struct GetCrossClusterTasksResponse {
  10: optional map<i32, list<CrossClusterTaskRequest>> tasksByShard
  20: optional map<i32, GetTaskFailedCause> failedCauseByShard
}

struct RespondCrossClusterTasksCompletedRequest {
  10: optional i32 shardID
  20: optional string targetCluster
  30: optional list<CrossClusterTaskResponse> taskResponses
  40: optional bool fetchNewTasks
}

struct RespondCrossClusterTasksCompletedResponse {
  10: optional list<CrossClusterTaskRequest> tasks
}

enum IsolationGroupState {
  INVALID,
  HEALTHY,
  DRAINED,
}

struct IsolationGroupPartition {
  10: optional string name
  20: optional IsolationGroupState state
}

struct IsolationGroupConfiguration {
  10: optional list<IsolationGroupPartition> isolationGroups
}

struct AsyncWorkflowConfiguration {
  10: optional bool enabled
  // PredefinedQueueName is the name of the predefined queue in cadence server config's asyncWorkflowQueues
  20: optional string predefinedQueueName
  // queueType is the type of the queue if predefined_queue_name is not used
  30: optional string queueType
  // queueConfig is the configuration for the queue if predefined_queue_name is not used
  40: optional DataBlob queueConfig
}

/**
* Any is a logical duplicate of google.protobuf.Any.
*
* The intent of the type is the same, but it is not intended to be directly
* compatible with google.protobuf.Any or any Thrift equivalent - this blob is
* RPC-type agnostic by design (as the underlying data may be transported over
* proto or thrift), and the data-bytes may be in any encoding.
*
* This is intentionally different from DataBlob, which supports only a handful
* of known encodings so it can be interpreted everywhere.  Any supports literally
* any contents, and needs to be considered opaque until it is given to something
* that is expecting it.
*
* See ValueType to interpret the contents.
**/
struct Any {
  // Type-string describing value's contents, and intentionally avoiding the
  // name "type" as it is often a special term.
  // This should usually be a hard-coded string of some kind.
  10: optional string ValueType
  // Arbitrarily-encoded bytes, to be deserialized by a runtime implementation.
  // The contents are described by ValueType.
  20: optional binary Value
}

struct AutoConfigHint {
  10: optional bool enableAutoConfig
  20: optional i64 pollerWaitTimeInMs
}

struct QueueState {
  10: optional map<i64, VirtualQueueState> virtualQueueStates
  20: optional TaskKey exclusiveMaxReadLevel
}

struct VirtualQueueState {
  10: optional list<VirtualSliceState> virtualSliceStates
}

struct VirtualSliceState {
  10: optional TaskRange taskRange
  20: optional Predicate predicate
}

struct TaskRange {
  10: optional TaskKey inclusiveMin
  20: optional TaskKey exclusiveMax
}

struct TaskKey {
  10: optional i64 scheduledTimeNano
  20: optional i64 taskID
}

struct ActiveClusterSelectionPolicy {
  10: optional ActiveClusterSelectionStrategy strategy

  // sticky_region is the region sticky if strategy is ACTIVE_CLUSTER_SELECTION_STRATEGY_REGION_STICKY
  // This is the default strategy for active-active domains and region would be set to receiver cluster's region if not specified.
  20: optional string stickyRegion

  // external_entity_type/external_entity_key is the type/key of the external entity if strategy is ACTIVE_CLUSTER_SELECTION_STRATEGY_EXTERNAL_ENTITY
  // external entity type must be one of the supported types in active cluster manager. Custom ones can be added by implementing the corresponding interface.
  30: optional string externalEntityType
  40: optional string externalEntityKey
}

enum ActiveClusterSelectionStrategy {
  REGION_STICKY,
  EXTERNAL_ENTITY,
}

enum PredicateType {
  Universal,
  Empty,
  DomainID,
}

struct UniversalPredicateAttributes {}

struct EmptyPredicateAttributes {}

struct DomainIDPredicateAttributes {
  10: optional list<string> domainIDs
  20: optional bool isExclusive
}

struct Predicate {
  10: optional PredicateType predicateType
  20: optional UniversalPredicateAttributes universalPredicateAttributes
  30: optional EmptyPredicateAttributes emptyPredicateAttributes
  40: optional DomainIDPredicateAttributes domainIDPredicateAttributes
}
