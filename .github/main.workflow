workflow "check, sdist, unit-test, and upload" {
  on = "push"
  resolves = ["unit-test"]
}
action "unit-test" {
  uses = "balassit/python-actions/pytest@1.2"
  args = "pytest ./tests/unit-tests"
}
