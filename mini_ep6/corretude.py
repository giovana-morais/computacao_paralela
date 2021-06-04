# Nome: Giovana Vieira de Morais
# NUSP: 11921908
import multiprocessing
from random import shuffle
from subprocess import Popen, PIPE
import sys

def run_sleep_sort(number_list):
    correct = 0
    incorrect = 0
    nl = number_list
    for i in range(int(N)):
        shuffle(nl)
        str_ = " ".join(nl)

        p = Popen(f'./{executavel} {str_}', shell=True, stdout=PIPE)
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
    right_output = number_list
    executavel = sys.argv[1]
    N = sys.argv[2]

    p = multiprocessing.Process(target=run_sleep_sort, args=(number_list,))
    p.start()
    p.join()
