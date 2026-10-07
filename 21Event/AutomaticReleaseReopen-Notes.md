# Automatic Reopen and Release for Sales Orders

## Goal

When a user edits a sales line on a released sales document:

1. Reopen the released document so the edit is allowed.
2. Release the document again after the line modification.

The implementation being discussed is in [Cod60140.AutomaticReleaseReopen.al](./src/codeunit/Cod60140.AutomaticReleaseReopen.al).

## Issues identified and changes made

### 1. The release marker needs to survive between subscriber calls

The code records the sales document number in `ReleasedSalesOrderNo` in one event subscriber and reads it in another. A normal codeunit instance is not a safe way to share that state across independent subscriber invocations.

**Change made:** `SingleInstance = true` was added so the codeunit's variables are retained for the session. The code also records `ReleasedSalesOrderType` because a document number alone is not a sufficiently precise match.

**Important:** This relies on both subscriber calls running in the same Business Central session. It does not prove that the expected after-modify event will be the next event to consume the marker.

### 2. The marker is cleared before calling release

The release routine can cause table events of its own. If the marker remains set while `PerformManualRelease` runs, a nested sales-line modification can enter the same subscriber and trigger another release attempt.

**Change made:** The marker is cleared immediately before `PerformManualRelease` is called.

**Remaining risk:** If a sales-line modification occurs during `Reopen` (before the user's edit has completed), that event could match and clear the marker. In that case, the later user edit will not be followed by a release. The correct trigger point must be verified against the actual event sequence in the target Business Central version.

### 3. The header is looked up again before releasing

The after-modify subscriber gets the sales header using both the document type and document number, then releases only if its status is `Open`.

This avoids attempting a release if the header cannot be found or is no longer open. The code does not suppress errors from `PerformManualRelease`, so Business Central can report an actual release validation error.

## Current code behavior

The current code subscribes to `Sales Line.OnBeforeTestStatusOpen` to reopen the header if it is released. It remembers the document identity, then subscribes to `Sales Line.OnAfterModifyEvent` to find that document and call `PerformManualRelease` if it is open.

There are diagnostic `Message` calls in the current AL file. They show the header status before and after reopening, and after the release attempt. They are useful while testing, but they interrupt the user and should be removed once troubleshooting is complete.

## Verification status

The AL package build succeeded for a prior version of this code. That confirms compilation only; it does not confirm the order is released again in the Business Central client. The current version includes additional diagnostic messages, so build and test this exact version after publishing it.

Test with a released sales order in a development environment:

1. Confirm the first status message reports `Released`.
2. Confirm the status after `Reopen` reports `Open`.
3. Modify and save a sales line.
4. Confirm the final status message reports `Released`.
5. If step 4 does not happen, note which messages appear and capture any Business Central error. This indicates the after-modify subscriber did not match, the marker was consumed earlier, or the release routine rejected the document.

Do not treat a successful build as proof of runtime behavior. The exact event sequence and any release validations must be confirmed in the target environment.
