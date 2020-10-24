import java.time.LocalTime
import kotlin.system.exitProcess

class TimeAD(var hour: Int = 0, var minute: Int = 0, var second: Int = 0) {

    init{
        if ((this.hour > 24) || (this.hour < 0)) {
            print("Hour format not supported")
            exitProcess(1)
        }
        if ((this.minute > 60) || (this.minute < 0)) {
            print("Minute format not supported")
            exitProcess(1)
        }
        if ((this.second > 60) || (this.second < 0)) {
            print("Second format not supported")
            exitProcess(1)
        }
    }

    constructor(time: LocalTime): this() {
        this.hour = time.hour
        this.minute = time.minute
        this.second = time.minute.toInt()
    }

    override public fun toString(): String {
        var period: String = ""
        var periodHour = this.hour
        if (this.hour > 12) {
            periodHour -= 12
            period = "PM"
        } else {
            period = "AM"
        }
        return timeString(periodHour) + ":" + timeString(this.minute) + ":" + timeString(this.second) + " " + period
    }

    private fun timeString(time: Int): String {
        if (time < 10) {
            return "0" + time.toString()
        }
        else {
            return time.toString()
        }
    }

    fun sum(time: TimeAD): TimeAD {
        val result = TimeAD(this.hour, this.minute, this.second)

        result.second += time.second
        if (result.second >= 60) {
            result.minute += 1
            result.second -= 60
        }

        result.minute += time.minute
        if (result.minute >= 60) {
            result.hour += 1
            result.minute -= 60
        }

        result.hour += time.hour
        if (result.hour >= 24) {
            result.hour -= 24
        }

        return result
    }

    fun dif(time: TimeAD): TimeAD {
        val result = TimeAD(this.hour, this.minute, this.second)

        result.second -= time.second
        if (result.second <= 0) {
            result.minute -= 1
            result.second += 60
        }

        result.minute -= time.minute
        if (result.minute <= 0) {
            result.hour -= 1
            result.minute += 60
        }

        result.hour -= time.hour
        if (result.hour <= 0) {
            result.hour += 24
        }

        return result
    }

    fun sum(time1: TimeAD, time2: TimeAD): TimeAD {
        val result = TimeAD(time1.hour, time1.minute, time1.second)

        result.second += time2.second
        if (result.second >= 60) {
            result.minute += 1
            result.second -= 60
        }

        result.minute += time2.minute
        if (result.minute >= 60) {
            result.hour += 1
            result.minute -= 60
        }

        result.hour += time2.hour
        if (result.hour >= 24) {
            result.hour -= 24
        }

        return result
    }

    fun dif(time1: TimeAD, time2: TimeAD): TimeAD {
        val result = TimeAD(time1.hour, time1.minute, time1.second)

        result.second -= time2.second
        if (result.second <= 0) {
            result.minute -= 1
            result.second += 60
        }

        result.minute -= time2.minute
        if (result.minute <= 0) {
            result.hour -= 1
            result.minute += 60
        }

        result.hour -= time2.hour
        if (result.hour <= 0) {
            result.hour += 24
        }

        return result
    }
}

fun main() {
    val testTime = LocalTime.now()

    val defaultTime = TimeAD()
    val time1 = TimeAD(hour = 13, minute = 0, second = 0)
    val time2 = TimeAD(testTime)

    println("default time constructor: " + defaultTime.toString())
    println("manual time constructor: " + time1.toString())
    println("LocalTime object time constructor: " + time2.toString() + "\n")
    println("time sum with single parameter: " + time1.sum(time2).toString())
    println("time sum with two parameters: " + time2.sum(time1, time2).toString() + "\n")
    println("time difference with single parameter: " + time1.dif(time2).toString())
    println("time difference with two parameters: " + time1.dif(time1, time2).toString())

    val time3 = TimeAD(hour = 13, minute = 59, second = 59)
    val time4 = TimeAD(hour = 1, minute = 1, second = 1)

    println("time sum with overflow: " + time3.sum(time4).toString())

}