This is my Git configuration.

It mainly contains a set of handy aliases descibed below:

 ### Remove branch
 * `rab` - Remove all branches except `develop`

### Log
* `ll` - Consise pretty log showing the 10 latest commits
* `lll` - Consise pretty log showing all commits
* `lgg` - Consise pretty log showing branch graph
* `lgcf <file>` - Consise pretty log showing all commits that affected the current file
* `lgb` - Consise pretty log showing all commits on the current branch (since branched from `master`)

### Diff
* `dn` - Only show filenames

### Rebase
* `rom` - Rebase on `origin/master`
* `rod` - Rebase on `origin/develop`
* `ri` - Interactive rebase
* `ri2` - Interactive rebase on the latest two commits (also support for ri3 - ri10)

### Push
* `puf` - Push forcefully
