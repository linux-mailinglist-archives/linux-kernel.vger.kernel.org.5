Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181A07DE0B4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjKAMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjKAMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:15:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D69DC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 05:15:49 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyA8R-0003Rl-V8; Wed, 01 Nov 2023 13:15:48 +0100
Message-ID: <fef5e8f0-12e3-4755-92db-dcf16a7db9aa@leemhuis.info>
Date:   Wed, 1 Nov 2023 13:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: X86 parallel bring up regression
Content-Language: en-US, de-DE
To:     Linux kernel regressions list <regressions@lists.linux.dev>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <3d96c70e-da3b-49c2-a776-930a9f1b815d@amd.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <3d96c70e-da3b-49c2-a776-930a9f1b815d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698840949;54ae380b;
X-HE-SMSGID: 1qyA8R-0003Rl-V8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 19.10.23 22:26, Mario Limonciello wrote:
> 
> We've recently found that there was a regression from 6.5 that broke
> resume from suspend-to-ram on some AMD platforms.

#regzbot monitor
https://lore.kernel.org/all/20231023160018.164054-1-mario.limonciello@amd.com/
#regzbot monitor
https://lore.kernel.org/all/20231026170330.4657-1-mario.limonciello@amd.com/
#regzbot ignore-activity
#regzbot resolve: turned out to be a BIOS bug

For details see https://lore.kernel.org/all/878r7imlb0.ffs@tglx/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
