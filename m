Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA437E8AC1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 12:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjKKLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 06:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjKKLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 06:52:08 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9C3AA7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 03:52:05 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r1mWt-0004G2-2z; Sat, 11 Nov 2023 12:51:59 +0100
Message-ID: <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
Date:   Sat, 11 Nov 2023 12:51:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To:     paul.gortmaker@windriver.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        richard.purdie@linuxfoundation.org, tglx@linutronix.de,
        x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZUEgAAGDVqXz2Seo@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1699703525;14f7497e;
X-HE-SMSGID: 1r1mWt-0004G2-2z
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

> [Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 20:30) Thomas Gleixner wrote:
> 
>> On Mon, Oct 30 2023 at 19:24, Thomas Gleixner wrote:
> 
>> > Can you add "debug-alternative" to the kernel command line and log both
>> > a working and the non-working kernel output. It's noisy :)
>> >
>> > Also do you have a .config and the qemu command line handy?
>> 
>> Forgot to ask: Does the probkem persist with 6.6 ?
> 
> My bad, should have mentioned v6.6 and linux-next is impacted. Always a
> conflict between burying the lead and boring people with details.

Paul, was this regression ever solved? I wonder as I could not find
anything with a "Fixes: 6c480f222128 [...]" tag on lore and this thread
looks stalled.

Ciao, Thorsten
