#!/usr/bin/env bash

# Validate input arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filename> <text>"
    if [ "$1" = "help" ]; then
        exit 0
    fi
    exit 1
fi

FILE_NAME=$1
TEXT=$2

# Validate OPENAI_API_KEY is set
if [ -z "$OPENAI_API_KEY" ]; then
    echo "Error: OPENAI_API_KEY environment variable is not set."
    exit 1
fi

# Make API call and get URL of generated image
RESPONSE=$(curl -s -H "Content-Type: application/json" \
                -H "Authorization: Bearer $OPENAI_API_KEY" \
                -d "{\"prompt\": \"$TEXT\", \"n\": 1, \"size\": \"1024x1024\" }" \
                https://api.openai.com/v1/images/generations)

if [ $? -ne 0 ]; then
    echo "Error: API call failed."
    exit 1
fi

URL=$(echo $RESPONSE | jq -r '.data[0].url')

if [ -z "$URL" ]; then
    echo "Error: Could not extract URL from API response."
    exit 1
fi

echo "Generated image URL: $URL"

# Download image and save with given filename
curl -s -o $FILE_NAME $URL

if [ $? -ne 0 ]; then
    echo "Error: Failed to download image from URL."
    exit 1
fi

echo "Image downloaded and saved as $FILE_NAME."
