Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165157B485A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjJAPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjJAPQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:16:14 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA60E1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:16:10 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id mm6Aq1vneQUgRmyB0qdaAB; Sun, 01 Oct 2023 15:16:10 +0000
Received: from shared083.arvixe.com ([143.95.229.40])
        by cmsmtp with ESMTPS
        id myAzqpnelTW4QmyAzqSjIJ; Sun, 01 Oct 2023 15:16:10 +0000
X-Authority-Analysis: v=2.4 cv=AZeiolbG c=1 sm=1 tr=0 ts=65198d3a
 a=GmS1SBToaRoMP0YkDtvSoA==:117 a=GmS1SBToaRoMP0YkDtvSoA==:17
 a=bhdUkHdE2iEA:10 a=--C6PtRGR58A:10 a=r77TgQKjGQsHNAKrUKIA:9 a=Br9LfDWDAAAA:8
 a=BvthNr9T2y0k2dFIlXEA:9 a=TVSf4tJUGBojZCb-:21 a=QEXdDO2ut3YA:10
 a=TRW-o2S9CEoA:10 a=OsUonXv-ptgA:10 a=hzSvO1TcYx5CRQWsa4oA:9
 a=Gc9ueaWNVS3x2s3b:21 a=ITdVHhY7-e0A:10 a=gR_RJRYUad_6_ruzA8cR:22
Received: from [41.66.218.188] (port=60816 helo=[192.168.1.22])
        by shared083.arvixe.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <me@donjajo.com>)
        id 1qmyAy-003OHH-Ti; Sun, 01 Oct 2023 10:16:09 -0500
Content-Type: multipart/mixed; boundary="------------SNoH9m69ATXzpdkeZBX9cmNq"
Message-ID: <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
Date:   Sun, 1 Oct 2023 14:16:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <132feb67-c147-7ee6-b337-385e11786ec6@redhat.com>
 <146cb960-406b-4456-94ce-ad6ed3f330ad@donjajo.com>
 <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
From:   James John <me@donjajo.com>
In-Reply-To: <d70f7d35-6458-437d-f68f-47291ce74a1e@redhat.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - shared083.arvixe.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - donjajo.com
X-BWhitelist: no
X-Source-IP: 41.66.218.188
X-Source-L: No
X-Exim-ID: 1qmyAy-003OHH-Ti
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.22]) [41.66.218.188]:60816
X-Source-Auth: me@donjajo.com
X-Email-Count: 1
X-Org:  HG=asoshared_arvixe;ORG=aso;
X-Source-Cap: b3h5aG9scmU7b3h5aG9scmU7c2hhcmVkMDgzLmFydml4ZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMBrwbOEni+TtyqkHHhK6WdXBFe0928NFURVixV4e58OOjR/ycCvq9WpWUgTxxE83GEL+H1XBt+L0IhiMgUDrNG5bPR2NK201TbC4cqgfw/3eCUckY2R
 0OnPWpNzQWs9zzeSmyiE2ew3tIdZ3BJJxT+6IZnYDvY0z8w4YhZtJ/XFMAgblMGIDo2xRNGCDCpBLpd1TFlvThNf4AUHEgeKV5s=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------SNoH9m69ATXzpdkeZBX9cmNq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Han,

Thank you. I applied the patch and I have the inputs attached here.

After setting the hwdb filter, all the hot keys are still working except 
that the LED notification light on Mute Hotkey (F9) is no longer turning 
up on mute.

The Screen Capture, Disable Camera, and MyASUS buttons are not mapped 
yet. I believe the Screen Capture button should map to PrntScrn button, 
and MyASUS with Disable Camera unmapped, obviously. I also have the 
codes in the attached log.

Screen Capture button is KEY_UNKNOWN to evtest.

Don't hesitate to let me know if you need anything else.


Thank you!

James


