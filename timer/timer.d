module timer;

public import std.datetime.stopwatch;

// Everything in here is @safe and @nogc!
@safe @nogc:

// TODO: Implement AsyncTimer (threaded, callbacks, etc)

/// Convenient wrapper for `std.datetime.stopwatch.StopWatch`
/// See_Also: std.datetime.stopwatch.StopWatch
class Timer
{
private:
	StopWatch stopwatch;

public:
	/// Desired duration for this timer.
	Duration duration;

	/**
		Constructs a new `Timer`.

		Params:
			duration = The desired duration for this timer.
			autostart = Indicates whether this instance should start running immediately.
	*/
	this(in Duration duration, AutoStart autostart)
	{
		this.duration = duration;
		stopwatch = StopWatch(autostart);
	}

	/// Resets the internal `StopWatch`.
	/// See_Also: std.datetime.stopwatch.StopWatch.reset
	void reset()
	{
		stopwatch.reset();
	}

	/// Starts the internal `StopWatch`.
	/// See_Also: std.datetime.stopwatch.StopWatch.start
	void start()
	{
		stopwatch.start();
	}

	/// Stops the internal `StopWatch`.
	/// See_Also: std.datetime.stopwatch.StopWatch.stop
	void stop()
	{
		stopwatch.stop();
	}

	/// Peek at the amount of time the internal `StopWatch` has been running.
	/// See_Also: std.datetime.stopwatch.StopWatch.peek
	Duration peek() const
	{
		return stopwatch.peek();
	}

	/// Returns whether the internal `StopWatch` is running.
	/// See_Also: std.datetime.stopwatch.StopWatch.running
	pure nothrow bool running() @property const
	{
		return stopwatch.running;
	}

	/// Indicates whether the elapsed time has reached or exceeded the desired duration.
	bool done() @property
	{
		if (!running)
		{
			return true;
		}

		if (peek() >= duration)
		{
			stop();
			return true;
		}

		return false;
	}

	/// Gets the time remaining until the timer is done.
	/// See_Also: done
	auto remainder() @property const
	{
		return duration - peek();
	}
}
