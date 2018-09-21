#!/usr/bin/env bash

echo "Will produce a runnable ubuntu file from sources"

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd $ROOT

echo "#!/usr/bin/env bash
$(cat utils.sh ubuntu.sh)" > ../ubuntu.sh
chmod +x ../ubuntu.sh

echo " [✔]"
