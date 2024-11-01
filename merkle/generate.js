import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";


const values = JSON.parse(fs.readFileSync("merkle/rewards.json"))
const tree = StandardMerkleTree.of(values, ["address", "address", "uint256"]);
fs.writeFileSync("merkle/tree.json", JSON.stringify(tree.dump()));