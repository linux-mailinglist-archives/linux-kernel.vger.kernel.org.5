Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987887B485C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjJAPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjJAPTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:19:05 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE717DA
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 08:19:02 -0700 (PDT)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTP
        id mwJQqHCqeIBlVmyDMqkYEo; Sun, 01 Oct 2023 15:18:36 +0000
Received: from shared083.arvixe.com ([143.95.229.40])
        by cmsmtp with ESMTPS
        id myDlqdwA5qTWcmyDlqjvWc; Sun, 01 Oct 2023 15:19:01 +0000
X-Authority-Analysis: v=2.4 cv=ParsOwtd c=1 sm=1 tr=0 ts=65198de5
 a=GmS1SBToaRoMP0YkDtvSoA==:117 a=GmS1SBToaRoMP0YkDtvSoA==:17
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=--C6PtRGR58A:10 a=Br9LfDWDAAAA:8
 a=h_pxgrHeMo6Z4TjjLiIA:9 a=GzqaNksu6BwvG3Fm:21 a=QEXdDO2ut3YA:10
 a=TRW-o2S9CEoA:10 a=OsUonXv-ptgA:10 a=gR_RJRYUad_6_ruzA8cR:22
Received: from [41.66.218.188] (port=37278 helo=[192.168.1.22])
        by shared083.arvixe.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <me@donjajo.com>)
        id 1qmyDk-003P6e-EP; Sun, 01 Oct 2023 10:19:00 -0500
Message-ID: <c98cbd94-9f2e-4af4-ad86-91a95471fc57@donjajo.com>
Date:   Sun, 1 Oct 2023 14:18:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS
 Lock and PrntScrn on Zenbook S 13 UX5304VA
Content-Language: en-US
From:   James John <me@donjajo.com>
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
 <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
In-Reply-To: <90a7309e-4a76-4dff-8259-9975dd3ed8b1@donjajo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - shared083.arvixe.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - donjajo.com
X-BWhitelist: no
X-Source-IP: 41.66.218.188
X-Source-L: No
X-Exim-ID: 1qmyDk-003P6e-EP
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.22]) [41.66.218.188]:37278
X-Source-Auth: me@donjajo.com
X-Email-Count: 8
X-Org:  HG=asoshared_arvixe;ORG=aso;
X-Source-Cap: b3h5aG9scmU7b3h5aG9scmU7c2hhcmVkMDgzLmFydml4ZS5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIarCJA6h9XQNDR+SA951xRe1e8idwrEm3+v9QpdlN9tiUVal/Sx4PeO1/7jUa3GOa//v+t3JYs/7zPXaR+ESc3l0IkUFDujK7+1AGqzCmgiYzZz+92+
 dG9WC1cxXMsWIfxoCa5STj5ya0aQ/h9sOz8Fy3PV0O8twFebXmwLystYhP9hiwJulqfUahfIr+JvtUXHnipj4TRkoeNg4Z5+/hk=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lid Close to Suspend still works as well.

