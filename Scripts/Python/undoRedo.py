# -*- Mode: Python3; coding: utf-8; indent-tabs-mpythoode: nil; tab-width: 4 -*-
#
# Simple script to simulate Do/Undo.
#

actions = []
stackUndo = []
stackRedo = []


def Status(action, figure, origin, destiny):
    return [action, figure, origin, destiny]


def Reverse(status):
    if status[0] == "ADD":
        status[0] = "DEL"
        return status

    if status[0] == "DEL":
        status[0] = "ADD"
        return status

    if status[0] == "MOVE":
        temp = status[3]
        status[3]= status[2]
        status[2] = temp
    return status


def ActionRecord(status, isUndo=False):
    actions.append(status)
    
    if (not isUndo):
        stackUndo.append(Reverse(status.copy()))
        print("Action:", actions[-1])
    else:
        print("Act Undo:", actions[-1])

    print("stkUndo:", stackUndo)
    print("stkRedo:", stackRedo)


def Undo():
    if len(stackUndo) > 0:
        last = stackUndo.pop()
        stackRedo.append(Reverse(last.copy()))
        ActionRecord(last, True)
    else:
        print("Undo: empty!")


def Redo():
    if len(stackRedo) > 0:
        last = stackRedo.pop()
        # stackUndo.append(Reverse(last.copy()))
        ActionRecord(last)
    else:
        print("Redo: empty!")


def Add(figure):
    ActionRecord(Status("ADD", figure, [0,0], [0,0]))


def Mov(figure, origin, destiny):
    ActionRecord(Status("MOVE", figure, origin, destiny))


def Actions():
    print("ACTIONS:", actions)


def test():
    # Figures
    A = "A"
    B = "B"
    C = "C"

    # Actions
    Add(A)
    Add(B)
    Mov(A, [0,0], [10,10])
    Mov(A, [10,10], [55,55])
    Mov(B, [0,0], [111,111])
    Undo()
    Undo()
    Undo()
    Add(C)
    Undo()
    Undo()
    Undo()
    Redo()
    Redo()
    Redo()
    Redo()
    # Result
    Actions()


if __name__ == '__main__':
    test()