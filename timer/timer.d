module timer;

import std.typecons; // for ScopeTimer

public import std.datetime;

// TODO: Implement AsyncTimer (threaded, callbacks, etc)

class Timer
{
private:
	Duration initTime;
	bool finished;

public:
	this(in Duration duration, bool startNow = false)
	{
		this.duration = duration;
		this(startNow);
	}
	this (bool startNow = false)
	{
		if (startNow)
			start();
	}

	// The duration to wait. Can be modified at any time.
	Duration duration;

	// Starts or restarts the timer by setting startTime to the current system time.
	void start()
	{
		finished = false;
		initTime = Clock.currStdTime().hnsecs();
	}

	// Returns true if the elapsed time has exceeded the desired duration.
	bool done() @property
	{
		return (!finished) ? finished = elapsed >= duration : finished;
	}

	// The time of the last call to start()
	Duration startTime() @property
	{
		return initTime;
	}
	// The elapsed time since startTime
	Duration elapsed() @property
	{
		return (Clock.currStdTime().hnsecs - initTime);
	}
}

class CodeTimer : Timer
{
	string formatString;
	this(bool startNow = true, in string format = "%02dh %02dm %02ds %04dms %04dus %04dhn %04dns")
	{
		formatString = format;
		super(startNow);
	}
	~this()
	{
		result();
	}

	void result()
	{
		import std.stdio : stdout;

		if (finished)
			return;

		finished = true;
		auto result = elapsed.split!("hours", "minutes", "seconds", "msecs", "usecs", "hnsecs", "nsecs");

		stdout.writefln(formatString, result.hours, result.minutes, result.seconds,
						result.msecs, result.usecs, result.hnsecs, result.nsecs);
	}
}

// Convenient alias for a scoped CodeTimer.
// Usage example: auto t = ScopeTimer();
alias ScopeTimer = scoped!CodeTimer;
