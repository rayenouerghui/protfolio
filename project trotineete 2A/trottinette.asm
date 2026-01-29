
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;trottinette.c,49 :: 		void interrupt() {
;trottinette.c,51 :: 		if (TMR0IF_bit) {
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;trottinette.c,52 :: 		TMR0 = 6;
	MOVLW      6
	MOVWF      TMR0+0
;trottinette.c,53 :: 		timer0_count++;
	MOVF       _timer0_count+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _timer0_count+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _timer0_count+0
	MOVF       R0+1, 0
	MOVWF      _timer0_count+1
;trottinette.c,54 :: 		if (timer0_count >= 40) {
	MOVLW      0
	SUBWF      _timer0_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt84
	MOVLW      40
	SUBWF      _timer0_count+0, 0
L__interrupt84:
	BTFSS      STATUS+0, 0
	GOTO       L_interrupt1
;trottinette.c,55 :: 		charge_complete = 1;
	MOVLW      1
	MOVWF      _charge_complete+0
;trottinette.c,56 :: 		TMR0IE_bit = 0;
	BCF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;trottinette.c,57 :: 		}
L_interrupt1:
;trottinette.c,58 :: 		TMR0IF_bit = 0;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;trottinette.c,59 :: 		}
L_interrupt0:
;trottinette.c,61 :: 		if (RBIF_bit) {
	BTFSS      RBIF_bit+0, BitPos(RBIF_bit+0)
	GOTO       L_interrupt2
;trottinette.c,62 :: 		dummy = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _dummy+0
;trottinette.c,65 :: 		if (RB4_bit && !last_rb4_state) {
	BTFSS      RB4_bit+0, BitPos(RB4_bit+0)
	GOTO       L_interrupt5
	MOVF       _last_rb4_state+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_interrupt5
L__interrupt79:
;trottinette.c,66 :: 		rb4_pressed = 1;
	MOVLW      1
	MOVWF      _rb4_pressed+0
;trottinette.c,67 :: 		}
L_interrupt5:
;trottinette.c,68 :: 		last_rb4_state = RB4_bit;
	MOVLW      0
	BTFSC      RB4_bit+0, BitPos(RB4_bit+0)
	MOVLW      1
	MOVWF      _last_rb4_state+0
;trottinette.c,71 :: 		if (RB5_bit) {
	BTFSS      RB5_bit+0, BitPos(RB5_bit+0)
	GOTO       L_interrupt6
;trottinette.c,72 :: 		rb5_pressed = 1;
	MOVLW      1
	MOVWF      _rb5_pressed+0
;trottinette.c,73 :: 		}
L_interrupt6:
;trottinette.c,75 :: 		RBIF_bit = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;trottinette.c,76 :: 		}
L_interrupt2:
;trottinette.c,77 :: 		}
L_end_interrupt:
L__interrupt83:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_Timer0_Init:

;trottinette.c,82 :: 		void Timer0_Init() {
;trottinette.c,83 :: 		OPTION_REG = 0b10000111;
	MOVLW      135
	MOVWF      OPTION_REG+0
;trottinette.c,84 :: 		TMR0 = 6;
	MOVLW      6
	MOVWF      TMR0+0
;trottinette.c,85 :: 		TMR0IE_bit = 0;
	BCF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;trottinette.c,86 :: 		}
L_end_Timer0_Init:
	RETURN
; end of _Timer0_Init

_Timer0_Start:

;trottinette.c,88 :: 		void Timer0_Start() {
;trottinette.c,89 :: 		timer0_count = 0;
	CLRF       _timer0_count+0
	CLRF       _timer0_count+1
;trottinette.c,90 :: 		charge_complete = 0;
	CLRF       _charge_complete+0
;trottinette.c,91 :: 		TMR0 = 6;
	MOVLW      6
	MOVWF      TMR0+0
;trottinette.c,92 :: 		TMR0IE_bit = 1;
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;trottinette.c,93 :: 		}
L_end_Timer0_Start:
	RETURN
; end of _Timer0_Start

_Emergency_Stop:

