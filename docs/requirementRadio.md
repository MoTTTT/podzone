# Radio Requirements

Build a radio station on the kubernetes cluster. The Minimum Viable Product uses existing infrastructure, audio equipment and vinyl library.

## Minimum Viable Product Themes

1. Icecast - Stream audio tracks from network file storage
1. DJ - Schedule playlists of uploaded content
1. Radio - Stream in from icecast source for broadcast from a DJ installation
1. Listener - View Radio Station web page with embedded playback and schedule

---

## Functional Breakdown

### MVP Use cases

- [X] Admin: Create Programme Manager
- [X] Programme Manager: Create DJ user
- [X] Programme Manager: Create Show
- [X] DJ: Create Playlist
- [X] DJ: Upload tracks
- [X] DJ: Add track to playlist
- [X] DJ: Assign tracks and playlist to Show

### Non-Functional Requirements

- [X] Security: Administration access
- [X] Radio: Domain registration and email forwarding: <radio@muso.club>
- [ ] Social media registrations
- [X] YouTube channel
- [X] Website: DJ Profiles
- [ ] Website: Social media links
- [ ] Icecast: Configure for directory listing
- [ ] Failover: Automated recovery on node failure

## Tasklist

### Issues and bugs

- [X] Media upload limited to 8MB - configure for 15MB
- [ ] Media upload limited to 15MB - configure for +++MB
- [ ] Router: Losing port forwarding
- [ ] Buffer size gives 10s delay before a listener plays

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
- [X] Default schedule
- [ ] YouTube interviews
- [ ] Intros, Exits, and Jingles
- [ ] Media kit
- [X] Site Copy
- [X] Bio Template
- [ ] About Us
- [ ] Build: Backup and restore
- [X] Email address
- [X] Social Media: YouTube
- [ ] Paperwork (see below)
- [X] Security: override chart default passwords

#### Bio Template

- Featured image
- Logo
- Contact details
- YouTube interview
- Free-form Bio paragraph
- Regular or upcoming gigs
- Social media links
- Audio tracks

#### Radio@Muso.Club YouTube interviews

Focus points (to keep it related to the music):

- What is your first memory of music
- What are your top 5 favourite genres
- Any genre you prefer not to hear? For more than an hour?
- What music do you most like to listen to at different times of the day?
- - In the morning
- - In the afternoon
- - In the evening
- - In the late evening
- Do you ever need there to be no music? For how long?
- What music do you most like making
- Favourite musical instrument to listen to?
- Favourite musical instrument to play? Did you learn to play anything, or sing, as a kid?
- Next five most favourite instruments to play?
- Best gig? Worst gig?
- Any upcoming gigs?

Interviews:

- [ ] Niko: Musician Interviewer
- [ ] Thandi: Creatives
- [ ] Torrell: Featured Musician
- [ ] Johnathan: Featured Musician
- [ ] Kholeho: Featured Musician

#### Default Schedule

Build themed playlists for daily use (to fill the programme in POV phase), for example:

- Classical
- Blues
- Jazz
- Class of '84
- 60s
- Favourite Females
- Reggae
- Rock

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
- [X] Streaming session from Field Audio Interface
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
- [X] Listening soak
- [ ] Listening load
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
