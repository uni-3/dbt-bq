# Makefile for dbt project with elementary notifications

DBT = dbt
EDR = edr

# .env ファイルが存在すれば読み込む
# (シェルコマンドの出力結果を無視するために `-` をつけています)
-include .env
# export $(shell sed 's/=.*//' .env) # こちらの方法でも可


# dbt elementary のテスト結果を Slack に通知する
notify-slack:
	@echo "Running dbt test with GOOGLE_APPLICATION_CREDENTIALS..."
	-GOOGLE_APPLICATION_CREDENTIALS=$(GOOGLE_APPLICATION_CREDENTIALS) $(DBT) test --target dev
	@echo "Running edr monitor with SLACK_WEBHOOK_URL..."
	SLACK_WEBHOOK_URL=$(SLACK_WEBHOOK_URL) $(EDR) monitor --slack-webhook $(SLACK_WEBHOOK_URL) --slack-channel-name "$(SLACK_CHANNEL_NAME)" --project-dir . --profiles-dir . --profile-target dev --days-back 1 --group-by alert

# 通常のテスト実行 (通知なし)
test:
	GOOGLE_APPLICATION_CREDENTIALS=$(GOOGLE_APPLICATION_CREDENTIALS) $(DBT) test --target dev

.PHONY: notify-slack test
