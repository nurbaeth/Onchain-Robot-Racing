# 🤖 RoboRacers: Onchain Robot Racing   
   
RoboRacers is a fully onchain robot racing game built with Solidity.    
Create your robot, join races, and battle other players for glory — all secured by the blockchain.

> ⚙️ No backend. No cheating. Just pure smart contract racing.

---

## 🚀 Features

- 🛠️ **Custom Robots** — Register robots with unique speed & durability stats   
- 🏁 **Smart Contract Races** — Fully onchain races using block data for fairness  
- 🏆 **Race Results** — Transparent & verifiable winners  
- 📊 **Leaderboards** — (Coming soon) Track your robot's legacy   
- 🔐 **100% Onchain** — No oracles, no servers, no compromises  

---

## 🎮 How to Play

1. **Register your robot**
    ```solidity
    registerRacer(speed, durability);
    ```
    - Speed + Durability must be ≤ 150

2. **Start a race**
    ```solidity
    startRace([robot1, robot2, ...]);
    ```

3. **Finish the race**
    ```solidity
    finishRace(raceId);
    ```
    - The contract calculates the winner based on stats + block randomness

---

## 🧪 Local Deployment

Clone the repo:

```bash
git clone https://github.com/your-username/RoboRacers.git
cd RoboRacers
