function formatDuration (seconds) {
    if (seconds === 0) return 'now';
    let minutes = Math.floor(seconds / 60);
    let remainingSeconds = seconds % 60;
    let hours = Math.floor(minutes / 60);
    let remainingMinutes = minutes % 60;
    let days = Math.floor(hours / 24);
    let remainingHours = hours % 24;
    let years = Math.floor(days / 365);
    let remainingDays = days % 365;
    let remaining = [
      ['second', 'seconds', remainingSeconds],
      ['minute', 'minutes', remainingMinutes],
      ['hour', 'hours', remainingHours],
      ['day', 'days', remainingDays],
      ['year', 'years', years]
    ]
    let andUsed = false;
    let answer = remaining.reduce((acum, item) => {
      if (item[2] > 0) {
        if (item[2] == 1) { //singular
          acum = item[2] + ' ' + item[0] + acum;
        } else { //plural
          acum = item[2] + ' ' + item[1] + acum;
        }
      if (!andUsed) {
        acum = ' and ' + acum;
        andUsed = true;
      } else {acum = ', ' + acum;}
      return acum;
      } else return acum;
    }, '');
    while (!/\d/.test(answer[0])) { // removes spaces, 'and' and ',' from the beginning
      answer = answer.slice(1);
    }
    return(answer)
  }

/*
https://www.codewars.com/kata/52742f58faf5485cae000b9a

Your task in order to complete this Kata is to write a function which formats a duration, given as a number of seconds, in a human-friendly way.

The function must accept a non-negative integer. If it is zero, it just returns "now". Otherwise, the duration is expressed as a combination of years, days, hours, minutes and seconds.

It is much easier to understand with an example:

* For seconds = 62, your function should return 
    "1 minute and 2 seconds"
* For seconds = 3662, your function should return
    "1 hour, 1 minute and 2 seconds"
For the purpose of this Kata, a year is 365 days and a day is 24 hours.

Note that spaces are important.

Detailed rules
The resulting expression is made of components like 4 seconds, 1 year, etc. In general, a positive integer and one of the valid units of time, separated by a space. The unit of time is used in plural if the integer is greater than 1.

The components are separated by a comma and a space (", "). Except the last component, which is separated by " and ", just like it would be written in English.

A more significant units of time will occur before than a least significant one. Therefore, 1 second and 1 year is not correct, but 1 year and 1 second is.

Different components have different unit of times. So there is not repeated units like in 5 seconds and 1 second.

A component will not appear at all if its value happens to be zero. Hence, 1 minute and 0 seconds is not valid, but it should be just 1 minute.

A unit of time must be used "as much as possible". It means that the function should not return 61 seconds, but 1 minute and 1 second instead. Formally, the duration specified by of a component must not be greater than any valid more significant unit of time.
*/