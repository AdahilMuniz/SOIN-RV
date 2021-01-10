#define PRINT_ADDR 0x000000004

void print_hello();

int main () {
    print_hello();
    return 0;
}

void print_hello(){
    
    *((int*)PRINT_ADDR+0x00) = 'H';
    *((int*)PRINT_ADDR+0x01) = 'E';
    *((int*)PRINT_ADDR+0x02) = 'L';
    *((int*)PRINT_ADDR+0x03) = 'L';
    *((int*)PRINT_ADDR+0x04) = 'O';
    *((int*)PRINT_ADDR+0x05) = ' ';
    *((int*)PRINT_ADDR+0x06) = 'W';
    *((int*)PRINT_ADDR+0x07) = 'O';
    *((int*)PRINT_ADDR+0x08) = 'R';
    *((int*)PRINT_ADDR+0x09) = 'L';
    *((int*)PRINT_ADDR+0x0A) = 'D';
}