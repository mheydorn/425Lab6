# 1 "lab4_app.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "lab4_app.c"






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
# 8 "lab4_app.c" 2
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
# 9 "lab4_app.c" 2
# 1 "lab6defs.h" 1
# 9 "lab6defs.h"
struct msg
{
    int tick;
    int data;
};
# 10 "lab4_app.c" 2




struct msg MsgArray[20];

int ATaskStk[512];
int BTaskStk[512];
int STaskStk[512];

int GlobalFlag;

void *MsgQ[10];
YKQ *MsgQPtr;

void ATask(void)
{
    struct msg *tmp;
    int min, max, count;

    min = 100;
    max = 0;
    count = 0;

    while (1)
    {
        tmp = (struct msg *) YKQPend(MsgQPtr);


        if (tmp->tick != count+1)
        {
            print("! Dropped msgs: tick ", 21);
            if (tmp->tick - (count+1) > 1) {
                printInt(count+1);
                printChar('-');
                printInt(tmp->tick-1);
                printNewLine();
            }
            else {
                printInt(tmp->tick-1);
                printNewLine();
            }
        }


        count = tmp->tick;


        if (tmp->data < min)
            min = tmp->data;
        if (tmp->data > max)
            max = tmp->data;


        print("Ticks: ", 7);
        printInt(count);
        print("\t", 1);
        print("Min: ", 5);
        printInt(min);
        print("\t", 1);
        print("Max: ", 5);
        printInt(max);
        printNewLine();
    }
}

void BTask(void)
{
    int busycount, curval, j, flag, chcount;
    unsigned tickNum;

    curval = 1001;
    chcount = 0;

    while (1)
    {
        YKDelayTask(2);

        if (GlobalFlag == 1)
        {
            YKEnterMutex();
            busycount = YKTickNum;
            YKExitMutex();

            while (1)
            {
                YKEnterMutex();
                tickNum = YKTickNum;
                YKExitMutex();
                if(tickNum >= busycount + 5) break;

                curval += 2;
                flag = 0;
                for (j = 3; (j*j) < curval; j += 2)
                {
                    if (curval % j == 0)
                    {
                        flag = 1;
                        break;
                    }
                }
                if (!flag)
                {
                    printChar('.');
                    if (++chcount > 75)
                    {
                        printNewLine();
                        chcount = 0;
                    }
                }
            }
            printNewLine();
            chcount = 0;
            GlobalFlag = 0;
        }
    }
}

void STask(void)
{
    unsigned max, switchCount, idleCount;
    int tmp;

    YKDelayTask(1);
    printString("Welcome to the YAK kernel\r\n");
    printString("Determining CPU capacity\r\n");
    YKDelayTask(1);
    YKIdleCount = 0;
    YKDelayTask(5);
    max = YKIdleCount / 25;
    YKIdleCount = 0;

    YKNewTask(BTask, (void *) &BTaskStk[512], 10);
    YKNewTask(ATask, (void *) &ATaskStk[512], 20);

    while (1)
    {
        YKDelayTask(20);

        YKEnterMutex();
        switchCount = YKCtxSwCount;
        idleCount = YKIdleCount;
        YKExitMutex();

        printString("<<<<< Context switches: ");
        printInt((int)switchCount);
        printString(", CPU usage: ");
        tmp = (int) (idleCount/max);
        printInt(100-tmp);
        printString("% >>>>>\r\n");

        YKEnterMutex();
        YKCtxSwCount = 0;
        YKIdleCount = 0;
        YKExitMutex();
    }
}

void main(void)
{
    YKInitialize();


    GlobalFlag = 0;
    MsgQPtr = YKQCreate(MsgQ, 10);
    YKNewTask(STask, (void *) &STaskStk[512], 30);

    YKRun();
}
