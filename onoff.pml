mtype = { ON, OFF }    // تعریف نوع داده برای وضعیت تلویزیون



mtype state = OFF;     // وضعیت اولیه تلویزیون خاموش است



active proctype TV() { // تعریف فرآیند تلویزیون

    do

    :: state == OFF -> // اگر تلویزیون خاموش است

        printf("TV is off. Only ON operation is available.\n");

        if

        :: state = ON -> printf("TV turned ON.\n")

        :: else -> skip

        fi

    :: state == ON -> // اگر تلویزیون روشن است

        printf("TV is on. Available operations: OFF.\n");

        if

        :: state = OFF -> printf("TV turned OFF.\n")

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

    od

}



init {

    run TV();          // اجرای فرآیند تلویزیون

    run Controller();  // اجرای فرآیند کنترلر

}
