workflow "check, sdist, unit-test, and upload" {
  on = "push"
  resolves = ["uni-test"]
}
action "unit-test" {
  uses = "balassit/python-actions/pytest@1.0"
  args = "pytest ./tests/unit-tests"
}
