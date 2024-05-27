# Radio Troubleshooting

More detailed testing will be required to determine feasibility of the architecture, and the solution.

In addition, due to the nature of the failure, and it's impact on the default program, a test installation will be constructed for more extensive testing.

## Issues

- [ ] Manual switch to stream via the gui required: automation of connect and disconnect was assumed to have caused previous streaming silence incident.
- [ ] Automated stream kick at the end of the session is not working.
- [ ] DJ source stream stop fallback to playlist failed
- [ ] Scheduled play-out the default radio program after dj session was complete, did not deliver audio (silence) to the broadcaster.
- [ ] Console controls for streaming incorrectly indicate stream status, and stream connection status.

### Issue notes

- Scheduled tracks and show changes ran as normal, but no audio.
- Deletion of playout / liquidsoap pod restored the service, but not immediately or completely.

## Decoupling incoming streams from radio infrastructure

Also, testing of streaming, run during live gig sound checks, needs to be decoupled from the station schedule. Changing the mount-point between sound check test and radio broadcasted schedule would solve this, but it is not preferred to make changes between sound-check and live performance. Using a dedicated mount on the broadcaster, and scheduling it into the radio schedule as a webstream will be investigated as a more flexible solution. This also provides a more comprehensive broadcast service to members.

## Logs

### Logs after failure (logs at time of initial failure expired).

### Reference logs for default program

Normally, during playlist playback, the playout logs look like this, after a restart (delete and automated redeploy) of the liquidsoap-playout pod:

