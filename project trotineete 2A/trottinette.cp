#line 1 "C:/Users/21621/Desktop/project/trottinette.c"





unsigned int accel_value, distance_value, speed_percent, current_speed;
unsigned short timer_100ms, braking;
char lcd_text[16];

unsigned short security = 1;
unsigned short rb0_last = 1;
unsigned short last_rb4_state = 1;
unsigned short charge_mode = 0;
unsigned short charge_done = 0;
unsigned short charge_timer_active = 0;
unsigned short rb4_press_count = 0;
unsigned int rb4_press_timeout = 0;
unsigned short show_history = 0;


unsigned short default_delay_active = 0;
unsigned int default_delay_counter = 0;

volatile unsigned short rb4_pressed = 0;
volatile unsigned short rb5_pressed = 0;
volatile unsigned int timer0_count = 0;
volatile unsigned short charge_complete = 0;

unsigned short dummy;


sbit LCD_RS at RC0_bit;
sbit LCD_EN at RC1_bit;
sbit LCD_D4 at RC4_bit;
sbit LCD_D5 at RC5_bit;
sbit LCD_D6 at RC6_bit;
sbit LCD_D7 at RC7_bit;

sbit LCD_RS_Direction at TRISC0_bit;
sbit LCD_EN_Direction at TRISC1_bit;
sbit LCD_D4_Direction at TRISC4_bit;
sbit LCD_D5_Direction at TRISC5_bit;
sbit LCD_D6_Direction at TRISC6_bit;
sbit LCD_D7_Direction at TRISC7_bit;




void interrupt() {

 if (TMR0IF_bit) {
 TMR0 = 6;
 timer0_count++;
 if (timer0_count >= 40) {
 charge_complete = 1;
 TMR0IE_bit = 0;
 }
 TMR0IF_bit = 0;
 }

 if (RBIF_bit) {
 dummy = PORTB;


 if (RB4_bit && !last_rb4_state) {
 rb4_pressed = 1;
 }
 last_rb4_state = RB4_bit;


 if (RB5_bit) {
 rb5_pressed = 1;
 }

 RBIF_bit = 0;
 }
}




void Timer0_Init() {
 OPTION_REG = 0b10000111;
 TMR0 = 6;
 TMR0IE_bit = 0;
}

void Timer0_Start() {
 timer0_count = 0;
 charge_complete = 0;
 TMR0 = 6;
 TMR0IE_bit = 1;
}




void Emergency_Stop() {

 braking = 1;
 RB7_bit = 1;
 RB1_bit = 1;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "OBSTACLE !");
 Lcd_Out(2, 1, "FREINAGE !");
 Delay_ms(50);

 while (current_speed > 0) {
 current_speed = (current_speed >= 20) ? current_speed - 20 : 0;

 RD0_bit = 0;
 RD1_bit = 0;
 PWM1_Set_Duty(current_speed * 255 / 100);

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"FREIN");
 Lcd_Out(2,1,"V : ");

 IntToStr(current_speed, lcd_text);
 Ltrim(lcd_text);
 Lcd_Out_CP(lcd_text);
 Lcd_Out_CP("%");

 Delay_ms(30);
 }

 PWM1_Set_Duty(0);
 RD0_bit = 0;
 RD1_bit = 0;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"ARRET");


 while (security) {
 distance_value = ADC_Read(1);
 if (distance_value >= 300) break;
 Delay_ms(100);
 }

 Lcd_Cmd(_LCD_CLEAR);
 RB7_bit = 0;
 RB1_bit = 0;
 braking = 0;
}




