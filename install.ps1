$PYTHON_PATH=$(Get-Command python).Path
$CONFIG="windows.conf.yaml"
$DOTBOT_DIR="dotbot"

$DOTBOT_BIN="bin/dotbot"
$BASEDIR=$(Split-Path $MyInvocation.MyCommand.Path)


Set-Location "${BASEDIR}"
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"

& "$PYTHON_PATH" "$BASEDIR/$DOTBOT_DIR/$DOTBOT_BIN" -d "$BASEDIR" -c "$CONFIG" @args
