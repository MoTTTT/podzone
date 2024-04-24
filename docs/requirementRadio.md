# Radio Requirements

Build a radio station on the kubernetes cluster. The Minimum Viable Product uses existing infrastructure, audio equipment and vinyl library.

## Minimum Viable Product use cases

- [ ] Stream audio tracks from network file storage
- [ ] Schedule playlists of uploaded content
- [ ] Stream in for broadcast from a DJ installation - on-site
- [ ] Stream in for broadcast from a DJ installation - off-site
- [ ] View Radio Station web page with embedded playback and schedule
- [ ] DJ Installation with vinyl and microphone streaming to station - on-site
- [ ] DJ Installation with vinyl and microphone streaming to station - off-site
- [ ] Stream in for broadcast from a Master installation

## Non-Functional Requirements

- [ ] Security: Administration access
- [X] Radio: Domain registration and email forwarding: jam.radio.fm
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
- [ ] Microphone
- [X] Microphone cable
- [X] Audio Interface
- [X] Hardware: k8s cluster dev (devcluster)
- [X] Hardware: k8s cluster prod (norham)
- [X] Installation: Admin tools {kubectl,k8s}
- [X] Installation: DJ Tools: butt
- [X] Installation: DJ Tools: mixxx
- [ ] Integration: Pioneer Console

### System Build

- [X] Flex radio system definition
- [X] Ingress for Radio Console
- [ ] Ingress for Media Upload
- [X] Ingress for Radio Listener
- [X] Ingress for DJ client streaming {non-http}
- [X] Configuration: ogg -> mp3 stream
- [ ] Media kit
- [ ] Site Copy
- [ ] Bio Template
- [ ] About Us
- [ ] Build: Backup and restore
- [ ] Email address and Social Media accounts
- [ ] Security: override chart default passwords

### Test

- [X] DJ Creation
- [X] Playlist creation
- [X] Session (repeat) creation
- [X] Streaming session from BUTT
- [X] Streaming session from MIXXX
- [ ] Streaming session from Pioneer Console
- [ ] Off-premise session streaming
- [ ] Streaming authentication and cut-over
- [ ] Audio file upload
- [X] DJ Creation
- [X] Playlist creation
- [X] Session (repeat) creation
- [X] Listening client: Mac browser
- [X] Listening client: Windows browser
- [X] Listening client: iPhone browser
- [ ] Listening client: Android browser
- [ ] Backup and restore: Station
- [ ] Backup and restore: Media
- [ ] Backup and restore: Website
- [ ] Listening load and soak

### Management

- [ ] Creative Brief for site structure, branding and content {Thandi}
- [ ] Domain and iconography specification {All}
- [ ] Role Player: DJs {Torrell, Knott, Amy, Sub Templa, Lash, Cal, Tommy Lewis}
- [ ] Role Player: Technical Administrator {Jim, + protege}
- [ ] Role Player: Station Administrator {Tom}
- [ ] Role Player: Field Support {Max, Charles, Martin, Torrell}
- [ ] Role Player: Administrators {users, backups, tech support}
- [ ] Role Player: Program Managers {Stew, Torrell}
- [ ] Role Player: DJ Onboarding {djclient,bio,branding}
- [ ] Role Player: Radio Site Management
- [ ] Role Player: Campaign Manager {Gabby, Kanye}
- [ ] Role Player: YouTube Channel {Kanye}
- [ ] Role Player: Sponsor/Owner {Martin, Charles, Stew, Jay}
- [ ] Role Player: Advertising sales {Kanye}

### DJ Onboarding

- Torrell
- Gabby Palmer
- Amy Willow
- Stewart
- Jonathan
- Casa Luna
- Nathan and Sarah
- Michael - (heavy sessions)

### Paperwork

- [ ] DJ, Artist consent process
- [ ] DJ Onboarding process
- [ ] Station Scheduling process
- [ ] Broadcast Licencing commitments
- [ ] Collaborator agreements
- [ ] Radio Directory listings
- [ ] Site maintenance: DJ and Artist Bios
