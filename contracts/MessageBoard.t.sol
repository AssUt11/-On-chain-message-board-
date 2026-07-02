// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { MessageBoard } from "./MessageBoard.sol";

contract MessageBoardCaller {
    function postMessage(MessageBoard board, string memory content) external returns (uint256) {
        return board.postMessage(content);
    }

    function deleteMessage(MessageBoard board, uint256 id) external {
        board.deleteMessage(id);
    }

    function setMaxMessageLength(MessageBoard board, uint256 newMaxMessageLength) external {
        board.setMaxMessageLength(newMaxMessageLength);
    }
}

contract MessageBoardTest {
    MessageBoard private board;
    MessageBoardCaller private caller;

    function setUp() public {
        board = new MessageBoard(280);
        caller = new MessageBoardCaller();
    }

    function test_ConstructorSetsOwnerAndMaxLength() public view {
        require(board.owner() == address(this), "owner should be test contract");
        require(board.maxMessageLength() == 280, "max length should be 280");
    }

    function test_PostMessageStoresData() public {
        uint256 id = board.postMessage("Hello GitHub");

        require(id == 0, "first id should be 0");
        require(board.messageCount() == 1, "count should be 1");

        MessageBoard.Message memory message = board.getMessage(0);
        require(message.id == 0, "message id mismatch");
        require(message.author == address(this), "author mismatch");
        require(_sameString(message.content, "Hello GitHub"), "content mismatch");
        require(message.createdAt > 0, "timestamp should be set");
        require(!message.deleted, "message should not be deleted");
    }

    function test_GetMessagesWithPagination() public {
        board.postMessage("one");
        board.postMessage("two");
        board.postMessage("three");

        MessageBoard.Message[] memory page = board.getMessages(1, 2);

        require(page.length == 2, "page length should be 2");
        require(_sameString(page[0].content, "two"), "first page item mismatch");
        require(_sameString(page[1].content, "three"), "second page item mismatch");
    }

    function test_DeleteMessageAsAuthor() public {
        uint256 id = board.postMessage("delete me");

        board.deleteMessage(id);

        MessageBoard.Message memory message = board.getMessage(id);
        require(message.deleted, "message should be marked deleted");
    }

    function test_DeleteMessageAsOwner() public {
        uint256 id = caller.postMessage(board, "posted by helper contract");

        board.deleteMessage(id);

        MessageBoard.Message memory message = board.getMessage(id);
        require(message.deleted, "owner should delete helper message");
    }

    function test_SetMaxMessageLengthAsOwner() public {
        board.setMaxMessageLength(500);
        require(board.maxMessageLength() == 500, "new max length should be 500");
    }

    function test_TransferOwnership() public {
        address newOwner = address(0xBEEF);

        board.transferOwnership(newOwner);

        require(board.owner() == newOwner, "owner should change");
    }

    function test_RevertWhenEmptyMessage() public {
        try board.postMessage("") returns (uint256) {
            revert("expected empty message to revert");
        } catch {}
    }

    function test_RevertWhenMessageTooLong() public {
        MessageBoard smallBoard = new MessageBoard(5);

        try smallBoard.postMessage("123456") returns (uint256) {
            revert("expected long message to revert");
        } catch {}
    }

    function test_RevertWhenNonAuthorDeletesMessage() public {
        uint256 id = board.postMessage("owner message");

        try caller.deleteMessage(board, id) {
            revert("expected non-author delete to revert");
        } catch {}
    }

    function test_RevertWhenNonOwnerUpdatesMaxLength() public {
        try caller.setMaxMessageLength(board, 100) {
            revert("expected non-owner update to revert");
        } catch {}
    }

    function _sameString(string memory a, string memory b) private pure returns (bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }
}