void main() {

 ADCON0 = 0x81;
 ADCON1 = 0xC4;
 TRISA = 0x03;
 TRISB = 0x71;
 PORTB = 0;
 TRISC = 0x00;
 PORTC = 0;
 TRISD = 0x00;
 PORTD = 0;
 NOT_RBPU_bit = 0;

 PWM1_Init(20000);
 PWM1_Start();
 PWM1_Set_Duty(0);

 Lcd_Init();
 Delay_ms(20);
 Lcd_Cmd(_LCD_CLEAR);

 Timer0_Init();

 rb0_last = RB0_bit;
 last_rb4_state = RB4_bit;

 dummy = PORTB;
 RBIF_bit = 0;

 GIE_bit = 1;
 PEIE_bit = 1;
 RBIE_bit = 1;

 rb4_pressed = 0;
 rb5_pressed = 0;

 Lcd_Out(1, 1, "SYSTEME PRET");
 RB3_bit = 1;
 Delay_ms(50);
 RB3_bit = 0;
 Delay_ms(30);

 Lcd_Cmd(_LCD_CLEAR);

 while(1) {


 if (RB0_bit && !rb0_last) {
 rb0_last = 1;

 security = !security;

 if (security) {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "SEC ON");
 } else {
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "SEC OFF");
 }

 Delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);
 }
 if (!RB0_bit) rb0_last = 0;


 if (rb4_pressed) {
 rb4_pressed = 0;

 if (!charge_mode) {

 charge_mode = 1;
 charge_done = 0;
 charge_timer_active = 0;
 default_delay_active = 1;
 default_delay_counter = 0;
 rb4_press_count = 0;
 rb4_press_timeout = 0;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "CHARGING");
 Delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);

 } else if (default_delay_active) {

 rb4_press_count++;

 if (rb4_press_count >= 4) {

 default_delay_active = 0;
 charge_timer_active = 1;
 Timer0_Start();

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "TIMER");
 Delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);
 }
 }
 }


 if (rb5_pressed) {
 rb5_pressed = 0;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "HISTORIQUE");
 Delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);
 }


 if (charge_mode) {
 if (!charge_done) {


 if (default_delay_active) {

 RB3_bit = ~RB3_bit;
 RB7_bit = ~RB7_bit;
 Delay_ms(50);

 default_delay_counter += 50;


 if (default_delay_counter >= 800) {

 default_delay_active = 0;
 charge_done = 1;
 charge_mode = 0;


 RB7_bit = 0;
 RB3_bit = 1;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "CHARGED");
 Delay_ms(150);


 RB3_bit = 0;
 Lcd_Cmd(_LCD_CLEAR);
 }
 }


 else if (charge_timer_active) {
 if (charge_complete) {

 charge_done = 1;
 charge_mode = 0;


 RB7_bit = 0;
 RB3_bit = 1;

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "CHARGED");
 Delay_ms(150);


 RB3_bit = 0;
 Lcd_Cmd(_LCD_CLEAR);
 } else {

 RB3_bit = ~RB3_bit;
 RB7_bit = ~RB7_bit;
 Delay_ms(50);
 }
 }
 }
 continue;
 }


 accel_value = ADC_Read(0);
 speed_percent = ((unsigned long)accel_value * 100) / 1023;

 if (!braking) {
 unsigned short target_speed;
 unsigned short speed_change;


 if (speed_percent < 48) {

 RD0_bit = 0;
 RD1_bit = 1;
 target_speed = 100;
 }
 else if (speed_percent > 52) {

 RD0_bit = 1;
 RD1_bit = 0;
 target_speed = 100;
 }
 else {

 RD0_bit = 0;
 RD1_bit = 0;
 target_speed = 0;
 }



 if (current_speed == 50) {
 speed_change = 10;
 }
 else if (current_speed > 90) {
 speed_change = 5;
 }
 else if (current_speed > 70) {
 speed_change = 3;
 }
 else if (current_speed > 50) {
 speed_change = 1;
 }
 else if (current_speed > 30) {
 speed_change = 1;
 }
 else if (current_speed > 10) {
 speed_change = 3;
 }
 else {
 speed_change = 5;
 }


 if (current_speed < target_speed) {

 if (target_speed - current_speed >= speed_change)
 current_speed += speed_change;
 else
 current_speed = target_speed;
 }
 else if (current_speed > target_speed) {

 if (current_speed - target_speed >= speed_change)
 current_speed -= speed_change;
 else
 current_speed = target_speed;
 }

 PWM1_Set_Duty(current_speed * 255 / 100);

 Lcd_Cmd(_LCD_CLEAR);

 IntToStr(current_speed, lcd_text);
 Ltrim(lcd_text);
 Lcd_Out_CP(lcd_text);
 Lcd_Out_CP("%");
 }


 timer_100ms++;
 if (timer_100ms >= 5) {
 timer_100ms = 0;
 distance_value = ADC_Read(1);
 if (security && distance_value < 300 && !braking)
 Emergency_Stop();
 }

 Delay_ms(50);
 }
}
