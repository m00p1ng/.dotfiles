#!/usr/bin/env python3
import subprocess
import sys
import os
import time
import glob


def is_pass(file1, file2):
    l1 = l2 = ' '
    with open(file1, 'r') as f1, open(file2, 'r') as f2:
        while l1 != '' and l2 != '':
            l1 = f1.readline()
            l2 = f2.readline()
            if l1 != l2:
                return False
    return True


def print_result(result, case, time):
    if result:
        print(('\033[0;37;40m* case %s \033[1;32;40m[PASS]\033[0m %.3f seconds') % (case, time))
    else:
        print('\033[0;37;40m* case %s \033[1;31;40m[FAIL]\033[0m' % case)


def cpp_fileHandle(program, name_in, name_out):
    in_file = open(name_in, 'r')
    out_file = open(name_out, 'w')
    start = time.time()
    subprocess.call('./a.out', shell=True, stdin=in_file, stdout=out_file)
    total_time = time.time()-start
    in_file.close()
    out_file.close()
    return total_time


def test_case(program, case):
    name_in = ('testcase/%s_%s.in') % (program, case)
    name_out = ('testcase/%s_%s.out') % (program, case)
    name_out_tmp = ('testcase/%s_%s.out.tmp') % (program, case)

    if os.path.exists(name_in) and os.path.exists(name_out):
        time = cpp_fileHandle(program, name_in, name_out_tmp)
        result = is_pass(name_out, name_out_tmp)
        print_result(result, case, time)
        os.remove(name_out_tmp)
    else:
        print('\033[0;37;40m* case %s \033[1;31;40m[SOME FILES ARE MISSING]\033[0m' % case)


def test_all_case(program, total):
    print('\033[0;37;40m===== Program : %s =====\033[0m' % program)
    for i in range(1, total+1):
        test_case(program, i)


def totalcase(program):
    s = glob.glob('testcase/%s*' % program)
    s.sort(reverse=True)
    s = os.path.splitext(s[0])
    total = s[0].replace('testcase/%s_' % program, '')
    return int(total)


def main():
    program = os.path.splitext(sys.argv[1])[0]
    try:
        subprocess.check_call(['g++', '%s.cpp' % program])
        if os.path.exists('testcase'):
            total = totalcase(program)
            test_all_case(program, total)
            os.remove('a.out')
        else:
            print('\033[0;37;40mFolder testcase not found.\033[0m')
    except subprocess.CalledProcessError:
        print('\033[1;31;40m[Compiled error]\033[0m')


if __name__ == '__main__':
    main()
