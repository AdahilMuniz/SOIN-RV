#define PRINT_ADDR 0x000000004

void print_hello();

int main () {
    print_hello();
    return 0;
}

void print_hello(){
    int * addr;
    int i;
    addr  = (int*)PRINT_ADDR;

    
    *(addr+0x00) = 'H';
    *(addr+0x01) = 'E';
    *(addr+0x02) = 'L';
    *(addr+0x03) = 'L';
    *(addr+0x04) = 'O';
    *(addr+0x05) = ' ';
    *(addr+0x06) = 'W';
    *(addr+0x07) = 'O';
    *(addr+0x08) = 'R';
    *(addr+0x09) = 'L';
    *(addr+0x0A) = 'D';
}