mtype = { ON, OFF, INCREASE, DECREASE } // تعریف نوع داده‌ها برای وضعیت‌ها و دستورات



mtype state = OFF;     // وضعیت اولیه تلویزیون خاموش است

int volume = 0;        // سطح اولیه صدا صفر است



active proctype TV() { // تعریف فرآیند تلویزیون

    do

    :: state == OFF -> // اگر تلویزیون خاموش است

        printf("TV is off. Only ON operation is available.\n");

        if

        :: state = ON -> printf("TV turned ON.\n")

        :: else -> skip

        fi

    :: state == ON -> // اگر تلویزیون روشن است

        printf("TV is on. Available operations: OFF, INCREASE, DECREASE.\n");

        if

        :: state = OFF -> printf("TV turned OFF.\n")

        :: else ->

            do

            :: atomic { // افزایش صدا

                volume < 100 -> volume++;

                printf("Volume increased to %d.\n", volume)

            }

            :: atomic { // کاهش صدا

                volume > 0 -> volume--;

                printf("Volume decreased to %d.\n", volume)

            }

            od

        fi

    od

}



active proctype Controller() { // تعریف فرآیند کنترلر

    do

    :: state == OFF -> // اگر تلویزیون خاموش است

        printf("Sending ON command to TV.\n");

        state = ON;

    :: state == ON -> // اگر تلویزیون روشن است

        printf("Sending OFF command to TV.\n");

        state = OFF;

    :: state == ON -> // اگر تلویزیون روشن است

        printf("Sending INCREASE command to TV.\n");

        if

        :: volume < 100 -> volume++;

            printf("Volume increased to %d.\n", volume)

        :: else -> printf("Volume is already at maximum.\n")

        fi

    :: state == ON -> // اگر تلویزیون روشن است

        printf("Sending DECREASE command to TV.\n");

        if

        :: volume > 0 -> volume--;

            printf("Volume decreased to %d.\n", volume)

        :: else -> printf("Volume is already at minimum.\n")

        fi

    od

}



init {

    run TV();          // اجرای فرآیند تلویزیون

    run Controller();  // اجرای فرآیند کنترلر

}
