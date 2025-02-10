To obtain the latest version of the official guide, please visit http://benchmarks.cisecurity.org.

## Overview

All CIS Benchmarks focus on technical configuration settings used to maintain and/or increase the security of the addressed technology, and they should be used in conjunction with other essential cyber hygiene tasks like:

  - Monitoring the base operating system for vulnerabilities and quickly updating with the latest security patches
  - Monitoring applications and libraries for vulnerabilities and quickly updating with the latest security patches

In the end, the CIS Benchmarks are designed as a key component of a comprehensive cybersecurity program.

This document, Security Configuration Benchmark for Microsoft 365, provides prescriptive guidance for establishing a secure configuration posture for Microsoft 365 Cloud offerings running on any OS. This guide was tested against Microsoft 365, and includes recommendations for Exchange Online, SharePoint Online, OneDrive for Business, Teams, Power BI (Fabric) and Azure Active Directory.

To ensure all PowerShell related cmdlets work in your tenant please download the latest versions of the PowerShell modules. Scripts and commands referenced in this benchmark were tested using the following modules:

  - ExchangeOnlineManagement 3.3.0
  - Microsoft.Graph 2.4.0
  - MicrosoftTeams 5.5.0
  - Microsoft.Online.SharePoint.PowerShell 16.0.24009.12000
  - AzureAD 2.0.2.182

## Profile Definitions

The following configuration profiles are defined by this Benchmark:

**E3 Level 1**

Items in this profile apply to customer deployments of Microsoft M365 with an E3 license and intend to:
  - be practical and prudent;
  - provide a clear security benefit; and
  - not inhibit the utility of the technology beyond acceptable means.

**E3 Level 2**

This profile extends the "E3 Level 1" profile. Items in this profile exhibit one or more of the following characteristics and is focused on customer deployments of Microsoft M365 E3:
  - are intended for environments or use cases where security is paramount
  - acts as defense in depth measure
  - may negatively inhibit the utility or performance of the technology.

**E5 Level 1**

Items in this profile extend what is provided by the "E3 Level 1" profile for customer deployments of Microsoft M365 with an E5 license and intend to:
  - be practical and prudent;
  - provide a clear security benefit; and
  - not inhibit the utility of the technology beyond acceptable means.

**E5 Level 2**

This profile extends the "E3 Level 1" and "E5 Level 1" profiles. Items in this profile exhibit one or more of the following characteristics and is focused on customer deployments of Microsoft M365 E5:
  - are intended for environments or use cases where security is paramount
  - acts as defense in depth measure
  - may negatively inhibit the utility or performance of the technology.
