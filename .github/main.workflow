workflow "check, sdist, and upload" {
  on = "push"
  resolves = ["upload"]
}

action "check" {
  uses = "ross/python-actions/setup-py/3.7@627646f"
  args = "check"
}

action "sdist" {
  uses = "ross/python-actions/setup-py/3.7@627646f"
  args = "sdist"
  needs = "check"
}

action "filter-to-branch-master" {
  uses = "actions/bin/filter@master"
  needs = ["sdist"]
  args = "branch master"
}

action "upload" {
  uses = "ross/python-actions/twine@627646f"
  args = "upload ./dist/kms_client-*.tar.gz"
  secrets = ["TWINE_PASSWORD", "TWINE_USERNAME"]
  needs = "filter-to-branch-master"
}