On 01/10/2023 13:45, Hans de Goede wrote:
> Hi James,
>
> On 10/1/23 10:46, James John wrote:
>> Hello Han,
>>
>> Thank you very much for this detailed steps. I was able to reproduce this with "evtest" and everything went okay.
>>
>> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, the problem has been fixed, which I believe should revert on reboot?
> No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets overwritten by your
> package-manager the next time the systemd packages get updated.
>
>> This is the content of /sys/class/dmi/id/modalias
>>
>> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku:
> Thanks.
>
> Looking at:
> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>
> I see that at least one other model Asus laptop is affected too. So rather then
> adding a more specific hwdb rule for your model I would like to try and find
> the root cause of these 0x20 event code events when pressing capslock
> on your laptop.
>
>> Yes, I built my kernel. I wish I could parse this and write a proper quirk.
> Good, I've written a small kernel patch to get to the bottom of this (attached)
> can you please build a kernel with this. Then boot into this kernel and
> then run dmesg -w
>
> When you now press capslock you should see log lines show up which contain
> "raw event code 0x..."
>
> Please let me know what these lines show when pressing capslock.
>
> Please also let me know what these lines show when pressing other
> hotkeys which are handled by asus-nb-wmi (you can re-run "sudo evtest"
> to check which keys that are).
>
> I think the issue might be that the asus-wmi code is filtering out
> the higher bits of the value, which causes some new events to
> get mapped as just 0x20 instead of some-higher-bits + 0x20.
>
> Also I'm wondering if everything else works as it should,
> e.g. does changing the brightness with the brightness hotkeys
> still work after setting up the hwdb filtering ?
>
> And does the lid-switch (suspend the machine when the lid is closed)
> work ?
>
>
>> Also, I don't know if this is related; the hotkeys should be enabled by default. Fn key should be for Function keys. But in the current state, it is reversed.
> This is laptop models specific and not really controlled by Linux,
> sometimes you can change the default in the BIOS. Or sometimes you
> can change the default by pressing Fn + Esc.
>
> Regards,
>
> Hans
>
>
>
>
>> On 01/10/2023 09:28, Hans de Goede wrote:
>>> Hi James,
>>>
>>> On 10/1/23 10:11, James John wrote:
>>>> Hello,
>>>>
>>>> First of all, thank you very much for the work you do with maintaining these drivers and supporting systems. It is not an easy one.
>>>>
>>>> I have debugged this bug down to the asus_nb_wmi module. When I disable this module, the problem goes away, but then other hotkeys are not recognized. Attached is a debug event from libinput, where I pressed the capslock twice
>>>>
>>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I could fix it by luck, by adding UX5304VA to `static const struct dmi_system_id asus_quirks[]` but to no avail. And I have a very little knowledge of what "quirks" are.
>>>>
>>>> I have attached some information regarding my hardware and kernel. I will be available to provide any more information that might be needed to resolve this.
>>>>
>>>> A related open thread: https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are really coming from asus_nb_wmi.
>>>
>>> Please install evtest and then run "sudo evtest" and then select the "Asus WMI hotkeys" device
>>> by typing its number followed by enter.
>>>
>>> After this reproduce the bug and see if the log shows KEY_BRIGHTNESSDOWN.
>>>
>>> Since you said you tried playing around with the quirks, I assume you can build
>>> your own kernel, please let me know if that is wrong.
>>>
>>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the "Asus WMI hotkeys" device,
>>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>>
>>> And search for "Asus WMI hotkeys", this should find this section:
>>>
>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>
>>> Change this to:
>>>
>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>    KEYBOARD_KEY_6b=f21                                    # Touchpad Toggle
>>>    KEYBOARD_KEY_7c=f20                                    # Remap micmute to f20
>>>    KEYBOARD_KEY_20=unknown
>>>
>>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm trigger",
>>> that should filter out the spurious keypresses.
>>>
>>> If that helps, please run:
>>>
>>> cat /sys/class/dmi/id/modalias
>>>
>>> So that a proper DMI based quirk to only to the filtering on your model
>>> can be written.
>>>
>>> Regards,
>>>
>>> Hans
>>>
--------------SNoH9m69ATXzpdkeZBX9cmNq
Content-Type: text/x-log; charset=UTF-8; name="inputs.log"
Content-Disposition: attachment; filename="inputs.log"
Content-Transfer-Encoding: base64

