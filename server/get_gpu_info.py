import os


ss = os.popen("nvidia-smi --query-gpu=memory.total,memory.used,utilization.memory,utilization.gpu --format=csv,noheader,nounits").read().strip().replace(',', '')

print(ss)