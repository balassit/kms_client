workflow "check, sdist, unit-test, and upload" {
  on = "push"
  resolves = ["upload"]
}

action "check" {
  uses = "balassit/python-actions/setup-py/3.7@1.0"
  args = "check"
}

action "sdist" {
  uses = "balassit/python-actions/setup-py/3.7@1.0"
  args = "sdist bdist_wheel"
  needs = "check"
}

action "unit-test" {
  uses = "balassit/python-actions/pytest@1.0"
  args = "pytest ./tests/unit-tests"
  needs = "sdist"
}

action "filter-to-branch-master" {
  uses = "actions/bin/filter@master"
  needs = ["unit-test"]
  args = "branch master"
}

action "upload" {
  uses = "balassit/python-actions/twine@1.0"
  args = "upload ./dist/kms_client-*.tar.gz"
  secrets = ["TWINE_PASSWORD", "TWINE_USERNAME"]
  needs = "filter-to-branch-master"
}
