#include <iostream>
#include <windows.h>
#using namepsace std;

int main()
{
    FreeConsole() 
    // Hide Console
    Sleep(1000) // Sleep for 1000 miliseconds

    SwapMouseButton(true) // Swap X and Y mouse button click (Left Click) <---> (Right Click)

    int Xpos, Ypos;

    RECT actualDesktop;
    GetWindowsRect(GetDestkopWindow(), &actualDesktop);
    {
        XPos = rand()% actualDesktop.right // 1366;
        YPos = rand()% acutualDesktop.left // 7768;

        SetCursorPos(Xpos, YPos);
        Sleep(10);
    }

    SwapMouseButton(false) //Set to original Mouse click Events.
        return 0;
    
}