#!/usr/bin/env python3
import subprocess
import sys
import os
import time
import glob

color = {
    'close': '\033[0m',
    'red': '\033[1;31m',
    'green': '\033[1;32m',
    'yellow': '\033[1;33m',
    'white': '\033[1;37m',
}

FAIL = "%(red)s[FAIL]%(close)s"
PASS = "%(green)s[PASS]%(close)s"

program = os.path.splitext(sys.argv[1])[0]
debug = False
diff = False
allDiff = False
allTest = True
caseNum = 0


def escape_name(name):
    return name.replace(' ', '\\ ')


def is_pass(name_out, name_out_tmp):
    l1 = l2 = ' '
    out_file = open(name_out, 'r')
    out_tmp_file = open(name_out_tmp, 'r')
    while l1 != '' and l2 != '':
        l1 = out_file.readline()
        l2 = out_tmp_file.readline()
        if l1 != l2:
            return False
    return True


def print_result(result, case, time):
    outdict = {'time': time, 'case': case}
    outdict.update(color)

    if result:
        outdict['result_text'] = PASS
    else:
        outdict['result_text'] = FAIL

    msg = (('%(white)s* Test %(case)s %(result_text)s %(time).4f seconds') %
           (outdict)) % outdict

    print(msg)


def print_debug(name_in, name_out, name_out_tmp):
    if diff:
        print('=== Output ===')
        nl = 'nl -s\'.) \' -w4 -ba'
        # suppress = '' if allDiff else '-s'
        suppress = ''
        outdict = {'out': escape_name(name_out), 'out_tmp': escape_name(
            name_out_tmp), 'nl': nl, 'sup': suppress}
        cmd = 'sdiff <(%(nl)s %(out)s) <(%(nl)s %(out_tmp)s)' % outdict
        # if allDiff:
        # cmd = 'sdiff %(sup)s <(%(nl)s %(out)s) <(%(nl)s %(out_tmp)s)' % outdict
        # cmd = 'sdiff <(%(nl)s %(out)s) <(%(nl)s %(out_tmp)s)' % outdict
        # else:
        # cmd = 'icdiff --no-header -U 10 %(sup)s <(%(nl)s %(out)s) <(%(nl)s %(out_tmp)s)' % outdict
        subprocess.call(cmd, shell=True, executable='/bin/bash')
    else:
        print('=== Output ===')
        out_file = open(name_out_tmp, 'r')
        print(out_file.read())
        out_file.close()


def cpp_fileHandle(name_in, name_out):
    in_file = open(name_in, 'r')
    out_file = open(name_out, 'w')
    start = time.time()
    subprocess.call('./a.out', shell=True, stdin=in_file, stdout=out_file)
    total_time = time.time()-start
    in_file.close()
    out_file.close()
    return total_time


def test_case(case):
    name_in = ('testcase/%s_%s.in') % (program, case)
    name_out = ('testcase/%s_%s.out') % (program, case)
    name_out_tmp = ('testcase/%s_%s.out.tmp') % (program, case)

    if os.path.exists(name_in) and os.path.exists(name_out):
        time = cpp_fileHandle(name_in, name_out_tmp)
        result = is_pass(name_out, name_out_tmp)
        print_result(result, case, time)
        if debug and not result:
            print_debug(name_in, name_out, name_out_tmp)
        if not debug:
            os.remove(name_out_tmp)
    else:
        outdict = {'case': case}
        outdict.update(color)
        msg = '%(white)s* Test %(case)s %(red)s[SOME FILES ARE MISSING]%(close)s' % outdict
        print(msg)


def test_all_case(total_case):
    if total_case == 0:
        msg = '%(red)sTest case not found%(close)s' % color
        print(msg)
        return

    outdict = {'name': program}
    outdict.update(color)
    msg = '%(white)s===== Program : %(name)s =====%(close)s' % outdict
    print(msg)

    for i in range(1, total_case + 1):
        test_case(i)

    os.remove('a.out')


def test_one_case(caseNum):
    outdict = {'name': program}
    outdict.update(color)
    msg = '%(white)s===== Program : %(name)s =====%(close)s' % outdict
    print(msg)
    test_case(caseNum)


def totalcase():
    s = glob.glob('testcase/%s*.in' % program)
    if len(s) != 0:
        s.sort(reverse=True)
        s = os.path.splitext(s[0])
        total_case = s[0].replace('testcase/%s_' % program, '')
        return int(total_case)
    return 0


def option():
    global debug, diff, allDiff, allTest, caseNum

    if len(sys.argv) >= 2:
        for i in range(2, len(sys.argv)):
            if sys.argv[i] == 'debug':
                debug = True
            elif sys.argv[i] == 'diff':
                debug = True
                diff = True
            elif sys.argv[i] == 'all':
                allDiff = True
            elif sys.argv[i] == 'case':
                allTest = False
                i += 1
                caseNum = sys.argv[i]


def main():
    option()
    try:
        if debug and not diff:
            subprocess.check_call(
                ['g++', '-std=c++11', '-O2', '-DDEBUG', '%s.cpp' % program])
        else:
            subprocess.check_call(
                ['g++', '-std=c++11', '-O2', '%s.cpp' % program])
        if os.path.exists('testcase'):
            if allTest:
                test_all_case(totalcase())
            else:
                test_one_case(caseNum)
        else:
            msg = '%(white)sFolder testcase not found.%(close)s' % color
            print(msg)
    except subprocess.CalledProcessError:
        msg = '%(red)s[Compiled error]%(close)s' % color
        print(msg)
    except KeyboardInterrupt:
        msg = '\n%(red)s[Stop test by user]%(close)s' % color
        print(msg)


if __name__ == '__main__':
    main()
