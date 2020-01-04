sma.ex5: sma.mq5
	-metaeditor64.exe /compile:sma.mq5 /log:log.log
	cat log.log
	rm log.log
