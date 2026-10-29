"""Public reference collector for a bounded operational log snapshot."""

from __future__ import annotations

import json
import os
import pathlib
import time
import urllib.request


def read_tail(path: pathlib.Path, limit: int = 200) -> list[str]:
    if not path.exists():
        return []
    return path.read_text(encoding="utf-8", errors="replace").splitlines()[-limit:]


def main() -> None:
    source = pathlib.Path(os.getenv("LOG_SOURCE", "./sample.log"))
    endpoint = os.getenv("API_URL", "http://localhost:3333/api/v1/ingest/logs")
    token = os.getenv("COLLECTOR_TOKEN", "")
    payload = {
        "source": os.getenv("SOURCE_LABEL", "example-service"),
        "captured_at": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "lines": read_tail(source),
    }
    request = urllib.request.Request(
        endpoint,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            **({"Authorization": f"Bearer {token}"} if token else {}),
        },
        method="POST",
    )
    with urllib.request.urlopen(request, timeout=15) as response:
        response.read()


if __name__ == "__main__":
    main()
