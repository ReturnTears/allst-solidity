// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

error WrongStage(uint8 current);

/// @title 三阶段状态机
contract StateMachine {
    enum Stage {
        Created,
        Active,
        Finished
    }

    Stage public stage;

    event StageChanged(Stage stage);

    modifier atStage(Stage expected) {
        if (stage != expected) revert WrongStage(uint8(stage));
        _;
    }

    function start() external atStage(Stage.Created) {
        stage = Stage.Active;
        emit StageChanged(stage);
    }

    function finish() external atStage(Stage.Active) {
        stage = Stage.Finished;
        emit StageChanged(stage);
    }
}
