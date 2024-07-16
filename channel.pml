#define N 10 // تعداد کانال‌ها

byte current_channel = 0; // کانال کنونی (از 0 تا N-1)



inline ch_plus() {

    if

    :: (current_channel < N-1) -> current_channel = current_channel + 1

    :: (current_channel == N-1) -> current_channel = 0

    fi;

    printf("Current channel: %d\n", current_channel);

}



inline ch_minus() {

    if

    :: (current_channel > 0) -> current_channel = current_channel - 1

    :: (current_channel == 0) -> current_channel = N-1

    fi;

    printf("Current channel: %d\n", current_channel);

}



proctype TV() {

    do

    :: ch_plus()

    :: ch_minus()

    od

}



init {

    run TV();

}