```log
2024-05-27 13:14:41,990 | INFO     | libretime_playout.main:cli:100 - Timezone: ('UTC', 'UTC')
2024-05-27 13:14:41,991 | INFO     | libretime_playout.main:cli:101 - UTC time: 2024-05-27 13:14:41.991703
2024-05-27 13:14:42,201 | WARNING  | libretime_playout.liquidsoap.client._client:wait_for_version:62 - could not get version: [Errno 111] Connection refused
2024-05-27 13:14:43,203 | WARNING  | libretime_playout.liquidsoap.client._client:wait_for_version:62 - could not get version: [Errno 111] Connection refused
2024-05-27 13:14:44,205 | WARNING  | libretime_playout.liquidsoap.client._client:wait_for_version:62 - could not get version: [Errno 111] Connection refused
2024-05-27 13:14:45,233 | INFO     | libretime_playout.liquidsoap.client._client:wait_for_version:59 - found version (1, 4, 3)
2024-05-27 13:14:45,238 | INFO     | libretime_playout.player.fetch:__init__:62 - PypoFetch: init complete
2024-05-27 13:14:45,243 | INFO     | libretime_playout.player.queue:main:36 - waiting indefinitely for schedule
2024-05-27 13:14:45,246 | INFO     | libretime_playout.history.stats:run:152 - starting stats collector
2024-05-27 13:14:45,436 | INFO     | libretime_playout.message_handler:run_forever:96 - starting message handler
2024-05-27 13:14:45,528 | INFO     | kombu.mixins:Consumer:229 - Connected to amqp://libretime:**@rabbitmq:5672//libretime
2024-05-27 13:14:52,567 | INFO     | libretime_playout.message_handler:on_message:47 - handling event reset_liquidsoap_bootstrap: {'event_type': 'reset_liquidsoap_bootstrap'}
2024-05-27 13:14:53,308 | INFO     | libretime_playout.message_handler:on_message:47 - handling event update_schedule: {'event_type': 'update_schedule'}
2024-05-27 13:15:34,670 | INFO     | libretime_playout.message_handler:on_message:47 - handling event switch_source: {'sourcename': 'live_dj', 'status': 'on', 'event_type': 'switch_source'}
2024-05-27 13:16:15,520 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 102 to cache /app/scheduler/102.mp3
2024-05-27 13:16:15,527 | INFO     | libretime_playout.player.liquidsoap:verify_correct_present_media:286 - Need to add items to Liquidsoap *now*: {4769}
Stream closed EOF for radio/liquidsoap-playout-84d64f5d75-s6czn (playout)

2024-05-27 17:51:05,681 | INFO     | libretime_playout.player.fetch:main:311 - Loop #60
2024-05-27 17:54:33,048 | INFO     | libretime_playout.player.queue:main:39 - waiting 240.951156s until next scheduled item
2024-05-27 17:57:45,681 | INFO     | libretime_playout.player.fetch:main:332 - Queue timeout. Fetching schedule manually
2024-05-27 17:58:34,042 | INFO     | libretime_playout.player.queue:main:39 - waiting 189.957957s until next scheduled item
2024-05-27 17:59:09,879 | INFO     | libretime_playout.player.queue:main:57 - New schedule received
2024-05-27 17:59:09,881 | INFO     | libretime_playout.player.queue:main:39 - waiting 154.118266s until next scheduled item
2024-05-27 17:59:09,925 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 722 to cache /app/scheduler/722.mp3
2024-05-27 17:59:09,987 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/760.mp3' removed
2024-05-27 17:59:10,066 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 775 to cache /app/scheduler/775.mp3
2024-05-27 17:59:10,117 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/605.mp3' removed

2024-05-27 17:59:10,117 | INFO     | libretime_playout.player.fetch:main:311 - Loop #61
2024-05-27 18:01:03,786 | INFO     | libretime_playout.message_handler:on_message:47 - handling event update_schedule: {'event_type': 'update_schedule'}
2024-05-27 18:01:44,035 | INFO     | libretime_playout.player.queue:main:39 - waiting 270.964979s until next scheduled item
2024-05-27 18:02:29,481 | INFO     | libretime_playout.player.queue:main:57 - New schedule received
2024-05-27 18:02:29,483 | INFO     | libretime_playout.player.queue:main:39 - waiting 225.516333s until next scheduled item
2024-05-27 18:02:29,491 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 687 to cache /app/scheduler/687.mp3
2024-05-27 18:02:29,603 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/699.mp3' removed
2024-05-27 18:02:29,604 | INFO     | libretime_playout.player.fetch:handle_message:110 - New timeout: 400.0

2024-05-27 18:02:29,605 | INFO     | libretime_playout.player.fetch:main:311 - Loop #62
2024-05-27 18:06:15,004 | INFO     | libretime_playout.player.queue:main:39 - waiting 170.995881s until next scheduled item
2024-05-27 18:09:06,016 | INFO     | libretime_playout.player.queue:main:39 - waiting 194.983447s until next scheduled item
2024-05-27 18:09:09,605 | INFO     | libretime_playout.player.fetch:main:332 - Queue timeout. Fetching schedule manually
2024-05-27 18:10:37,417 | INFO     | libretime_playout.player.queue:main:57 - New schedule received
2024-05-27 18:10:37,418 | INFO     | libretime_playout.player.queue:main:39 - waiting 103.58131s until next scheduled item
2024-05-27 18:10:37,456 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 759 to cache /app/scheduler/759.mp3
2024-05-27 18:10:37,520 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/603.mp3' removed
2024-05-27 18:10:37,592 | INFO     | libretime_playout.player.file:copy_file:47 - copying file 820 to cache /app/scheduler/820.mp3
2024-05-27 18:10:37,628 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/676.mp3' removed
2024-05-27 18:10:37,745 | INFO     | libretime_playout.player.fetch:cache_cleanup:255 - File '/app/scheduler/750.mp3' removed
```

Liquidsoap logs:

