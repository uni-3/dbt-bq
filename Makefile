# Makefile for dbt project with elementary notifications

DBT = ./.venv/bin/dbt
EDR = ./.venv/bin/edr

# .env ファイルが存在すれば読み込む
# (シェルコマンドの出力結果を無視するために `-` をつけています)
-include .env
# export $(shell sed 's/=.*//' .env) # こちらの方法でも可


notify-slack: test init-elementary send-slack # update result tables then notify, dbt test and init elementary, then notify slack

send-slack: # send notiry to slack
	@echo "Running edr monitor with SLACK_WEBHOOK_URL..."
	$(EDR) monitor --slack-webhook $(SLACK_WEBHOOK_URL) --slack-channel-name $(SLACK_CHANNEL_NAME) --project-dir . --profiles-dir . --profile-target dev --days-back 1 --group-by alert

# 通常のテスト実行 (通知なし)
test: # run dbt test
	@echo "Running dbt test..."
	-$(DBT) test --target dev

# elementary の初期化
init-elementary: # init elementary
	@echo "Initializing elementary..."
	-$(DBT) run -s elementary --target dev

.PHONY: notify-slack test init-elementary

help: # show help
	@grep -h -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
