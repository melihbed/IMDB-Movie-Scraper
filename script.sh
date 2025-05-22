#!/bin/bash

# Target URL
URL="https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"

# Output file
OUTPUT_FILE="top_250_movies.html"

# Array of common User-Agents
USER_AGENTS=(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Safari/605.1.15"
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:124.0) Gecko/20100101 Firefox/124.0"
  "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36"
  "Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1"
)

# Pick a random User-Agent
RANDOM_AGENT=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}

# Download the page
curl -L "$URL" -o "$OUTPUT_FILE" \
  -A "$RANDOM_AGENT" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" \
  -H "Accept-Language: en-US,en;q=0.9" \
  -H "Connection: keep-alive" \
  -H "DNT: 1" \
  -H "Upgrade-Insecure-Requests: 1" \
  --compressed \
  --http2

echo "Downloaded $URL to $OUTPUT_FILE using User-Agent:"
echo "$RANDOM_AGENT"

