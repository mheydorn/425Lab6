#include "clib.h"
#include <stdint.h>

#ifndef NULL
#define NULL   ((void *) 0)
#endif

#define NUMBER_OF_TCBs 15
#define NUMBER_OF_SEMAPHORES 30
#define NUMBER_OF_QUEUES 15

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
	unsigned int ip; //Program counter for the next task to run 

	unsigned int sp;//2
	unsigned int bp;//4

	unsigned ax;//6
	unsigned bx;//8
	unsigned cx;//10
	unsigned dx;//12
	unsigned si;//14
	unsigned di;//16
	unsigned es;//18
	unsigned ds;//20

	void * taskStack;
	unsigned int taskPriority; //Higher number is higher priority
	taskStates taskState;
	unsigned int id;
	unsigned int delayCount;//30
	struct TCB * nextTCB;//32
	struct TCB * prevTCB;//32
	unsigned inUse; //Indicates whether this TCB is in use //34
	YKSEM* pendingOn;

}TCB;

extern struct TCB TCBArray[NUMBER_OF_TCBs];

extern struct YKSEM YKSEMArray[NUMBER_OF_SEMAPHORES];

extern struct YKQ YKQArray[NUMBER_OF_QUEUES];

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


