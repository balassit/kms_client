workflow "check, sdist, and upload" {
  on = "push"
  resolves = ["upload"]
}

action "check" {
  uses = "balassit/python-actions/setup-py/3.7@1.1"
  args = "check"
  env = {
    WORKDIR = "example"
  }
}

action "sdist" {
  uses = "balassit/python-actions/setup-py/3.7@1.1"
  args = "sdist"
  env = {
    WORKDIR = "example"
  }
  needs = "check"
}

action "upload" {
  uses = "balassit/python-actions/twine@1.1"
  args = "upload ./example/dist/ross-pypi-test-*.tar.gz"
  secrets = ["TWINE_PASSWORD", "TWINE_USERNAME"]
  needs = "sdist"
}
