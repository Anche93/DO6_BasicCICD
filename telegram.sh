#!/bin/bash

TELEGRAM_BOT_TOKEN="..." # указать полученный токен телеграм бота
TELEGRAM_CHAT_ID="..." # указать полученный ID телеграм чата
TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"

case "$CI_JOB_STATUS" in
    success)
        STATUS="✅ SUCCESS"
        ;;
    failed)
        STATUS="❌ FAILED"
        ;;
    *)
        STATUS="ℹ️ Pipeline status: $CI_JOB_STATUS"
        ;;
esac

TEXT="Pipeline status: $1 $STATUS%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG"

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_CHAT_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
