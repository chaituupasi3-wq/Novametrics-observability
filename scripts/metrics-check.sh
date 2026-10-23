#!/usr/bin/env bash
# ==============================================================================
# Script Name: metrics-check.sh
# Description: Verifies HTTP status of NovaMetrics portal endpoints.
# Exits with 0 on success, 1 on failure.
# ==============================================================================

set -euo pipefail

URL="http://localhost/index.html"
METRICS_URL="http://localhost/metrics.html"

echo "Running NovaMetrics portal health checks..."

# Check Index Page
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "  [PASS] Index dashboard is reachable (HTTP $HTTP_STATUS)"
else
    echo "  [FAIL] Index dashboard returned unexpected status: HTTP $HTTP_STATUS"
    exit 1
fi

# Check Metrics Page
METRICS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$METRICS_URL")
if [ "$METRICS_STATUS" -eq 200 ]; then
    echo "  [PASS] Metrics page is reachable (HTTP $METRICS_STATUS)"
else
    echo "  [FAIL] Metrics page returned unexpected status: HTTP $METRICS_STATUS"
    exit 1
fi

echo "All telemetry checks passed successfully!"
exit 0