#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_BYTES_PER_CHAR 2
//#define VGA_BUFFER 0xb8000
#define totalBytes 4000

int terminal_position = 0;
char* const VGA_BUFFER = (char*) 0xb8000;

void clear_screen(){
	for(int i = 0; i < totalBytes; i += 2){
		VGA_BUFFER[i] = 0;
		VGA_BUFFER[i + 1] = 0x07;
	}
	terminal_position = 0;
}

void print_character(char c){
	VGA_BUFFER[terminal_position++] = c;
	VGA_BUFFER[terminal_position++] = 0x07;
}

void print_string(char* str){
	for(int i = 0; str[i] != 0; i++){
		print_character(str[i]);
	}
}

void print_line(char* str){
	print_string(str);
	terminal_position = (160 - (terminal_position % 160)) + terminal_position;
}


void main(){
        clear_screen();

        print_character('H');

        print_character('e');

        char* str = "llo World";

        print_line(str);

        char* str1 = "Today";

        print_string(str1);
}
