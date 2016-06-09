module timer;

public import std.datetime;

// TODO: Remove TickDuration as it will be deprecated.
// TODO: Implement AsyncTimer (threaded, callbacks, etc)

class Timer
{
private:
	StopWatch stopwatch;

public:
	this(in Duration duration, AutoStart autostart)
	{
		this.duration = cast(TickDuration)duration;
		stopwatch = StopWatch(autostart);
	}

	TickDuration duration;

	@safe void reset()
	{
		stopwatch.reset();
	}
	@safe void start()
	{
		stopwatch.start();
	}
	@safe void stop()
	{
		stopwatch.stop();
	}
	const @safe TickDuration peek()
	{
		return stopwatch.peek();
	}
	@safe void setMeasured(TickDuration d)
	{
		stopwatch.setMeasured(d);
	}
	const pure nothrow @property @safe bool running()
	{
		return stopwatch.running();
	}

	// Returns true if the elapsed time has exceeded the desired duration.
	bool done() @property
	{
		if (!running)
			return true;

		if (peek() >= duration)
		{
			stop();
			return true;
		}

		return false;
	}
	// Remaining time
	auto remainder() @property
	{
		return duration - peek();
	}
}