;trottinette.c,98 :: 		void Emergency_Stop() {
;trottinette.c,100 :: 		braking = 1;
	MOVLW      1
	MOVWF      _braking+0
;trottinette.c,101 :: 		RB7_bit = 1;  // Red LED ON
	BSF        RB7_bit+0, BitPos(RB7_bit+0)
;trottinette.c,102 :: 		RB1_bit = 1;  // Turn on RB1 during braking
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;trottinette.c,104 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,105 :: 		Lcd_Out(1, 1, "OBSTACLE !");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,106 :: 		Lcd_Out(2, 1, "FREINAGE !");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,107 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_Emergency_Stop7:
	DECFSZ     R13+0, 1
	GOTO       L_Emergency_Stop7
	DECFSZ     R12+0, 1
	GOTO       L_Emergency_Stop7
	DECFSZ     R11+0, 1
	GOTO       L_Emergency_Stop7
	NOP
	NOP
;trottinette.c,109 :: 		while (current_speed > 0) {
L_Emergency_Stop8:
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__Emergency_Stop88
	MOVF       _current_speed+0, 0
	SUBLW      0
L__Emergency_Stop88:
	BTFSC      STATUS+0, 0
	GOTO       L_Emergency_Stop9
;trottinette.c,110 :: 		current_speed = (current_speed >= 20) ? current_speed - 20 : 0;
	MOVLW      0
	SUBWF      _current_speed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Emergency_Stop89
	MOVLW      20
	SUBWF      _current_speed+0, 0
L__Emergency_Stop89:
	BTFSS      STATUS+0, 0
	GOTO       L_Emergency_Stop10
	MOVLW      20
	SUBWF      _current_speed+0, 0
	MOVWF      ?FLOC___Emergency_StopT9+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _current_speed+1, 0
	MOVWF      ?FLOC___Emergency_StopT9+1
	GOTO       L_Emergency_Stop11
L_Emergency_Stop10:
	CLRF       ?FLOC___Emergency_StopT9+0
	CLRF       ?FLOC___Emergency_StopT9+1
L_Emergency_Stop11:
	MOVF       ?FLOC___Emergency_StopT9+0, 0
	MOVWF      _current_speed+0
	MOVF       ?FLOC___Emergency_StopT9+1, 0
	MOVWF      _current_speed+1
;trottinette.c,112 :: 		RD0_bit = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;trottinette.c,113 :: 		RD1_bit = 0;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;trottinette.c,114 :: 		PWM1_Set_Duty(current_speed * 255 / 100);
	MOVF       ?FLOC___Emergency_StopT9+0, 0
	MOVWF      R0+0
	MOVF       ?FLOC___Emergency_StopT9+1, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;trottinette.c,116 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,117 :: 		Lcd_Out(1,1,"FREIN");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,118 :: 		Lcd_Out(2,1,"V : ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,120 :: 		IntToStr(current_speed, lcd_text);
	MOVF       _current_speed+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _current_speed+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _lcd_text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;trottinette.c,121 :: 		Ltrim(lcd_text);
	MOVLW      _lcd_text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;trottinette.c,122 :: 		Lcd_Out_CP(lcd_text);
	MOVLW      _lcd_text+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;trottinette.c,123 :: 		Lcd_Out_CP("%");
	MOVLW      ?lstr5_trottinette+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;trottinette.c,125 :: 		Delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_Emergency_Stop12:
	DECFSZ     R13+0, 1
	GOTO       L_Emergency_Stop12
	DECFSZ     R12+0, 1
	GOTO       L_Emergency_Stop12
;trottinette.c,126 :: 		}
	GOTO       L_Emergency_Stop8
L_Emergency_Stop9:
;trottinette.c,128 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;trottinette.c,129 :: 		RD0_bit = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;trottinette.c,130 :: 		RD1_bit = 0;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;trottinette.c,132 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,133 :: 		Lcd_Out(1,1,"ARRET");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,136 :: 		while (security) {
L_Emergency_Stop13:
	MOVF       _security+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_Emergency_Stop14
;trottinette.c,137 :: 		distance_value = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _distance_value+0
	MOVF       R0+1, 0
	MOVWF      _distance_value+1
;trottinette.c,138 :: 		if (distance_value >= 300) break;
	MOVLW      1
	SUBWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Emergency_Stop90
	MOVLW      44
	SUBWF      R0+0, 0
L__Emergency_Stop90:
	BTFSS      STATUS+0, 0
	GOTO       L_Emergency_Stop15
	GOTO       L_Emergency_Stop14
L_Emergency_Stop15:
;trottinette.c,139 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_Emergency_Stop16:
	DECFSZ     R13+0, 1
	GOTO       L_Emergency_Stop16
	DECFSZ     R12+0, 1
	GOTO       L_Emergency_Stop16
	DECFSZ     R11+0, 1
	GOTO       L_Emergency_Stop16
	NOP
	NOP
;trottinette.c,140 :: 		}
	GOTO       L_Emergency_Stop13
L_Emergency_Stop14:
;trottinette.c,142 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,143 :: 		RB7_bit = 0;  // Red LED OFF
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
;trottinette.c,144 :: 		RB1_bit = 0;  // Turn off RB1 after braking
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;trottinette.c,145 :: 		braking = 0;
	CLRF       _braking+0
;trottinette.c,146 :: 		}
L_end_Emergency_Stop:
	RETURN
; end of _Emergency_Stop

_main:

;trottinette.c,151 :: 		void main() {
;trottinette.c,153 :: 		ADCON0 = 0x81;
	MOVLW      129
	MOVWF      ADCON0+0
;trottinette.c,154 :: 		ADCON1 = 0xC4;
	MOVLW      196
	MOVWF      ADCON1+0
;trottinette.c,155 :: 		TRISA = 0x03;
	MOVLW      3
	MOVWF      TRISA+0
;trottinette.c,156 :: 		TRISB = 0x71;
	MOVLW      113
	MOVWF      TRISB+0
;trottinette.c,157 :: 		PORTB = 0;
	CLRF       PORTB+0
;trottinette.c,158 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;trottinette.c,159 :: 		PORTC = 0;
	CLRF       PORTC+0
;trottinette.c,160 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;trottinette.c,161 :: 		PORTD = 0;
	CLRF       PORTD+0
;trottinette.c,162 :: 		NOT_RBPU_bit = 0;
	BCF        NOT_RBPU_bit+0, BitPos(NOT_RBPU_bit+0)
;trottinette.c,164 :: 		PWM1_Init(20000);
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;trottinette.c,165 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;trottinette.c,166 :: 		PWM1_Set_Duty(0);
	CLRF       FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;trottinette.c,168 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;trottinette.c,169 :: 		Delay_ms(20);
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	NOP
	NOP
;trottinette.c,170 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,172 :: 		Timer0_Init();
	CALL       _Timer0_Init+0
;trottinette.c,174 :: 		rb0_last = RB0_bit;
	MOVLW      0
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	MOVLW      1
	MOVWF      _rb0_last+0
;trottinette.c,175 :: 		last_rb4_state = RB4_bit;
	MOVLW      0
	BTFSC      RB4_bit+0, BitPos(RB4_bit+0)
	MOVLW      1
	MOVWF      _last_rb4_state+0
;trottinette.c,177 :: 		dummy = PORTB;
	MOVF       PORTB+0, 0
	MOVWF      _dummy+0
;trottinette.c,178 :: 		RBIF_bit = 0;
	BCF        RBIF_bit+0, BitPos(RBIF_bit+0)
;trottinette.c,180 :: 		GIE_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;trottinette.c,181 :: 		PEIE_bit = 1;
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;trottinette.c,182 :: 		RBIE_bit = 1;
	BSF        RBIE_bit+0, BitPos(RBIE_bit+0)
;trottinette.c,184 :: 		rb4_pressed = 0;
	CLRF       _rb4_pressed+0
;trottinette.c,185 :: 		rb5_pressed = 0;
	CLRF       _rb5_pressed+0
;trottinette.c,187 :: 		Lcd_Out(1, 1, "SYSTEME PRET");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,188 :: 		RB3_bit = 1;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,189 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main18:
	DECFSZ     R13+0, 1
	GOTO       L_main18
	DECFSZ     R12+0, 1
	GOTO       L_main18
	DECFSZ     R11+0, 1
	GOTO       L_main18
	NOP
	NOP
;trottinette.c,190 :: 		RB3_bit = 0;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,191 :: 		Delay_ms(30);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
;trottinette.c,193 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,195 :: 		while(1) {
L_main20:
;trottinette.c,198 :: 		if (RB0_bit && !rb0_last) {
	BTFSS      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main24
	MOVF       _rb0_last+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main24
L__main81:
;trottinette.c,199 :: 		rb0_last = 1;
	MOVLW      1
	MOVWF      _rb0_last+0
;trottinette.c,201 :: 		security = !security;
	MOVF       _security+0, 0
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _security+0
;trottinette.c,203 :: 		if (security) {
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main25
;trottinette.c,204 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,205 :: 		Lcd_Out(1, 1, "SEC ON");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,206 :: 		} else {
	GOTO       L_main26
L_main25:
;trottinette.c,207 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,208 :: 		Lcd_Out(1, 1, "SEC OFF");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,209 :: 		}
L_main26:
;trottinette.c,211 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
	NOP
	NOP
;trottinette.c,212 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,213 :: 		}
L_main24:
;trottinette.c,214 :: 		if (!RB0_bit) rb0_last = 0;
	BTFSC      RB0_bit+0, BitPos(RB0_bit+0)
	GOTO       L_main28
	CLRF       _rb0_last+0
L_main28:
;trottinette.c,217 :: 		if (rb4_pressed) {
	MOVF       _rb4_pressed+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main29
;trottinette.c,218 :: 		rb4_pressed = 0;
	CLRF       _rb4_pressed+0
;trottinette.c,220 :: 		if (!charge_mode) {
	MOVF       _charge_mode+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main30
;trottinette.c,222 :: 		charge_mode = 1;
	MOVLW      1
	MOVWF      _charge_mode+0
;trottinette.c,223 :: 		charge_done = 0;
	CLRF       _charge_done+0
;trottinette.c,224 :: 		charge_timer_active = 0;
	CLRF       _charge_timer_active+0
;trottinette.c,225 :: 		default_delay_active = 1;
	MOVLW      1
	MOVWF      _default_delay_active+0
;trottinette.c,226 :: 		default_delay_counter = 0;
	CLRF       _default_delay_counter+0
	CLRF       _default_delay_counter+1
;trottinette.c,227 :: 		rb4_press_count = 0;
	CLRF       _rb4_press_count+0
;trottinette.c,228 :: 		rb4_press_timeout = 0;
	CLRF       _rb4_press_timeout+0
	CLRF       _rb4_press_timeout+1
;trottinette.c,230 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,231 :: 		Lcd_Out(1, 1, "CHARGING");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,232 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main31:
	DECFSZ     R13+0, 1
	GOTO       L_main31
	DECFSZ     R12+0, 1
	GOTO       L_main31
	DECFSZ     R11+0, 1
	GOTO       L_main31
	NOP
	NOP
;trottinette.c,233 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,235 :: 		} else if (default_delay_active) {
	GOTO       L_main32
L_main30:
	MOVF       _default_delay_active+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main33
;trottinette.c,237 :: 		rb4_press_count++;
	INCF       _rb4_press_count+0, 1
;trottinette.c,239 :: 		if (rb4_press_count >= 4) {
	MOVLW      4
	SUBWF      _rb4_press_count+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main34
;trottinette.c,241 :: 		default_delay_active = 0;
	CLRF       _default_delay_active+0
;trottinette.c,242 :: 		charge_timer_active = 1;
	MOVLW      1
	MOVWF      _charge_timer_active+0
;trottinette.c,243 :: 		Timer0_Start();
	CALL       _Timer0_Start+0
;trottinette.c,245 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,246 :: 		Lcd_Out(1, 1, "TIMER");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr11_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,247 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
	NOP
;trottinette.c,248 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,249 :: 		}
L_main34:
;trottinette.c,250 :: 		}
L_main33:
L_main32:
;trottinette.c,251 :: 		}
L_main29:
;trottinette.c,254 :: 		if (rb5_pressed) {
	MOVF       _rb5_pressed+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main36
;trottinette.c,255 :: 		rb5_pressed = 0;
	CLRF       _rb5_pressed+0
;trottinette.c,256 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,257 :: 		Lcd_Out(1, 1, "HISTORIQUE");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr12_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,258 :: 		Delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main37:
	DECFSZ     R13+0, 1
	GOTO       L_main37
	DECFSZ     R12+0, 1
	GOTO       L_main37
	DECFSZ     R11+0, 1
	GOTO       L_main37
	NOP
	NOP
;trottinette.c,259 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,260 :: 		}
L_main36:
;trottinette.c,263 :: 		if (charge_mode) {
	MOVF       _charge_mode+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main38
;trottinette.c,264 :: 		if (!charge_done) {
	MOVF       _charge_done+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main39
;trottinette.c,267 :: 		if (default_delay_active) {
	MOVF       _default_delay_active+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main40
;trottinette.c,269 :: 		RB3_bit = ~RB3_bit;
	MOVLW
	XORWF      RB3_bit+0, 1
;trottinette.c,270 :: 		RB7_bit = ~RB7_bit;
	MOVLW
	XORWF      RB7_bit+0, 1
;trottinette.c,271 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main41:
	DECFSZ     R13+0, 1
	GOTO       L_main41
	DECFSZ     R12+0, 1
	GOTO       L_main41
	DECFSZ     R11+0, 1
	GOTO       L_main41
	NOP
	NOP
;trottinette.c,273 :: 		default_delay_counter += 50;
	MOVLW      50
	ADDWF      _default_delay_counter+0, 0
	MOVWF      R1+0
	MOVF       _default_delay_counter+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _default_delay_counter+0
	MOVF       R1+1, 0
	MOVWF      _default_delay_counter+1
;trottinette.c,276 :: 		if (default_delay_counter >= 800) {
	MOVLW      3
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main92
	MOVLW      32
	SUBWF      R1+0, 0
L__main92:
	BTFSS      STATUS+0, 0
	GOTO       L_main42
;trottinette.c,278 :: 		default_delay_active = 0;
	CLRF       _default_delay_active+0
;trottinette.c,279 :: 		charge_done = 1;
	MOVLW      1
	MOVWF      _charge_done+0
;trottinette.c,280 :: 		charge_mode = 0;
	CLRF       _charge_mode+0
;trottinette.c,283 :: 		RB7_bit = 0;
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
;trottinette.c,284 :: 		RB3_bit = 1;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,286 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,287 :: 		Lcd_Out(1, 1, "CHARGED");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr13_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,288 :: 		Delay_ms(150);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      1
	MOVWF      R13+0
L_main43:
	DECFSZ     R13+0, 1
	GOTO       L_main43
	DECFSZ     R12+0, 1
	GOTO       L_main43
	DECFSZ     R11+0, 1
	GOTO       L_main43
	NOP
	NOP
;trottinette.c,291 :: 		RB3_bit = 0;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,292 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,293 :: 		}
L_main42:
;trottinette.c,294 :: 		}
	GOTO       L_main44
L_main40:
;trottinette.c,297 :: 		else if (charge_timer_active) {
	MOVF       _charge_timer_active+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main45
;trottinette.c,298 :: 		if (charge_complete) {
	MOVF       _charge_complete+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main46
;trottinette.c,300 :: 		charge_done = 1;
	MOVLW      1
	MOVWF      _charge_done+0
;trottinette.c,301 :: 		charge_mode = 0;
	CLRF       _charge_mode+0
;trottinette.c,304 :: 		RB7_bit = 0;
	BCF        RB7_bit+0, BitPos(RB7_bit+0)
;trottinette.c,305 :: 		RB3_bit = 1;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,307 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,308 :: 		Lcd_Out(1, 1, "CHARGED");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr14_trottinette+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;trottinette.c,309 :: 		Delay_ms(150);
	MOVLW      4
	MOVWF      R11+0
	MOVLW      207
	MOVWF      R12+0
	MOVLW      1
	MOVWF      R13+0
L_main47:
	DECFSZ     R13+0, 1
	GOTO       L_main47
	DECFSZ     R12+0, 1
	GOTO       L_main47
	DECFSZ     R11+0, 1
	GOTO       L_main47
	NOP
	NOP
;trottinette.c,312 :: 		RB3_bit = 0;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;trottinette.c,313 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,314 :: 		} else {
	GOTO       L_main48
L_main46:
;trottinette.c,316 :: 		RB3_bit = ~RB3_bit;
	MOVLW
	XORWF      RB3_bit+0, 1
;trottinette.c,317 :: 		RB7_bit = ~RB7_bit;
	MOVLW
	XORWF      RB7_bit+0, 1
;trottinette.c,318 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main49:
	DECFSZ     R13+0, 1
	GOTO       L_main49
	DECFSZ     R12+0, 1
	GOTO       L_main49
	DECFSZ     R11+0, 1
	GOTO       L_main49
	NOP
	NOP
;trottinette.c,319 :: 		}
L_main48:
;trottinette.c,320 :: 		}
L_main45:
L_main44:
;trottinette.c,321 :: 		}
L_main39:
;trottinette.c,322 :: 		continue;
	GOTO       L_main20
;trottinette.c,323 :: 		}
L_main38:
;trottinette.c,326 :: 		accel_value = ADC_Read(0);
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _accel_value+0
	MOVF       R0+1, 0
	MOVWF      _accel_value+1
;trottinette.c,327 :: 		speed_percent = ((unsigned long)accel_value * 100) / 1023;
	MOVLW      0
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVLW      255
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _speed_percent+0
	MOVF       R0+1, 0
	MOVWF      _speed_percent+1
;trottinette.c,329 :: 		if (!braking) {
	MOVF       _braking+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main50
;trottinette.c,334 :: 		if (speed_percent < 48) {
	MOVLW      0
	SUBWF      _speed_percent+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main93
	MOVLW      48
	SUBWF      _speed_percent+0, 0
L__main93:
	BTFSC      STATUS+0, 0
	GOTO       L_main51
;trottinette.c,336 :: 		RD0_bit = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;trottinette.c,337 :: 		RD1_bit = 1;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;trottinette.c,338 :: 		target_speed = 100;
	MOVLW      100
	MOVWF      main_target_speed_L2+0
;trottinette.c,339 :: 		}
	GOTO       L_main52
L_main51:
;trottinette.c,340 :: 		else if (speed_percent > 52) {
	MOVF       _speed_percent+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main94
	MOVF       _speed_percent+0, 0
	SUBLW      52
L__main94:
	BTFSC      STATUS+0, 0
	GOTO       L_main53
;trottinette.c,342 :: 		RD0_bit = 1;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;trottinette.c,343 :: 		RD1_bit = 0;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;trottinette.c,344 :: 		target_speed = 100;
	MOVLW      100
	MOVWF      main_target_speed_L2+0
;trottinette.c,345 :: 		}
	GOTO       L_main54
L_main53:
;trottinette.c,348 :: 		RD0_bit = 0;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;trottinette.c,349 :: 		RD1_bit = 0;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;trottinette.c,350 :: 		target_speed = 0;
	CLRF       main_target_speed_L2+0
;trottinette.c,351 :: 		}
L_main54:
L_main52:
;trottinette.c,355 :: 		if (current_speed == 50) {
	MOVLW      0
	XORWF      _current_speed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main95
	MOVLW      50
	XORWF      _current_speed+0, 0
L__main95:
	BTFSS      STATUS+0, 2
	GOTO       L_main55
;trottinette.c,356 :: 		speed_change = 10;  // At exactly 50%, reduce by 10%
	MOVLW      10
	MOVWF      main_speed_change_L2+0
;trottinette.c,357 :: 		}
	GOTO       L_main56
L_main55:
;trottinette.c,358 :: 		else if (current_speed > 90) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main96
	MOVF       _current_speed+0, 0
	SUBLW      90
L__main96:
	BTFSC      STATUS+0, 0
	GOTO       L_main57
;trottinette.c,359 :: 		speed_change = 5;   // Over 90%: change by 5%
	MOVLW      5
	MOVWF      main_speed_change_L2+0
;trottinette.c,360 :: 		}
	GOTO       L_main58
L_main57:
;trottinette.c,361 :: 		else if (current_speed > 70) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main97
	MOVF       _current_speed+0, 0
	SUBLW      70
L__main97:
	BTFSC      STATUS+0, 0
	GOTO       L_main59
;trottinette.c,362 :: 		speed_change = 3;   // 70-90%: change by 3%
	MOVLW      3
	MOVWF      main_speed_change_L2+0
;trottinette.c,363 :: 		}
	GOTO       L_main60
L_main59:
;trottinette.c,364 :: 		else if (current_speed > 50) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main98
	MOVF       _current_speed+0, 0
	SUBLW      50
L__main98:
	BTFSC      STATUS+0, 0
	GOTO       L_main61
;trottinette.c,365 :: 		speed_change = 1;   // 50-70%: change by 1%
	MOVLW      1
	MOVWF      main_speed_change_L2+0
;trottinette.c,366 :: 		}
	GOTO       L_main62