On 01/10/2023 14:16, James John wrote:
> Hello Han,
>
> Thank you. I applied the patch and I have the inputs attached here.
>
> After setting the hwdb filter, all the hot keys are still working 
> except that the LED notification light on Mute Hotkey (F9) is no 
> longer turning up on mute.
>
> The Screen Capture, Disable Camera, and MyASUS buttons are not mapped 
> yet. I believe the Screen Capture button should map to PrntScrn 
> button, and MyASUS with Disable Camera unmapped, obviously. I also 
> have the codes in the attached log.
>
> Screen Capture button is KEY_UNKNOWN to evtest.
>
> Don't hesitate to let me know if you need anything else.
>
>
> Thank you!
>
> James
>
>
> On 01/10/2023 13:45, Hans de Goede wrote:
>> Hi James,
>>
>> On 10/1/23 10:46, James John wrote:
>>> Hello Han,
>>>
>>> Thank you very much for this detailed steps. I was able to reproduce 
>>> this with "evtest" and everything went okay.
>>>
>>> After editing /lib/udev/hwdb.d/60-keyboarrd.hwdb as you specified, 
>>> the problem has been fixed, which I believe should revert on reboot?
>> No this will fix it until /lib/udev/hwdb.d/60-keyboarrd.hwdb gets 
>> overwritten by your
>> package-manager the next time the systemd packages get updated.
>>
>>> This is the content of /sys/class/dmi/id/modalias
>>>
>>> dmi:bvnAmericanMegatrendsInternational,LLC.:bvrUX5304VA.304:bd05/16/2023:br5.27:svnASUSTeKCOMPUTERINC.:pnZenbookS13UX5304VA_UX5304VA:pvr1.0:rvnASUSTeKCOMPUTERINC.:rnUX5304VA:rvr1.0:cvnASUSTeKCOMPUTERINC.:ct10:cvr1.0:sku: 
>>>
>> Thanks.
>>
>> Looking at:
>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>
>> I see that at least one other model Asus laptop is affected too. So 
>> rather then
>> adding a more specific hwdb rule for your model I would like to try 
>> and find
>> the root cause of these 0x20 event code events when pressing capslock
>> on your laptop.
>>
>>> Yes, I built my kernel. I wish I could parse this and write a proper 
>>> quirk.
>> Good, I've written a small kernel patch to get to the bottom of this 
>> (attached)
>> can you please build a kernel with this. Then boot into this kernel and
>> then run dmesg -w
>>
>> When you now press capslock you should see log lines show up which 
>> contain
>> "raw event code 0x..."
>>
>> Please let me know what these lines show when pressing capslock.
>>
>> Please also let me know what these lines show when pressing other
>> hotkeys which are handled by asus-nb-wmi (you can re-run "sudo evtest"
>> to check which keys that are).
>>
>> I think the issue might be that the asus-wmi code is filtering out
>> the higher bits of the value, which causes some new events to
>> get mapped as just 0x20 instead of some-higher-bits + 0x20.
>>
>> Also I'm wondering if everything else works as it should,
>> e.g. does changing the brightness with the brightness hotkeys
>> still work after setting up the hwdb filtering ?
>>
>> And does the lid-switch (suspend the machine when the lid is closed)
>> work ?
>>
>>
>>> Also, I don't know if this is related; the hotkeys should be enabled 
>>> by default. Fn key should be for Function keys. But in the current 
>>> state, it is reversed.
>> This is laptop models specific and not really controlled by Linux,
>> sometimes you can change the default in the BIOS. Or sometimes you
>> can change the default by pressing Fn + Esc.
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>>
>>> On 01/10/2023 09:28, Hans de Goede wrote:
>>>> Hi James,
>>>>
>>>> On 10/1/23 10:11, James John wrote:
>>>>> Hello,
>>>>>
>>>>> First of all, thank you very much for the work you do with 
>>>>> maintaining these drivers and supporting systems. It is not an 
>>>>> easy one.
>>>>>
>>>>> I have debugged this bug down to the asus_nb_wmi module. When I 
>>>>> disable this module, the problem goes away, but then other hotkeys 
>>>>> are not recognized. Attached is a debug event from libinput, where 
>>>>> I pressed the capslock twice
>>>>>
>>>>> I have tried to dabble around with asus-nb-wmi.c codes to see if I 
>>>>> could fix it by luck, by adding UX5304VA to `static const struct 
>>>>> dmi_system_id asus_quirks[]` but to no avail. And I have a very 
>>>>> little knowledge of what "quirks" are.
>>>>>
>>>>> I have attached some information regarding my hardware and kernel. 
>>>>> I will be available to provide any more information that might be 
>>>>> needed to resolve this.
>>>>>
>>>>> A related open thread: 
>>>>> https://bbs.archlinux.org/viewtopic.php?pid=2123716
>>>> First of all lets confirm that the KEY_BRIGHTNESSDOWN events are 
>>>> really coming from asus_nb_wmi.
>>>>
>>>> Please install evtest and then run "sudo evtest" and then select 
>>>> the "Asus WMI hotkeys" device
>>>> by typing its number followed by enter.
>>>>
>>>> After this reproduce the bug and see if the log shows 
>>>> KEY_BRIGHTNESSDOWN.
>>>>
>>>> Since you said you tried playing around with the quirks, I assume 
>>>> you can build
>>>> your own kernel, please let me know if that is wrong.
>>>>
>>>> If this confirms the KEY_BRIGHTNESSDOWN events are coming from the 
>>>> "Asus WMI hotkeys" device,
>>>> then please edit /lib/udev/hwdb.d/60-keyboard.hwdb
>>>>
>>>> And search for "Asus WMI hotkeys", this should find this section:
>>>>
>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>    KEYBOARD_KEY_6b=f21                                    # 
>>>> Touchpad Toggle
>>>>    KEYBOARD_KEY_7c=f20                                    # Remap 
>>>> micmute to f20
>>>>
>>>> Change this to:
>>>>
>>>> evdev:name:Asus WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Eee PC WMI hotkeys:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>> evdev:name:Asus Laptop extra buttons:dmi:bvn*:bvr*:bd*:svnASUS*:pn*:*
>>>>    KEYBOARD_KEY_6b=f21                                    # 
>>>> Touchpad Toggle
>>>>    KEYBOARD_KEY_7c=f20                                    # Remap 
>>>> micmute to f20
>>>>    KEYBOARD_KEY_20=unknown
>>>>
>>>> And then run "sudo udevadm hwdb --update" followed by "sudo udevadm 
>>>> trigger",
>>>> that should filter out the spurious keypresses.
>>>>
>>>> If that helps, please run:
>>>>
>>>> cat /sys/class/dmi/id/modalias
>>>>
>>>> So that a proper DMI based quirk to only to the filtering on your 
>>>> model
>>>> can be written.
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
