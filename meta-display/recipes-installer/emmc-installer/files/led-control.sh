#!/bin/bash

led_0=/sys/class/leds/beaglebone:green:usr0
led_1=/sys/class/leds/beaglebone:green:usr1
led_2=/sys/class/leds/beaglebone:green:usr2
led_3=/sys/class/leds/beaglebone:green:usr3
led_4=/sys/class/leds/beaglebone:green:usr4

echo none > ${led_0}/trigger
echo none > ${led_1}/trigger
echo none > ${led_2}/trigger
echo none > ${led_3}/trigger
echo none > ${led_4}/trigger

run() {
    if [ $1 = 1 ]
    then
        echo 1 > ${led_0}/brightness
    else
        echo 0 > ${led_0}/brightness
    fi

    if [ $2 = 1 ]
    then
        echo 1 > ${led_1}/brightness
    else
        echo 0 > ${led_1}/brightness
    fi

    if [ $3 = 1 ]
    then
        echo 1 > ${led_2}/brightness
    else
        echo 0 > ${led_2}/brightness
    fi
    
    if [ $4 = 1 ]
    then
        echo 1 > ${led_3}/brightness
    else
        echo 0 > ${led_3}/brightness
    fi

    if [ $5 = 1 ]
    then
        echo 1 > ${led_4}/brightness
    else
        echo 0 > ${led_4}/brightness
    fi
}

cycle_A() {
    run 1 0 0 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 1 1 0
    usleep 80000
    run 1 1 1 1 1
    usleep 80000
    run 0 1 1 1 1
    usleep 80000
    run 0 0 1 1 1
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 0 0 1
    usleep 80000
    run 0 0 0 0 0
    usleep 80000
}

cycle_B() {
    run 1 0 0 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 1 1 0
    usleep 80000
    run 1 1 1 1 1
    usleep 80000
    run 1 1 1 1 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 0 0 0 0
    usleep 80000
    run 0 0 0 0 0
    usleep 80000
}

cycle_C() {
    run 1 1 0 0 0
    usleep 160000
    run 0 0 0 1 1
    usleep 160000
}

cycle_D() {
    run 1 0 0 0 1
    usleep 160000
    run 0 1 0 1 0
    usleep 160000
    run 0 0 1 0 0
    usleep 160000
}

cycle_E() {
    run 1 0 0 0 0
    usleep 80000
    run 0 1 0 0 0
    usleep 80000
    run 0 0 1 0 0
    usleep 80000
    run 0 0 0 1 0
    usleep 80000
    run 0 0 0 0 1
    usleep 80000
    usleep 80000
    run 0 0 0 1 0
    usleep 80000
    run 0 0 1 0 0
    usleep 80000
    run 0 1 0 0 0
    usleep 80000
    run 1 0 0 0 0
    usleep 80000
}

cycle_F() {
    run 1 0 0 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 0 1 1 0 0
    usleep 80000
    run 0 0 1 1 0
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 0 0 1
    usleep 80000
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 1 1 0
    usleep 80000
    run 0 1 1 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 0 0 0 0
    usleep 80000
}

cycle_G() {
    run 1 0 0 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 0 1 1 1 0
    usleep 80000
    run 0 0 1 1 1
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 0 0 1
    usleep 80000
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 1 1 1
    usleep 80000
    run 0 1 1 1 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 0 0 0 0
    usleep 80000
}

cycle_H() {
    run 1 0 0 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 1 1 0
    usleep 80000
    run 0 1 1 1 1
    usleep 80000
    run 0 0 1 1 1
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 0 0 1
    usleep 80000
    usleep 80000
    run 0 0 0 1 1
    usleep 80000
    run 0 0 1 1 1
    usleep 80000
    run 0 1 1 1 1
    usleep 80000
    run 1 1 1 1 0
    usleep 80000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 0 0 0
    usleep 80000
    run 1 0 0 0 0
    usleep 80000
}

cycle_I() {
    run 1 0 0 0 0
    usleep 260000
    run 1 1 0 0 0
    usleep 160000
    run 1 1 1 0 0
    usleep 80000
    run 1 1 1 1 0
    usleep 40000
    run 1 1 1 1 1
    usleep 40000
    run 1 1 1 1 0
    usleep 80000
    run 1 1 1 0 0
    usleep 160000
    run 1 1 0 0 0
    usleep 260000
    run 1 0 0 0 0
    usleep 80000
}

cycle_J() {
    # Basket Case
    bpm=175
    full_beat=$((1000000 * 60 * 1 / bpm))
    beat=200000
    skip=$((full_beat - beat))

    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 1
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip

    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 1
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip

    run 1 0 0 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 1
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip

    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 1 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 1
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
    run 1 0 0 0 0
    usleep $beat
    run 0 0 0 0 0
    usleep $skip
}

if [ ! -f /tmp/led_state ]
then
    echo expected /tmp/led_state
    exit 3
fi

state=$(cat /tmp/led_state)
while true
do
    if ! hash cycle_${state} 2> /dev/null
    then
        if [ ${state} != 0 ]
        then
            echo could not find cycle type for ${state}
        fi
        break
    fi

    cycle_${state}
    state=$(cat /tmp/led_state)
done

echo activity > ${led_1}/trigger
echo bluetooth-power > ${led_2}/trigger
echo mmc0 > ${led_3}/trigger
echo backlight > ${led_4}/trigger