L_main61:
;trottinette.c,367 :: 		else if (current_speed > 30) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main99
	MOVF       _current_speed+0, 0
	SUBLW      30
L__main99:
	BTFSC      STATUS+0, 0
	GOTO       L_main63
;trottinette.c,368 :: 		speed_change = 1;   // 30-50%: change by 1%
	MOVLW      1
	MOVWF      main_speed_change_L2+0
;trottinette.c,369 :: 		}
	GOTO       L_main64
L_main63:
;trottinette.c,370 :: 		else if (current_speed > 10) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main100
	MOVF       _current_speed+0, 0
	SUBLW      10
L__main100:
	BTFSC      STATUS+0, 0
	GOTO       L_main65
;trottinette.c,371 :: 		speed_change = 3;   // 10-30%: change by 3%
	MOVLW      3
	MOVWF      main_speed_change_L2+0
;trottinette.c,372 :: 		}
	GOTO       L_main66
L_main65:
;trottinette.c,374 :: 		speed_change = 5;   // 0-10%: change by 5%
	MOVLW      5
	MOVWF      main_speed_change_L2+0
;trottinette.c,375 :: 		}
L_main66:
L_main64:
L_main62:
L_main60:
L_main58:
L_main56:
;trottinette.c,378 :: 		if (current_speed < target_speed) {
	MOVLW      0
	SUBWF      _current_speed+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main101
	MOVF       main_target_speed_L2+0, 0
	SUBWF      _current_speed+0, 0
L__main101:
	BTFSC      STATUS+0, 0
	GOTO       L_main67
;trottinette.c,380 :: 		if (target_speed - current_speed >= speed_change)
	MOVF       _current_speed+0, 0
	SUBWF      main_target_speed_L2+0, 0
	MOVWF      R1+0
	MOVF       _current_speed+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R1+1
	SUBWF      R1+1, 1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main102
	MOVF       main_speed_change_L2+0, 0
	SUBWF      R1+0, 0
L__main102:
	BTFSS      STATUS+0, 0
	GOTO       L_main68
;trottinette.c,381 :: 		current_speed += speed_change;
	MOVF       main_speed_change_L2+0, 0
	ADDWF      _current_speed+0, 1
	BTFSC      STATUS+0, 0
	INCF       _current_speed+1, 1
	GOTO       L_main69
L_main68:
;trottinette.c,383 :: 		current_speed = target_speed;
	MOVF       main_target_speed_L2+0, 0
	MOVWF      _current_speed+0
	CLRF       _current_speed+1
L_main69:
;trottinette.c,384 :: 		}
	GOTO       L_main70
