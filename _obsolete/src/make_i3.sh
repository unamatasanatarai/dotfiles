#!/usr/bin/env bash

echo "Will produce a runnable i3wm from sources"

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cd $ROOT

echo "#!/usr/bin/env bash
$(cat utils.sh i3wm.sh)" > ../i3wm.sh
chmod +x ../i3wm.sh

echo " [✔]"
