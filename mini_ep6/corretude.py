# Nome: Giovana Vieira de Morais
# NUSP: 11921908
import multiprocessing
from random import shuffle
from subprocess import Popen, PIPE
import sys

def run_sleep_sort(number_list, right_output):
    correct = 0
    incorrect = 0
    for i in range(int(N)):
        shuffle(number_list)
        str_ = " ".join(number_list)

        command = f'./{executavel} {str_}'
        p = Popen(command, shell=True, stdout=PIPE)
        stdout, _ = p.communicate()

        stdout = stdout.decode('UTF-8').rstrip(" \n").split(" ")

        if stdout == right_output:
            correct += 1
        else:
            incorrect += 1

    if correct/(correct+incorrect) >= 0.9:
        print('ok')
    else:
        print('not ok');

    return {'correct': correct, 'incorrect': incorrect}

if __name__ == '__main__':
    number_list = [str(i) for i in range(1, 101)]
    right_output = [str(i) for i in range(1, 101)]
    executavel = sys.argv[1]
    N = sys.argv[2]

    run_sleep_sort(number_list, right_output)
