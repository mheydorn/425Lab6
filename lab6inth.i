# 1 "lab6inth.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "lab6inth.c"
# 1 "lab6defs.h" 1
# 9 "lab6defs.h"
struct msg
{
    int tick;
    int data;
};
# 2 "lab6inth.c" 2
# 1 "yakk.h" 1
# 1 "clib.h" 1



void print(char *string, int length);
void printNewLine(void);
void printChar(char c);
void printString(char *string);


void printInt(int val);
void printLong(long val);
void printUInt(unsigned val);
void printULong(unsigned long val);


void printByte(char val);
void printWord(int val);
void printDWord(long val);


void exit(unsigned char code);


void signalEOI(void);
# 2 "yakk.h" 2
# 1 "/usr/lib/gcc/x86_64-redhat-linux/5.3.1/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/x86_64-redhat-linux/5.3.1/include/stdint.h" 3 4
# 1 "/usr/include/stdint.h" 1 3 4
# 25 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 365 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 410 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 411 "/usr/include/sys/cdefs.h" 2 3 4
# 366 "/usr/include/features.h" 2 3 4
# 389 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 390 "/usr/include/features.h" 2 3 4
# 26 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/bits/wchar.h" 1 3 4
# 27 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/stdint.h" 2 3 4
# 36 "/usr/include/stdint.h" 3 4

# 36 "/usr/include/stdint.h" 3 4
typedef signed char int8_t;
typedef short int int16_t;
typedef int int32_t;

typedef long int int64_t;







typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;

typedef unsigned int uint32_t;



typedef unsigned long int uint64_t;
# 65 "/usr/include/stdint.h" 3 4
typedef signed char int_least8_t;
typedef short int int_least16_t;
typedef int int_least32_t;

typedef long int int_least64_t;






typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;

typedef unsigned long int uint_least64_t;
# 90 "/usr/include/stdint.h" 3 4
typedef signed char int_fast8_t;

typedef long int int_fast16_t;
typedef long int int_fast32_t;
typedef long int int_fast64_t;
# 103 "/usr/include/stdint.h" 3 4
typedef unsigned char uint_fast8_t;

typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long int uint_fast64_t;
# 119 "/usr/include/stdint.h" 3 4
typedef long int intptr_t;


typedef unsigned long int uintptr_t;
# 134 "/usr/include/stdint.h" 3 4
typedef long int intmax_t;
typedef unsigned long int uintmax_t;
# 10 "/usr/lib/gcc/x86_64-redhat-linux/5.3.1/include/stdint.h" 2 3 4
# 3 "yakk.h" 2
# 12 "yakk.h"

# 12 "yakk.h"
extern unsigned YKIdleCount;

extern unsigned int nextTask;

extern unsigned int YKCtxSwCount;

extern unsigned ISRDepth;

extern unsigned YKTickNum;


typedef enum tasks{running,delayed,suspended} taskStates;

typedef struct YKSEM{
 int value;
}YKSEM;

typedef struct YKQ{
 void** start;
 unsigned size;
 unsigned inUse;
 unsigned id;
 YKSEM* semaphore;
 int front;
 int rear;
 int numberPendingOn;
}YKQ;

typedef struct TCB{
 unsigned int ip;

 unsigned int sp;
 unsigned int bp;

 unsigned ax;
 unsigned bx;
 unsigned cx;
 unsigned dx;
 unsigned si;
 unsigned di;
 unsigned es;
 unsigned ds;

 void * taskStack;
 unsigned int taskPriority;
 taskStates taskState;
 unsigned int id;
 unsigned int delayCount;
 struct TCB * nextTCB;
 struct TCB * prevTCB;
 unsigned inUse;
 YKSEM* pendingOn;

}TCB;

extern struct TCB TCBArray[15];

extern struct YKSEM YKSEMArray[30];

extern struct YKQ YKQArray[15];

YKQ *YKQCreate(void **start, unsigned size);

void *YKQPend(YKQ *queue);

void YKScheduler(int calledFromISR);

void YKDispatcher();

void dispatchHelper();

void YKEnterMutexHelper();

void YKExitMutexHelper();

void YKIdleTask();

void YKInitialize();

void YKNewTask();

void YKEnterMutex();

void YKExitMutex();

void YKRun();

void YKDelayTask(unsigned count);

void YKEnterISR();

void YKExitISR();

void YKTickHandler();

YKSEM* YKSemCreate(int initialValue);

void YKSemPend(YKSEM *semaphore);

void YKSemPost(YKSEM *semaphore);

int YKQPost(YKQ *queue, void *msg);
# 3 "lab6inth.c" 2
# 1 "clib.h" 1



void print(char *string, int length);
void printNewLine(void);
void printChar(char c);
void printString(char *string);


void printInt(int val);
void printLong(long val);
void printUInt(unsigned val);
void printULong(unsigned long val);


void printByte(char val);
void printWord(int val);
void printDWord(long val);


void exit(unsigned char code);


void signalEOI(void);
# 4 "lab6inth.c" 2

extern YKQ *MsgQPtr;
extern struct msg MsgArray[];
extern int GlobalFlag;

void myreset(void)
{
    exit(0);
}

void myisr(void)
{
    static int next = 0;
    static int data = 0;

    MsgArray[next].tick = YKTickNum;
    data = (data + 89) % 100;
    MsgArray[next].data = data;
    if (YKQPost(MsgQPtr, (void *) &(MsgArray[next])) == 0)
 printString("  TickISR: queue overflow! \n");
    else if (++next >= 20)
 next = 0;
}

void mykeyboard(void)
{
    GlobalFlag = 1;
}
