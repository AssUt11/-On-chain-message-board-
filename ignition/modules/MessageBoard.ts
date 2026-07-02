import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MessageBoardModule = buildModule("MessageBoardModule", (m) => {
  const initialMaxMessageLength = m.getParameter("initialMaxMessageLength", 280n);

  const messageBoard = m.contract("MessageBoard", [initialMaxMessageLength]);

  return { messageBoard };
});

export default MessageBoardModule;
