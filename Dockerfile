# # Use Node.js base image
# FROM node:18

# # Set working directory
# WORKDIR /app

# # Install Python, pip, and virtual environment tools
# RUN apt-get update && \
#     apt-get install -y \
#     python3 \
#     python3-pip \
#     python3-venv && \
#     python3 -m venv /venv

# # Install Python packages in the virtual environment
# RUN /venv/bin/pip install solc-select slither-analyzer && \
#     /venv/bin/solc-select install 0.8.0 && \
#     /venv/bin/solc-select use 0.8.0

# # Copy application files (if any)
# COPY . .

# # Install Node.js dependencies
# RUN npm install

# # Set entrypoint to run the audit.js script
# CMD ["node", "audit.js"]










# # Use Node.js base image
# FROM node:18

# # Set working directory
# WORKDIR /apph

# # Install Python, pip, and virtual environment tools
# RUN apt-get update && \
#     apt-get install -y \
#     python3 \
#     python3-pip \
#     python3-venv

# # Create a virtual environment and install Python packages
# RUN python3 -m venv /venv
# RUN /venv/bin/pip install solc-select slither-analyzer

# # Set PATH to include the virtual environment binaries
# ENV PATH="/venv/bin:$PATH"

# # Copy application files (if any)
# # COPY . .

# # Run Slither analysis
# ENTRYPOINT ["slither"]







# Use Node.js base image
FROM node:18

# Set working directory
WORKDIR /app

# Install Python, pip, and virtual environment tools
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    curl

# Create a virtual environment and install Python packages
RUN python3 -m venv /venv
RUN /venv/bin/pip install solc-select slither-analyzer

# Set PATH to include the virtual environment binaries
ENV PATH="/venv/bin:$PATH"

# Install specific versions of solc
RUN /venv/bin/solc-select install 0.8.0
RUN /venv/bin/solc-select install 0.8.27
RUN /venv/bin/solc-select install 0.7.6
RUN /venv/bin/solc-select install 0.6.12

# Set the default version of solc
RUN /venv/bin/solc-select use 0.8.0
RUN /venv/bin/solc-select use 0.8.27

# Copy application files
COPY . .

# Install Node.js dependencies
RUN npm install

# Set entrypoint to run the audit.js script
CMD ["node", "audit.js"]
