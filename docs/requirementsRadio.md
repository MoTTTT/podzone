# Radio Requirements

Build a radio station on the kubernetes cluster. The Minimum Viable Product uses existing infrastructure, audio equipment and vinyl library.

Minimum Viable Product use cases:

- [ ] Stream audio tracks from network file storage
- [ ] Schedule playlists of uploaded content
- [ ] Stream in for broadcast from a DJ installation - on-site
- [ ] Stream in for broadcast from a DJ installation - off-site
- [ ] View Radio Station web page with embedded playback and schedule
- [ ] DJ Installation with vinyl and microphone streaming to station - on-site
- [ ] DJ Installation with vinyl and microphone streaming to station - off-site
- [ ] Stream in for broadcast from a Master installation

Non-Functional Requirements

- [ ] Security: Administration access
- [ ] Radio: Domain registration and email forwarding: jam.radio.fm
- [ ] Social media registrations
- [ ] YouTube channel
- [ ] Website: DJ Profiles
- [ ] Website: Social media links


## Tasklist

### Station Build

- [X] Library: 12" Vinyl {clean,sort}
- [X] Library: 7" Vinyl {clean,sort}
- [X] Turntable 1
- [ ] Turntable 2
- [X] Mixer
- [X] Microphone
- [X] Microphone cable
- [X] Audio Interface
- [X] Hardware: k8s cluster dev (devcluster)
- [X] Hardware: k8s cluster prod (norham)
- [X] Installation: Admin tools {kubectl,k8s}
- [X] Installation: DJ Tools: butt
- [X] Installation: DJ Tools: mixxx

### System Build

- [X] Flex radio system definition
- [X] Ingress for Radio Console
- [ ] Ingress for Media Upload
- [X] Ingress for Radio Listener
- [ ] Ingress for DJ client streaming {non-http}
- [ ] Configuration: ogg -> mp3 stream
- [ ] Media kit
- [ ] Site Copy
- [ ] Bio Template
- [ ] About Us
- [ ] Build: Backup and restore
- [ ] Email address and Social Media accounts
- [ ] Security: override chart default passwords

### Test

- [X] Test: On-premise DJ streaming session from BUTT
- [ ] Test: On-premise DJ streaming session from MIXXX
- [ ] Test: On-premise JD streaming during session slot
- [ ] Test: Volume off-premise listening
- [ ] Test: Off-premise DJ streaming
- [ ] Backup and restore testing
- [X] Test: On premise audio file upload
- [X] Test: DJ Creation
- [X] Test: Playlist creation
- [X] Test: Session (repeat) creation
- [X] Test: On-premise listening
- [X] Test: Off-premise listening
- [X] Test: Mac browser listening
- [ ] Test: Windows browser listening

### Management

- [ ] Creative Brief for site structure, branding and content
- [ ] Domain and iconography specification
- [ ] Role Player: DJs
- [ ] Role Player: Technical Administrator
- [ ] Role Player: Field Support
- [ ] Role Player: Administrators {users, backups,tech support}
- [ ] Role Player: Program Managers
- [ ] Role Player: DJ Onboarding {djclient,bio,branding}
- [ ] Role Player: Radio Site Management
- [ ] Role Player: Program Managers
- [ ] Role Player: Campaign Manager
- [ ] Role Player: Sponsor

### Paperwork

- [ ] DJ, Artist consent process
- [ ] DJ Onboarding process
- [ ] Station Scheduling process
- [ ] Broadcast Licencing commitments
- [ ] Collaborator agreements
- [ ] Radio Directory listings
- [ ] Site maintenance: DJ and Artist Bios
