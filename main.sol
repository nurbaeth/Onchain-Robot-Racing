// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract RoboRacers {
    uint256 public racerCount;
    uint256 public raceCount;

    struct Racer {
        uint256 id;
        address owner;
        uint256 speed; // speed stat (1–100)
        uint256 durability; // durability stat (1–100)
    }

    struct Race {
        uint256 id;
        uint256[] racerIds;
        uint256 winnerId;
        bool completed;
    }

    mapping(uint256 => Racer) public racers;
    mapping(address => uint256[]) public ownerToRacers;
    mapping(uint256 => Race) public races;

    event RacerRegistered(uint256 racerId, address owner);
    event RaceStarted(uint256 raceId, uint256[] racerIds);
    event RaceCompleted(uint256 raceId, uint256 winnerId);

    function registerRacer(uint256 speed, uint256 durability) external {
        require(speed + durability <= 150, "Total stats too high");

        racerCount++;
        racers[racerCount] = Racer(racerCount, msg.sender, speed, durability);
        ownerToRacers[msg.sender].push(racerCount);

        emit RacerRegistered(racerCount, msg.sender);
    }

    function startRace(uint256[] memory _racerIds) external {
        require(_racerIds.length >= 2, "Need at least 2 racers");

        raceCount++;
        races[raceCount] = Race(raceCount, _racerIds, 0, false);

        emit RaceStarted(raceCount, _racerIds);
    }

    function finishRace(uint256 raceId) external {
        Race storage race = races[raceId];
        require(!race.completed, "Race already finished");

        uint256 bestScore = 0;
        uint256 winnerId = 0;

        for (uint256 i = 0; i < race.racerIds.length; i++) {
            uint256 rId = race.racerIds[i];
            Racer memory r = racers[rId];

            uint256 random = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, rId)));
            uint256 performance = r.speed + (random % (r.durability + 1));

            if (performance > bestScore) {
                bestScore = performance;
                winnerId = rId;
            }
        }

        race.completed = true;
        race.winnerId = winnerId;

        emit RaceCompleted(raceId, winnerId);
    }

    function getMyRacers() external view returns (uint256[] memory) {
        return ownerToRacers[msg.sender];
    }

    function getRaceRacers(uint256 raceId) external view returns (uint256[] memory) {
        return races[raceId].racerIds;
    }
}
