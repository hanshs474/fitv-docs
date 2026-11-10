#!/bin/bash
# redeploy.sh "<message>": commit, push, rebuild both Read the Docs projects (freeimagetovideo + fitv share this repo)
set -e; cd "$(dirname "$0")"
eval "$(python3 - <<'PY'
import os,re,shlex
for l in open(os.path.expanduser('~/.claude/.env')):
    m=re.match(r'^\s*(?:export\s+)?(GITHUB_TOKEN|RTD_API_TOKEN)=(.*)$',l.rstrip('\n'))
    if m: print('export %s=%s' % (m.group(1), shlex.quote(m.group(2).strip().strip('"'))))
PY
)"
git add -A; git -c user.name=hanshs474 -c user.email=hanshs474@users.noreply.github.com commit -qm "${1:-docs update}" || true
for i in 1 2 3; do HTTPS_PROXY=http://127.0.0.1:1082 git push -q "https://hanshs474:$GITHUB_TOKEN@github.com/hanshs474/fitv-docs.git" main && break; sleep 3; done
for s in freeimagetovideo fitv; do
  curl -s -o /dev/null -w "rtd $s build %{http_code}\n" -X POST -H "Authorization: Token $RTD_API_TOKEN" https://readthedocs.org/api/v3/projects/$s/versions/latest/builds/
done
