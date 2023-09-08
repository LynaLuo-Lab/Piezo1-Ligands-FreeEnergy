import sys
import re

prefix = 'fep'
#step = int(sys.argv[1])
step = 4
num_replica = 128
offset = 0
if step == 0:
    offset = 0
final_step = -1
if len(sys.argv) > 4:
    final_step = int(sys.argv[2])

history_fps = [open('output_site/%d/%s.job%d.%d.history' % (i, prefix, step, i)) for i in range(num_replica)]
colvars_fps = [open('output_site/%d/%s.job%d.%d.wham.fepout' % (i, prefix, step, i)) for i in range(num_replica)]

sorted_history_fps = [open('output_off/%d/%s.job%d.%d.sort.history' % (i, prefix, step, i), 'w') for i in range(num_replica)]
sorted_colvars_fps = [open('output_off/%d/%s.job%d.%d.sort.wham.fepout' % (i, prefix, step, i), 'w') for i in range(num_replica)]

cnt = 0
timestamp = [0 for i in range(num_replica)]
rep = [i for i in range(num_replica)]
while 1:
    for i in range(num_replica):
        try:
            if timestamp[i] > 0 and timestamp[i] > min(_timestamp): continue # wait if your history is ahead of others
            line = history_fps[i].readline()
            time, rep[i] = map(int, line.split()[:2])
            next_rep = int(line.split()[2])
            doswap = int(line.split()[-1])
            timestamp[i] = time
        except:
            time = max(timestamp)
            timestamp[i] = time
            final_step = timestamp[i]
            
        sorted_history_fps[rep[i]].write(line)

        #while 1:
        #    line = colvars_fps[i].readline()
        #    if line.startswith('#'): continue
        #    if not line.strip(): break
        #    sorted_colvars_fps[rep[i]].write(line)
        #    if line.strip().split()[1] != str(time+offset): continue
        #    break

        if doswap: rep[i] = next_rep

    time = min(timestamp)
    _timestamp = [timestamp[i] for i in range(num_replica)]
    if final_step > 0 and time >= final_step: break
    print time

