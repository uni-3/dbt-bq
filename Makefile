# Makefile for dbt project with elementary notifications

DBT = dbt
EDR = edr

# dbt elementary のテスト結果を Slack に通知する
notify-slack:
	$(DBT) test
	$(EDR) send-report

# 通常のテスト実行 (通知なし)
test:
	$(DBT) test

.PHONY: notify-slack test
