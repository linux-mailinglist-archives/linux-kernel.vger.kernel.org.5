Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7017DE3DA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjKAPFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjKAPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:05:16 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886F182;
        Wed,  1 Nov 2023 08:05:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qyCmF-0001LJ-J3; Wed, 01 Nov 2023 16:05:03 +0100
Message-ID: <74466a74-0c42-40ce-8176-ba7ba56cb6d6@leemhuis.info>
Date:   Wed, 1 Nov 2023 16:05:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Nouveau] Fwd: System (Xeon Nvidia) hangs at boot terminal after
 kernel 6.4.7
Content-Language: en-US, de-DE
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Nouveau <nouveau@lists.freedesktop.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>
References: <4b0c06ba-b05c-071c-d494-67775bd7250f@gmail.com>
 <94a31824-016a-7fe3-7477-e3ab500844c1@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <94a31824-016a-7fe3-7477-e3ab500844c1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1698851106;56e0a1e2;
X-HE-SMSGID: 1qyCmF-0001LJ-J3
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

On 10.08.23 06:19, Thorsten Leemhuis wrote:
> On 10.08.23 05:03, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>> [...]
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217776

#regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/255
#regzbot fix: 6eb4a83e612af65bab8492957cba
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

