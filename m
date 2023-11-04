Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DE47E0F4A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKDMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:07:52 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Nov 2023 05:07:48 PDT
Received: from smtpout4.mo536.mail-out.ovh.net (smtpout4.mo536.mail-out.ovh.net [51.210.91.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C59E3
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:07:48 -0700 (PDT)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
        by mo536.mail-out.ovh.net (Postfix) with ESMTPS id 556C6200FD;
        Sat,  4 Nov 2023 12:01:58 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <bagasdotme@gmail.com>; Sat,  4 Nov 2023 12:01:58 +0000 (UTC)
Received: from pro2.mail.ovh.net (unknown [10.108.16.206])
        by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id DF676201350;
        Sat,  4 Nov 2023 12:01:57 +0000 (UTC)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 4 Nov
 2023 13:01:57 +0100
Message-ID: <dc6264c4-d551-4913-a51b-72c22217f15a@traphandler.com>
Date:   Sat, 4 Nov 2023 13:01:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: sysfs: cannot create duplicate filename
 .../system76_acpi::kbd_backlight/color
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux LEDs <linux-leds@vger.kernel.org>
CC:     Tim Crawford <tcrawford@system76.com>,
        Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        =?UTF-8?Q?Johannes_Pen=C3=9Fel?= <johannes.penssel@gmail.com>
References: <b5646db3-acff-45aa-baef-df3f660486fb@gmail.com>
 <ZT25-gUmLl8MPk93@debian.me>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <ZT25-gUmLl8MPk93@debian.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG1EX1.emp2.local (172.16.2.1) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 3654108149721479547
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddutddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttddvjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnheptdekfedttdejffekueeuffeiudetkeffuedttedvheffjeeuffeltdevleevveegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrihhlrdgtohhmpdhjohhhrghnnhgvshdrphgvnhhsshgvlhesghhmrghilhdrtghomhdplhgvvgeskhgvrhhnvghlrdhorhhgpdhrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhnuhigrdguvghvpdhjvghrvghmhiesshihshhtvghmjeeirdgtohhmpdhprhhoughutghtuggvvhesshihshhtvghmjeeirdgtohhmpd
 httghrrgiffhhorhgusehshihsthgvmhejiedrtghomhdpphgrvhgvlhesuhgtfidrtgiipdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdplhhinhhugidqlhgvughssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehfeeipdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/10/2023 02:48, Bagas Sanjaya wrote:
> On Thu, Oct 26, 2023 at 02:55:06PM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> Loading the system76-acpi kernel module fails on linux 6.6-rc7. This does not seem to be an issue with system76-acpi itself, because reverting commit #5d36931f0fe51665c04f56c027613d22e6a03411, which is the only change made to this driver across the 6.6 development cycle, does not fix the issue. On 6.5.8, everything works fine. My hardware is a Clevo-based Alder Lake laptop running coreboot, roughly similar to the System76 Darter Pro 8.
>>>
>>> backtrace:
>>> [  266.399036] sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/17761776:00/leds/system76_acpi::kbd_backlight/color'
>>> [  266.399045] CPU: 1 PID: 2896 Comm: modprobe Not tainted 6.6.0-rc7 #1
>>> [  266.399050] Hardware name: Notebook NS5x_NS7xPU/NS5x_NS7xPU, BIOS Dasharo (coreboot+UEFI) v1.6.0 03/30/2023
>>> [  266.399053] Call Trace:
>>> [  266.399057]  <TASK>
>>> [  266.399063]  dump_stack_lvl+0x36/0x50
>>> [  266.399080]  sysfs_warn_dup+0x5a/0x70
>>> [  266.399088]  sysfs_add_file_mode_ns+0x11a/0x130
>>> [  266.399094]  internal_create_group+0x125/0x3b0
>>> [  266.399101]  internal_create_groups+0x42/0xa0
>>> [  266.399107]  device_add+0x5b1/0x8a0
>>> [  266.399113]  ? kstrdup+0x4c/0x70
>>> [  266.399119]  device_create_groups_vargs+0xce/0xf0
>>> [  266.399124]  device_create_with_groups+0x4b/0x70
>>> [  266.399129]  led_classdev_register_ext+0x1d2/0x470 [led_class]
>>> [  266.399149]  ? devm_led_classdev_register_ext+0x3a/0x90 [led_class]
>>> [  266.399162]  devm_led_classdev_register_ext+0x50/0x90 [led_class]
>>> [  266.399173]  system76_add+0x18b/0x460 [system76_acpi]
>>> [  266.399186]  acpi_device_probe+0x47/0x130
>>> [  266.399193]  really_probe+0x19b/0x3e0
>>> [  266.399199]  ? __pfx___driver_attach+0x10/0x10
>>> [  266.399205]  __driver_probe_device+0x78/0x160
>>> [  266.399211]  driver_probe_device+0x1f/0x90
>>> [  266.399217]  __driver_attach+0xd2/0x1c0
>>> [  266.399222]  bus_for_each_dev+0x85/0xd0
>>> [  266.399227]  bus_add_driver+0x116/0x220
>>> [  266.399233]  driver_register+0x59/0x100
>>> [  266.399242]  ? __pfx_system76_driver_init+0x10/0x10 [system76_acpi]
>>> [  266.399252]  do_one_initcall+0x5a/0x300
>>> [  266.399260]  do_init_module+0x60/0x240
>>> [  266.399267]  init_module_from_file+0x86/0xc0
>>> [  266.399275]  __x64_sys_finit_module+0x18a/0x350
>>> [  266.399282]  do_syscall_64+0x5d/0x90
>>> [  266.399289]  ? syscall_exit_to_user_mode+0x26/0x40
>>> [  266.399295]  ? do_syscall_64+0x6c/0x90
>>> [  266.399300]  ? do_syscall_64+0x6c/0x90
>>> [  266.399305]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>>> [  266.399314] RIP: 0033:0x7f5c11b38d7d
>>> [  266.399360] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 7b d0 0b 00 f7 d8 64 89 01 48
>>> [  266.399364] RSP: 002b:00007ffe30e15b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>> [  266.399370] RAX: ffffffffffffffda RBX: 000055a8d48d6c10 RCX: 00007f5c11b38d7d
>>> [  266.399372] RDX: 0000000000000000 RSI: 000055a8d3077d8b RDI: 0000000000000003
>>> [  266.399375] RBP: 000055a8d3077d8b R08: 00007f5c11bf6b00 R09: 00007ffe30e15bd0
>>> [  266.399376] R10: 0000000000000050 R11: 0000000000000246 R12: 0000000000040000
>>> [  266.399378] R13: 000055a8d48d6c90 R14: 000055a8d48d6390 R15: 000055a8d48d7090
>>> [  266.399382]  </TASK>
>>> [  266.399410] System76 ACPI Driver: probe of 17761776:00 failed with error -17
>>
>> See Bugzilla for the full thread and attached dmesg output.
>>
>> Anyway, I'm adding this regression to regzbot:
>>
>> #regzbot introduced: v6.5..v6.6-rc7 https://bugzilla.kernel.org/show_bug.cgi?id=218045
>>
> 
> The reporter had narrowed down the culprit. He said on Bugzilla:
> 
>> The culprit seems to be commit c7d80059b086c4986cd994a1973ec7a5d75f8eea, which introduces a new 'color' attribute for led sysfs class devices. The problem is that the system76-acpi platform driver tries to create the exact same sysfs attribute itself for the system76_acpi::kbd_backlight device, leading to the conflict. For testing purposes, I've just rebuilt the kernel with the system76-apci color attribute renamed to kb_color, and that fixes the issue.
> 
> Jean-Jacques Hiblot, would you like to take a look on this regression,
> since you authored the culprit?
Hi,

The offending commit stores the color in struct led_classdev and exposes 
it via sysfs. It was part of a series that create a RGB leds from 
multiple single-color LEDs. for this series, we need the color 
information but we don't really need to expose it it via sysfs. In order 
to fix the issue, we can remove the 'color' attribute from the sysfs.

JJ

> 
> Anyway, telling regzbot:
> 
> #regzbot introduced: c7d80059b086c4
> 
> Thanks.
> 
