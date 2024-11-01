import { StandardMerkleTree } from "@openzeppelin/merkle-tree";
import fs from "fs";

const tree = StandardMerkleTree.load(JSON.parse(fs.readFileSync("merkle/tree.json", "utf8")));

for (const [i, v] of tree.entries()) {
  if (v[0] === '0x2222222222222222222222222222222222222222') {
    const proof = tree.getProof(i);
    console.log('Value:', v);
    console.log('Proof:', proof);
  }
}