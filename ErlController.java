import com.ericsson.otp.erlang.*;

public class ErlController
{
	public String run() throws Exception
	{
		OtpNode myListeningNode = new OtpNode("server");

		OtpMbox myListeningMbox = myListeningNode.createMbox("counterServer");

		OtpErlangObject object;
		OtpErlangTuple msg;
		OtpErlangPid from;
		OtpErlangObject command;

		while (true)
		{
			try
			{
                                System.out.println("WEE!");
				object = myListeningMbox.receive();

				msg = (OtpErlangTuple) object;

				from = (OtpErlangPid) msg.elementAt(0);

				command = (OtpErlangObject) msg.elementAt(1);

				OtpErlangAtom atom = (OtpErlangAtom)command;

				String s = atom.atomValue();

				if (s.equals("move"))
				{
					System.out.println("MOVE!!!");
				}

			}catch(OtpErlangExit e)
				{
					System.out.println("error :P");
					return "NOOOoooo...";
				}
		}
	}
}