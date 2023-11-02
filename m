Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBBE7DECDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 07:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKBGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBGbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 02:31:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487F5130;
        Wed,  1 Nov 2023 23:31:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyREP-0000UV-Ez; Thu, 02 Nov 2023 07:31:05 +0100
Message-ID: <ba7aeb6b-19ee-4491-a60f-efc5216177a7@leemhuis.info>
Date:   Thu, 2 Nov 2023 07:31:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel
 issue
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        David Revoy <davidrevoy@protonmail.com>
Cc:     "jason.gerecke@wacom.com" <jason.gerecke@wacom.com>,
        "jose.exposito89@gmail.com" <jose.exposito89@gmail.com>,
        "ilya.ostapyshyn@gmail.com" <ilya.ostapyshyn@gmail.com>,
        Nils Fuhler <nils@nilsfuhler.de>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <kRKTNDYigUSblpNgSuZ2H4dX03Of1yD4j_L9GgbyKXcDqZ67yh5HOQfcd7_83U3jZuQzxpKT3L6FXcRkkZIGdl_-PQF14oIB0QmRSfvpc2k=@protonmail.com>
 <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <ZULw6AcBaD6z2UZA@debian.me>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZULw6AcBaD6z2UZA@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698906671;1ded49b1;
X-HE-SMSGID: 1qyREP-0000UV-Ez
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.11.23 01:44, Bagas Sanjaya wrote:
> On Wed, Nov 01, 2023 at 08:37:40PM +0100, Jiri Kosina wrote:
>> On Wed, 1 Nov 2023, David Revoy wrote:
>>
>>> Hi Jason Gerecke, José Expósito, Jiri Kosina and Illia Ostapyshyn,
>>>
>>> I am emailing to draw your attention and expertise to a problem I had 
>>> earlier this week with my Xp-Pen Artist 24 Pro display tablet under 
>>> Fedora Linux 38 KDE after a kernel update.
>>>
> […]

>>> Thank you very much if you can help me.
> […]
> Thanks for the report.
> 
> David, can you resend the regression report as plain text email (preferably
> with 276e14e6c3 people and regressions@lists.linux.dev Cc'ed)? You may need to
> see kernel documentation [1] for how to configure your email client to send
> plain text emails. Also, include in your report details from your blog post.

Bagas, I know you mean well, but I think you are making things
unnecessarily complicated for both David and the developers here. Sure,
the mail Jiri quoted did not make it to lore, but whatever, for him it
was apparently good enough; and I suspect this "quote forwarding to
others" is good enough for the people he brought into the loop as well.
Yes, there are developers that don't want to go to a website for
details, but if that's the case it's likely better to ask for details in
this thread instead of opening a second one. And regression tracking can
work without a separate mail as well.

Ciao, Thorsten