L_main67:
;trottinette.c,385 :: 		else if (current_speed > target_speed) {
	MOVF       _current_speed+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main103
	MOVF       _current_speed+0, 0
	SUBWF      main_target_speed_L2+0, 0
L__main103:
	BTFSC      STATUS+0, 0
	GOTO       L_main71
;trottinette.c,387 :: 		if (current_speed - target_speed >= speed_change)
	MOVF       main_target_speed_L2+0, 0
	SUBWF      _current_speed+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _current_speed+1, 0
	MOVWF      R1+1
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main104
	MOVF       main_speed_change_L2+0, 0
	SUBWF      R1+0, 0
L__main104:
	BTFSS      STATUS+0, 0
	GOTO       L_main72
;trottinette.c,388 :: 		current_speed -= speed_change;
	MOVF       main_speed_change_L2+0, 0
	SUBWF      _current_speed+0, 1
	BTFSS      STATUS+0, 0
	DECF       _current_speed+1, 1
	GOTO       L_main73
L_main72:
;trottinette.c,390 :: 		current_speed = target_speed;
	MOVF       main_target_speed_L2+0, 0
	MOVWF      _current_speed+0
	CLRF       _current_speed+1
L_main73:
;trottinette.c,391 :: 		}
L_main71:
L_main70:
;trottinette.c,393 :: 		PWM1_Set_Duty(current_speed * 255 / 100);
	MOVF       _current_speed+0, 0
	MOVWF      R0+0
	MOVF       _current_speed+1, 0
	MOVWF      R0+1
	MOVLW      255
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Mul_16X16_U+0
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16X16_U+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;trottinette.c,395 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;trottinette.c,397 :: 		IntToStr(current_speed, lcd_text);
	MOVF       _current_speed+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       _current_speed+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _lcd_text+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;trottinette.c,398 :: 		Ltrim(lcd_text);
	MOVLW      _lcd_text+0
	MOVWF      FARG_Ltrim_string+0
	CALL       _Ltrim+0