Q0FQU0xPQ0sgQlVUVE9OClsxNzE2My42NjY2MzNdIGFzdXNfd21pOiByYXcgZXZlbnQgY29k
ZSAweDJjClsxNzE2My42NjY2ODZdIGFzdXNfd21pOiByYXcgZXZlbnQgY29kZSAweGZmZmZm
ZmZmZmZmZmZmZmYKWzE3MTcxLjQ3OTU3M10gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4
MmMKWzE3MTcxLjQ3OTYxMl0gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4ZmZmZmZmZmZm
ZmZmZmZmZgoKUFJOVFNDUk4gQlVUVE9OClsxNzUxNS4xMDQ4OTddIGFzdXNfd21pOiByYXcg
ZXZlbnQgY29kZSAweDJiClsxNzUxNS4xMDQ5NDldIGFzdXNfd21pOiByYXcgZXZlbnQgY29k
ZSAweGZmZmZmZmZmZmZmZmZmZmYKWzE3NTIwLjczMzI5OV0gYXN1c193bWk6IHJhdyBldmVu
dCBjb2RlIDB4MmIKWzE3NTIwLjczMzMzMV0gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4
ZmZmZmZmZmZmZmZmZmZmZgoKQkFDS0xJR0hUIEJVVFRPTgpbMTcyOTkuMTY2MzEzXSBhc3Vz
X3dtaTogcmF3IGV2ZW50IGNvZGUgMHgyZQpbMTcyOTkuMTY2MzcwXSBhc3VzX3dtaTogcmF3
IGV2ZW50IGNvZGUgMHhmZmZmZmZmZmZmZmZmZmZmClsxNzMwMi4zODY2MDddIGFzdXNfd21p
OiByYXcgZXZlbnQgY29kZSAweDJlClsxNzMwMi4zODY2NjNdIGFzdXNfd21pOiByYXcgZXZl
bnQgY29kZSAweGZmZmZmZmZmZmZmZmZmZmYKCkJBQ0tMSUdIVCBVUCBCVVRUT04KWzE3MzMy
LjA4MDYzMl0gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4MmYKWzE3MzMyLjA4MDcyN10g
YXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4ZmZmZmZmZmZmZmZmZmZmZgpbMTczMzIuNDk3
MTE4XSBhc3VzX3dtaTogcmF3IGV2ZW50IGNvZGUgMHgyZgpbMTczMzIuNDk3MTkyXSBhc3Vz
X3dtaTogcmF3IGV2ZW50IGNvZGUgMHhmZmZmZmZmZmZmZmZmZmZmCgpTQ1JFRU4gQ0FQVFVS
RSBCVVRUT04KXlhAc3NbMjAyOTkuNjc4NTI0XSBhc3VzX3dtaTogcmF3IGV2ZW50IGNvZGUg
MHgyYQpbMjAyOTkuNjc4NTQ3XSBhc3VzX3dtaTogcmF3IGV2ZW50IGNvZGUgMHhmZmZmZmZm
ZmZmZmZmZmZmCl5YQHNzWzIwMzA0LjI3NTg0MF0gYXN1c193bWk6IHJhdyBldmVudCBjb2Rl
IDB4MmEKWzIwMzA0LjI3NTkxM10gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4ZmZmZmZm
ZmZmZmZmZmZmZgoKTXlBU1VTIEJVVFRPTgpbMjAzNjIuMzIyNzc4XSBhc3VzX3dtaTogcmF3
IGV2ZW50IGNvZGUgMHhmZmZmZmZmZmZmZmZmZmZmClsyMDM2Mi42MjI2MjRdIGFzdXNfd21p
OiByYXcgZXZlbnQgY29kZSAweDg2ClsyMDM2Mi42MjI3MjhdIGFzdXNfd21pOiByYXcgZXZl
bnQgY29kZSAweGZmZmZmZmZmZmZmZmZmZmYKWzIwMzYzLjI0OTIwNV0gYXN1c193bWk6IHJh
dyBldmVudCBjb2RlIDB4ODYKWzIwMzYzLjI0OTI4M10gYXN1c193bWk6IHJhdyBldmVudCBj
b2RlIDB4ZmZmZmZmZmZmZmZmZmZmZgoKTVVURSBCVVRUT04KWzIwOTQyLjQ4OTEzNF0gYXN1
c193bWk6IHJhdyBldmVudCBjb2RlIDB4N2MKWzIwOTQyLjQ4OTIzOV0gYXN1c193bWk6IHJh
dyBldmVudCBjb2RlIDB4ZmZmZmZmZmZmZmZmZmZmZgpbMjA5NDMuMjIyNDk1XSBhc3VzX3dt
aTogcmF3IGV2ZW50IGNvZGUgMHg3YwpbMjA5NDMuMjIyNTkyXSBhc3VzX3dtaTogcmF3IGV2
ZW50IGNvZGUgMHhmZmZmZmZmZmZmZmZmZmZmCgpESVNBQkxFIENBTUVSQSBCVVRUT04KWzIx
MDAyLjU4MjM3OV0gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4ODUKWzIxMDAyLjU4MjQ3
NV0gYXN1c193bWk6IHJhdyBldmVudCBjb2RlIDB4ZmZmZmZmZmZmZmZmZmZmZgpbMjEwMDMu
MDQ1ODgxXSBhc3VzX3dtaTogcmF3IGV2ZW50IGNvZGUgMHg4NQpbMjEwMDMuMDQ2MDA4XSBh
c3VzX3dtaTogcmF3IGV2ZW50IGNvZGUgMHhmZmZmZmZmZmZmZmZmZmZmCg==

--------------SNoH9m69ATXzpdkeZBX9cmNq--
