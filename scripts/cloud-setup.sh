#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
node -e 'const [major,minor]=process.versions.node.split(".").map(Number); if(major<22 || (major===22 && minor<13)){console.error("Node.js 22.13+ is required");process.exit(1)}'
for site in brightnest steel-oak sunday-crumb; do
  (cd "sites/$site" && npm ci)
done
