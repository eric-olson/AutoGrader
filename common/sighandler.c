/*
   Code to produce a backtrace when a serious error (SEGV, etc.) occurs.

   THIS CODE IS NOT PORTABLE!!!  This code uses an UNDOCUMENTED structure 
   (uc_mcontext) in the GNU libc's implementation of the ucontext_t structure
   to retrieve the stack pointer (from the instruction pointer register).  As 
   written, this code works correctly with GNU libc.so.6 on the x86_64 
   architecture.

   THIS CODE REQUIRES GNU LIBC: uses the backtrace() and backtrace_symbols_fd()
   functions.

   This code is based on code from:
   http://stackoverflow.com/questions/77005/how-to-generate-a-stacktrace-when-my-gcc-c-app-crashes
   and
   http://www.linuxjournal.com/files/linuxjournal.com/linuxjournal/articles/063/6391/6391l3.html

   For more information on the ucontext, try "man getcontext".  Details of the
   mcontext_t struct used for the uc_mcontext field of the ucontext can be
   found by digging around in ucontext.h or one of its includes.
*/

#include <signal.h>
#include <execinfo.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <ucontext.h>
#include <stdio.h>
#include <string.h>

// max number of calls listed in backtrace (1 or 2 of these will be lopped
// off, so you won't see quite this many in the output).
#define MAX_TRACE 22

void backtrace_exit(int signum, siginfo_t * info, void *ucontext) {

	fprintf(stderr, "Received signal %d (%s); generating backtrace.\n",
		signum, strsignal(signum));

	// get the call addresses for the backtrace
	void *trace[MAX_TRACE];
	int size = backtrace(trace, MAX_TRACE);

	// Get program counter - USES UNDOCUMENTED GNU LIBC STRUCTURES
	ucontext_t *uc = (ucontext_t *) ucontext;
	void *pc = (void *)uc->uc_mcontext.gregs[REG_RIP];

	// first couple of calls will be for this function and for sigaction,
	// which we don't want.  Replace the second with the call location of
	// the signal, and ignore the first one.
	trace[1] = pc;
	int skip = 1;
	if (trace[1] == trace[2]) // sometimes pc is a duplicate of entry 2
		skip = 2;

	// output backtrace into a file.  This is slightly safer than the
	// alternate method, which uses malloc.  As described above, we
	// ignore the first entry. 
	int fd = open("backtrace.txt", O_WRONLY | O_CREAT | O_TRUNC, S_IRWXU);
	backtrace_symbols_fd(trace + skip, size - skip, fd);
	close(fd);

	exit(1);
}

#define ALT_STACK_SIZE 65536

void install_backtrace_handler() {
	// this bit lets us use a different stack for the signal handler,
	// which hopefully keeps it working in the event of a stack overflow
	// Note that the typical value of SIGSTKSZ for the alternate stack
	// is *TOO SMALL* for our handler!
	stack_t ss;
        ss.ss_flags = 0;
	ss.ss_sp = malloc(ALT_STACK_SIZE);
        ss.ss_size = ALT_STACK_SIZE;
	if(sigaltstack(&ss, NULL) != 0) { perror("sigaltstack"); }

	struct sigaction sa;
	sigfillset(&sa.sa_mask);
	sa.sa_sigaction = backtrace_exit;
	sa.sa_flags = SA_ONSTACK | SA_SIGINFO;

	if(sigaction(SIGSEGV, &sa, NULL) != 0) perror("sigaction");
	if(sigaction(SIGBUS,  &sa, NULL) != 0) perror("sigaction");
        if(sigaction(SIGFPE,  &sa, NULL) != 0) perror("sigaction");
	if(sigaction(SIGILL,  &sa, NULL) != 0) perror("sigaction");
        if(sigaction(SIGABRT, &sa, NULL) != 0) perror("sigaction");
}
