function about() {
  echo "Autoformat shell script source code"
}

function depends() {
  if ! command -v brew >/dev/null; then
    echo "${RED}HomeBrew is required to install shfmt${NC}"
    return 1
  fi

  return 0
}

function install() {
  command brew install shfmt
  return $?
}

function uninstall() {
  command brew uninstall shfmt
  return $?
}