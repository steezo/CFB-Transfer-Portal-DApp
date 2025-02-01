# College Football Transfer Portal DApp 🏈

A decentralized application (DApp) built on Ethereum that revolutionizes the college football transfer portal process. This platform connects student-athletes, coaches, and sports agents while leveraging blockchain technology for transparency and efficiency.

## Features 🌟

### For Student-Athletes
- Create and manage verified athlete profiles
- Enter/exit transfer portal with timestamp verification
- Track NIL (Name, Image, Likeness) deals
- Connect with verified agents and schools
- View transfer eligibility status

### For Sports Agents
- Create verified agent profiles
- Connect with student-athletes
- Manage NIL deal opportunities
- Track client transfer status
- Access analytical insights

### For Schools/Coaches
- View verified athlete profiles
- Express interest in transfer portal athletes
- Track transfer windows and eligibility
- Access historical transfer data

## Technology Stack 💻

### Smart Contracts
- Solidity ^0.8.0
- OpenZeppelin Contracts
- Hardhat Development Environment

### Frontend
- React.js
- TypeScript
- Tailwind CSS
- RainbowKit
- wagmi

### Testing
- Hardhat Test Suite
- Chai Assertion Library
- Ethers.js

## Prerequisites 📋

- Node.js >= 14.0.0
- npm >= 6.14.0
- MetaMask or similar Web3 wallet
- Git

## Installation 🛠️

1. Clone the repository
```bash
git clone https://github.com/yourusername/cfb-transfer-portal.git
cd cfb-transfer-portal
```

2. Install dependencies
```bash
# Install smart contract dependencies
cd blockchain
npm install

# Install frontend dependencies
cd ../frontend
npm install
```

3. Set up environment variables
```bash
# In blockchain directory
cp .env.example .env
# Add your environment variables

# In frontend directory
cp .env.example .env
# Add your environment variables
```

4. Compile smart contracts
```bash
cd blockchain
npx hardhat compile
```

5. Start local development environment
```bash
# Start local blockchain
npx hardhat node

# In a new terminal, deploy contracts
npx hardhat run scripts/deploy.js --network localhost

# Start frontend
cd ../frontend
npm start
```

## Smart Contract Architecture 📐

```
contracts/
├── core/
│   ├── PlayerProfile.sol
│   ├── TransferPortal.sol
│   └── NILManagement.sol
├── access/
│   └── Roles.sol
└── interfaces/
    ├── IPlayerProfile.sol
    └── ITransferPortal.sol
```

## Testing 🧪

```bash
# Run smart contract tests
cd blockchain
npx hardhat test

# Run frontend tests
cd frontend
npm test
```

## Deployment 🚀

### Test Networks
1. Deploy to Sepolia
```bash
npx hardhat run scripts/deploy.js --network sepolia
```

2. Deploy frontend to Vercel
```bash
vercel deploy
```

### Production
1. Deploy to Ethereum Mainnet
```bash
npx hardhat run scripts/deploy.js --network mainnet
```

2. Deploy frontend to production
```bash
vercel deploy --prod
```

## Security Measures 🔒

- Role-based access control
- OpenZeppelin security standards
- Emergency pause functionality
- Comprehensive testing suite
- Regular security audits

## Contributing 🤝

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License 📝

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Contact 📧

Your Name - [@yourtwitter](https://twitter.com/yourtwitter) - email@example.com

Project Link: [https://github.com/yourusername/cfb-transfer-portal](https://github.com/yourusername/cfb-transfer-portal)

## Acknowledgments 🙏

- OpenZeppelin for smart contract libraries
- Ethereum community for developer tools
- Contributors and testers

## Project Status 📊

- ✅ Smart Contracts Development
- ✅ Frontend Development
- ✅ Testing Suite
- ✅ Security Audit
- 🚧 Mainnet Deployment
- 🚧 Additional Features

## Future Roadmap 🗺️

### Phase 1 (Q2 2025)
- Enhanced analytics dashboard
- Mobile application
- Multi-signature support for NIL deals

### Phase 2 (Q3 2025)
- Integration with college recruitment platforms
- Advanced statistics tracking
- Automated compliance checks

### Phase 3 (Q4 2025)
- Cross-chain support
- AI-powered matching system
- Governance token implementation

## Usage Examples 📱

### Player Registration
```javascript
// Connect wallet
await connectWallet();

// Register player
await playerProfile.register({
  name: "John Doe",
  position: "Quarterback",
  school: "State University"
});
```

### Enter Transfer Portal
```javascript
// Check eligibility
await transferPortal.checkEligibility();

// Enter portal
await transferPortal.enterPortal();
```

### NIL Deal Creation
```javascript
// Create new NIL deal
await nilManagement.createDeal({
  value: ethers.utils.parseEther("1.0"),
  duration: 365 days,
  terms: "Brand Ambassador"
});
```

## Common Issues and Solutions 💡

### MetaMask Connection
**Issue**: Unable to connect MetaMask
**Solution**: Ensure you're on the correct network and have sufficient ETH for gas

### Transaction Failures
**Issue**: Transactions failing
**Solution**: Check gas price and network congestion

## Support 💪

For support, join our [Discord community](https://discord.gg/yourserver) or [Telegram group](https://t.me/yourgroup).

## Disclaimer ⚠️

This project is for educational purposes and should not be used as financial advice. Always conduct proper due diligence before using any smart contract platform.