```log
2024/05/27 13:16:25 >>> LOG START
2024/05/27 13:16:25 [main:3] Liquidsoap 1.4.3
2024/05/27 13:16:25 [main:3] Using: bytes=[distributed with OCaml 4.02 or above] pcre=[unspecified] sedlex=2.2 menhirLib=20201216 dtools=0.4.2 duppy=0.8.0 cry=0.6.5 mm=0.5.0 xmlplaylist=0.1.5 lastfm=0.3.2 ogg=0.5.2 vorbis=0.7.1 opus=0.1.3 speex=0.2.1 mad=0.4.6 flac=0.1.7 flac.ogg=0.1.7 dynlink=[distributed with Ocaml] lame=0.3.4 shine=0.2.1 gstreamer=0.3.0 frei0r=0.1.1 theora=0.3.1 gavl=0.1.6 ffmpeg=0.4.3 bjack=0.1.5 alsa=0.3.0 ao=0.2.1 samplerate=0.1.4 taglib=0.3.6 ssl=0.5.9 magic=0.7.3 camomile=[unspecified] inotify=2.3 yojson=[unspecified] faad=0.4.0 soundtouch=0.1.8 portaudio=0.2.1 pulseaudio=0.1.3 ladspa=0.1.5 sdl=0.9.1 camlimages=4.2.6 lo=0.1.2 gd=1.0a5
2024/05/27 13:16:25 [gstreamer.loader:3] Loaded GStreamer 1.18.4 0
2024/05/27 13:16:25 [dynamic.loader:3] Could not find dynamic module for fdkaac encoder.
2024/05/27 13:16:25 [frame:3] Using 44100Hz audio, 25Hz video, 44100Hz master.
2024/05/27 13:16:25 [frame:3] Frame size must be a multiple of 1764 ticks = 1764 audio samples = 1 video samples.
2024/05/27 13:16:25 [frame:3] Targetting 'frame.duration': 0.04s = 1764 audio samples = 1764 ticks.
2024/05/27 13:16:25 [frame:3] Frames last 0.04s = 1764 audio samples = 1 video samples = 1764 ticks.
2024/05/27 13:16:25 [lang:3] timeout --signal=KILL 45 libretime-playout-notify started &
2024/05/27 13:16:25 [sandbox:3] Could not find binary bwrap, disabling sandboxing..
2024/05/27 13:16:25 [video.converter:3] Using preferred video converter: gavl.
2024/05/27 13:16:25 [audio.converter:3] Using samplerate converter: ffmpeg.
2024/05/27 13:16:25 [harbor:3] Adding mountpoint '/show' on port 8002
2024/05/27 13:16:25 [harbor:3] Adding mountpoint '/main' on port 8001
2024/05/27 13:16:25 [icecast:1:3] Connecting mount main for source@icecast.radio.svc.cluster.local...
2024/05/27 13:16:25 [icecast:1:3] Connection setup was successful.
2024/05/27 13:16:25 [lang:3] timeout --signal=KILL 45 libretime-playout-notify stream '1' '1716815785.52' &
2024/05/27 13:16:26 [clock.wallclock_main:3] Streaming loop starts, synchronized with wallclock.
2024/05/27 13:16:26 [map_metadata:offline:3] Inserting missing metadata.
2024/05/27 13:16:26 [switch:blank+schedule+show+main:3] Switch to switch:blank+schedule+show.
2024/05/27 13:16:26 [switch:blank+schedule+show:3] Switch to switch:blank+schedule.
2024/05/27 13:16:26 [switch:blank+schedule:3] Switch to map_metadata:offline.
2024-05-27 13:16:32,485 | INFO     | libretime_playout.notify.main:stream:154 - Sending output stream '1' status 'OK'
2024/05/27 13:16:59 [server:3] New client: 127.0.0.1.
2024/05/27 13:16:59 [server:3] Client 127.0.0.1 disconnected.
2024/05/27 13:16:59 [decoder:3] Method "FFMPEG" accepted "/app/scheduler/227.mp3".
2024/05/27 13:16:59 [s3:3] Prepared "/app/scheduler/227.mp3" (RID 0).
2024/05/27 13:16:59 [switch_9646:3] Switch to insert_metadata_9631.
2024/05/27 13:16:59 [ffmpeg:3] [mp3float @ 0x7f3a7c0100c0] Could not update timestamps for skipped samples.
2024/05/27 13:16:59 [lang:3] timeout --signal=KILL 45 libretime-playout-notify media '4770' &
2024/05/27 13:16:59 [lang:3] Using message format 0
2024/05/27 13:16:59 [lang:3] Using message format 0
2024-05-27 13:17:05,052 | INFO     | libretime_playout.notify.main:media:73 - Sending currently playing media id '4770'
2024/05/27 13:17:59 [server:3] New client: 127.0.0.1.
2024/05/27 13:17:59 [lang:3] web_stream.get_id
2024/05/27 13:17:59 [server:3] Client 127.0.0.1 disconnected.
2024/05/27 13:17:59 [server:3] New client: 127.0.0.1.
2024/05/27 13:17:59 [lang:3] sources.start_input_show
2024/05/27 13:17:59 [server:3] Client 127.0.0.1 disconnected.
Stream closed EOF for radio/liquidsoap-playout-84d64f5d75-s6czn (liquidsoap)


2024/05/27 18:41:09 [ffmpeg:3] [mp3float @ 0x7f3a7c4d8ec0] Could not update timestamps for discarded samples.
2024/05/27 18:41:09 [cue_cut_9615:3] End of track before cue-out point.
2024/05/27 18:41:09 [dummy:3] Source failed (no more tracks) stopping output...
2024/05/27 18:41:09 [dummy(dot)2:3] Source failed (no more tracks) stopping output...
2024/05/27 18:41:09 [switch:blank+schedule:3] Switch to map_metadata:offline with forgetful transition.

2024/05/27 18:41:09 [lang:3] transition called...
2024/05/27 18:41:10 [server:3] New client: 127.0.0.1.
2024/05/27 18:41:10 [decoder:3] Method "FFMPEG" accepted "/app/scheduler/667.mp3".
2024/05/27 18:41:10 [server:3] Client 127.0.0.1 disconnected.
2024/05/27 18:41:10 [s3:3] Prepared "/app/scheduler/667.mp3" (RID 2).
2024/05/27 18:41:10 [switch:blank+schedule:3] Switch to map_metadata:schedule with transition.

2024/05/27 18:41:10 [lang:3] transition called...
2024/05/27 18:41:10 [switch_9646:3] Switch to insert_metadata_9631.
2024/05/27 18:41:10 [ffmpeg:3] [mp3float @ 0x7f3a7d4bb300] Could not update timestamps for skipped samples.
2024/05/27 18:41:10 [lang:3] timeout --signal=KILL 45 libretime-playout-notify media '12813' &
2024/05/27 18:41:10 [lang:3] Using message format 0
2024/05/27 18:41:10 [lang:3] Using message format 0
2024-05-27 18:41:15,145 | INFO     | libretime_playout.notify.main:media:73 - Sending currently playing media id '12813'

2024/05/27 18:42:52 [server:3] New client: 127.0.0.1.
2024/05/27 18:42:52 [lang:3] web_stream.get_id
2024/05/27 18:42:52 [server:3] Client 127.0.0.1 disconnected.
2024/05/27 18:43:20 [ffmpeg:3] [mp3float @ 0x7f3a7d4bb300] Could not update timestamps for discarded samples.

2024/05/27 18:43:21 [server:3] New client: 127.0.0.1.
2024/05/27 18:43:21 [decoder:3] Method "FFMPEG" accepted "/app/scheduler/595.mp3".
2024/05/27 18:43:21 [server:3] Client 127.0.0.1 disconnected.
2024/05/27 18:43:21 [cue_cut_9615:3] End of track before cue-out point.
2024/05/27 18:43:21 [s3:3] Prepared "/app/scheduler/595.mp3" (RID 3).
2024/05/27 18:43:21 [ffmpeg:3] [mp3float @ 0x7f3a7c060080] Could not update timestamps for skipped samples.
2024/05/27 18:43:21 [lang:3] timeout --signal=KILL 45 libretime-playout-notify media '12814' &
2024/05/27 18:43:21 [lang:3] Using message format 0
2024/05/27 18:43:21 [lang:3] Using message format 0
2024-05-27 18:43:25,391 | INFO     | libretime_playout.notify.main:media:73 - Sending currently playing media id '12814'
```