Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1105800570
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377803AbjLAIY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:24:54 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE5170C;
        Fri,  1 Dec 2023 00:25:00 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r8ypT-0006bQ-TX; Fri, 01 Dec 2023 09:24:56 +0100
Message-ID: <898f9837-e446-4c2c-affc-333df2486706@leemhuis.info>
Date:   Fri, 1 Dec 2023 09:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Jiri Kosina <jkosina@suse.cz>,
        David Revoy <davidrevoy@protonmail.com>
Cc:     "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "ilya.ostapyshyn@gmail.com" <ilya.ostapyshyn@gmail.com>,
        Nils Fuhler <nils@nilsfuhler.de>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
          Linux regressions mailing list 
          <regressions@lists.linux.dev>
References: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
 <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <877c9bed-181a-4fc0-a876-e17de65c9e4d@leemhuis.info>
In-Reply-To: <877c9bed-181a-4fc0-a876-e17de65c9e4d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701419100;cec74333;
X-HE-SMSGID: 1r8ypT-0006bQ-TX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 02.11.23 08:44, Linux regression tracking #adding (Thorsten Leemhuis)
wrote:
> On 01.11.23 20:37, Jiri Kosina wrote:
>> On Wed, 1 Nov 2023, David Revoy wrote:
>>
>>> I am emailing to draw your attention and expertise to a problem I had 
>>> earlier this week with my Xp-Pen Artist 24 Pro display tablet under 
>>> Fedora Linux 38 KDE after a kernel update.
>>>
>>> The second button on my stylus changed from a right-click (which I could 
>>> customise with xsetwacom or any GUI like kcm-tablet) to a button that 
>>> feels 'hardcoded' and now switches the whole device to an eraser mode. 
>>> This makes my main tool unusable.
> [...]
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced 276e14e6c3
> https://www.davidrevoy.com/article995/how-a-kernel-update-broke-my-stylus-need-help

This thread got long, but from briefly skimming it, it seems like the
regressions was dealt with somehow and everybody is happy. Please holler
if I got it wrong, as I hereby remove this from the tracking:

#regzbot resolve: solution found
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.


