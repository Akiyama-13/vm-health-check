# vm-health-check
## Step 8: Logging, Formatting, and Error Handling

- The script was executed in **Windows Git Bash**.  
- Since the commands `top` and `free` are not available in Git Bash, the error handling part of the script was triggered.  
- The script successfully wrote these events into **health.log**, proving that logging works.  
- In a real Linux VM (e.g., Ubuntu or CentOS), the commands would work correctly and show actual CPU and memory usage.

## Step 9–12: Testing, Usage, Automation, and Demo

- The script was tested in **Windows Git Bash**.  
  - Some commands like `top` and `free` are not available in this environment.  
  - Error handling works correctly, but CPU and memory usage cannot be measured here.  
  - In a real Linux VM (e.g., Ubuntu), the script would run normally and show accurate results.  

- Examples of how to use the script:
```bash
./health_check.sh
./health_check.sh --explain
./health_check.sh >> health.log

*/15 * * * * /path/to/health_check.sh >> /var/log/vm_health.log