;trottinette.c,399 :: 		Lcd_Out_CP(lcd_text);
	MOVLW      _lcd_text+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;trottinette.c,400 :: 		Lcd_Out_CP("%");
	MOVLW      ?lstr15_trottinette+0
	MOVWF      FARG_Lcd_Out_CP_text+0
	CALL       _Lcd_Out_CP+0
;trottinette.c,401 :: 		}
L_main50:
;trottinette.c,404 :: 		timer_100ms++;
	INCF       _timer_100ms+0, 1
;trottinette.c,405 :: 		if (timer_100ms >= 5) {
	MOVLW      5
	SUBWF      _timer_100ms+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main74
;trottinette.c,406 :: 		timer_100ms = 0;
	CLRF       _timer_100ms+0
;trottinette.c,407 :: 		distance_value = ADC_Read(1);
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _distance_value+0
	MOVF       R0+1, 0
	MOVWF      _distance_value+1
;trottinette.c,408 :: 		if (security && distance_value < 300 && !braking)
	MOVF       _security+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main77
	MOVLW      1
	SUBWF      _distance_value+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main105
	MOVLW      44
	SUBWF      _distance_value+0, 0
L__main105:
	BTFSC      STATUS+0, 0
	GOTO       L_main77
	MOVF       _braking+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_main77
L__main80:
;trottinette.c,409 :: 		Emergency_Stop();
	CALL       _Emergency_Stop+0
L_main77:
;trottinette.c,410 :: 		}
L_main74:
;trottinette.c,412 :: 		Delay_ms(50);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      69
	MOVWF      R12+0
	MOVLW      169
	MOVWF      R13+0
L_main78:
	DECFSZ     R13+0, 1
	GOTO       L_main78
	DECFSZ     R12+0, 1
	GOTO       L_main78
	DECFSZ     R11+0, 1
	GOTO       L_main78
	NOP
	NOP
;trottinette.c,413 :: 		}
	GOTO       L_main20
;trottinette.c,414 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
