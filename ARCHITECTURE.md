# Target AWS architecture

```text
Internet --> IGW --> public subnet --> Web EC2 (Nginx, React, Node.js)
                                       | private TCP/27017
                                       v
                              private subnet --> MongoDB EC2
                                       |
                                    NAT gateway --> IGW (outbound updates only)
```

- VPC: 10.20.0.0/16; public: 10.20.1.0/24; private: 10.20.2.0/24.
- Public SSH restricted to `admin_cidr`; private SSH via ProxyJump on web host.
- MongoDB only reachable from web security group; no public IP on database.
- Nginx listens on HTTP 80; HTTPS requires an additional certificate and DNS setup.
- Single NAT gateway and single AZ are for assignment demonstration, not production HA.
