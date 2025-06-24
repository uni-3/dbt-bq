# Makefile for dbt project with elementary notifications

DBT = dbt
EDR = edr
SLACK_WEBHOOK_URL_FROM_VARS = "https://hooks.slack.com/services/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"
SLACK_CHANNEL_NAME_FROM_VARS = "notify"

# dbt elementary のテスト結果を Slack に通知する
notify-slack:
	-$(DBT) test --target dev
	$(EDR) monitor --slack-webhook $(SLACK_WEBHOOK_URL_FROM_VARS) --slack-channel-name $(SLACK_CHANNEL_NAME_FROM_VARS) --project-dir . --profiles-dir . --profile-target dev --days-back 1 --group-by alert

# 通常のテスト実行 (通知なし)
test:
	$(DBT) test --target dev

.PHONY: notify-slack test
