# Radio Requirements

Build a radio station on the kubernetes cluster. The Minimum Viable Product uses existing infrastructure, audio equipment and vinyl library.

## Minimum Viable Product Themes

1. Icecast - Stream audio tracks from network file storage
1. DJ - Schedule playlists of uploaded content
1. Radio - Stream in from icecast source for broadcast from a DJ installation
1. Listener - View Radio Station web page with embedded playback and schedule

---

### MVP Use cases

- [ ] Admin: Create Programme Manager
- [ ] Programme Manager: Create DJ user
- [ ] Programme Manager: Create Show
- [ ] DJ: Create Playlist
- [ ] DJ: Upload tracks
- [ ] DJ: Add track to playlist
- [ ] DJ: Assign tracks and playlist to Show

## Non-Functional Requirements

- [ ] Security: Administration access
- [X] Radio: Domain registration and email forwarding: radio.muso.club
- [ ] Social media registrations
- [ ] YouTube channel
- [ ] Website: DJ Profiles
- [ ] Website: Social media links
- [ ] Icecast: Configure for directory listing
- [ ] Failover: Automated recovery on node failure

## Tasklist

### Issues and bugs

- [X] Media upload limited to 8MB - configure for 15MB

### Station Build

- [X] Library: 12" Vinyl {clean, sort, select and record}
- [X] Library: 7" Vinyl {clean, sort, select and record}
- [X] CD Library: Select and dub
- [X] Turntables
- [X] Mixer
- [X] Microphone
- [X] Audio Interface: vinyl
- [X] Audio Interface: live streaming
- [X] Hardware: k8s cluster dev (devcluster)
- [X] Hardware: k8s cluster prod (norham)
- [X] Installation: Admin tools {kubectl,k8s}
- [X] Installation: DJ Tools: butt {vinyl recording, live streaming}
- [X] Installation: DJ Tools: mixxx {DJ session, with microphone}

### System Build

- [X] Flex radio system definition
- [X] Ingress for Radio Console
- [X] Ingress for Media Upload
- [X] Ingress for Radio Listener
- [X] Ingress for Field streaming client
- [X] Configuration: ogg -> mp3 stream
- [ ] Default schedule
- [ ] Intros, Exits, and Jingles
- [ ] Media kit
- [ ] Site Copy
- [ ] Bio Template
- [ ] About Us
- [ ] Build: Backup and restore
- [ ] Email address and Social Media accounts
- [ ] Paperwork (see below)
- [X] Security: override chart default passwords

#### Default Schedule

Build themed playlists for daily use (to fill the programme in POV phase), for example:

- Blues
- 60s
- Class of '84
- Favourite Females
- Reggae
- Rock
- Jazz
- Classical

As collaborators come on line, starting in POV phase, substitute playlist slots with:

- Live performances
- Live DJ slots
- Original Collections
- Talk shows
- Interviews {starting with DJs and Collaborators}

Record these, where applicable for re-run purposes.

### Test

- [X] DJ Creation
- [X] Playlist creation
- [X] Session (repeat) creation
- [X] Streaming session from BUTT
- [X] Streaming session from MIXXX
- [X] Streaming session from iziCast iPhone
- [ ] Streaming session from Field Audio Interface
- [X] Off-premise session streaming
- [X] Streaming authentication and cut-over
- [X] Audio file upload
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
- [ ] Failover

### Operations and Management

Interest gauged positive on all engagements checked.

- [X] Creative Brief for site structure, branding and content {Thandi}
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
- Michael
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
- [X] Broadcast Licencing commitments
- [ ] Collaborator agreements
- [ ] Radio Directory listings
- [ ] Site maintenance: DJ and Artist Bios
