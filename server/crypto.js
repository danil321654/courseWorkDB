const crypto = require("crypto");

const algorithm = "aes-256-ctr";
const secretKey = "vOVH6sdmpNWjRRIqCc7rdxs01lwHzfr3";
require("dotenv").config();

const iv = Buffer.from(process.env.KEY, "hex");

const encrypt = text => {
  const cipher = crypto.createCipheriv(algorithm, secretKey, iv);

  const encrypted = Buffer.concat([cipher.update(text), cipher.final()]);
  console.log(iv);
  return {
    iv: iv.toString("hex"),
    content: encrypted.toString("hex")
  };
};

const decrypt = hash => {
  const decipher = crypto.createDecipheriv(
    algorithm,
    secretKey,
    Buffer.from(iv, "hex")
  );

  const decrpyted = Buffer.concat([
    decipher.update(Buffer.from(hash, "hex")),
    decipher.final()
  ]);

  return decrpyted.toString();
};

module.exports = {
  encrypt,
  decrypt
};
