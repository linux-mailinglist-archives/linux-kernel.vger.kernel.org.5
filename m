Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526FF7B31BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjI2Lta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Lt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:49:29 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A1B4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:49:27 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmBzq-0005kV-8i; Fri, 29 Sep 2023 13:49:26 +0200
Message-ID: <9d6bb342-0a09-4ec5-99d7-81e095ff5cee@leemhuis.info>
Date:   Fri, 29 Sep 2023 13:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US, de-DE
To:     linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Linux Regressions <regressions@lists.linux.dev>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN2NUIg3k5VgMg63@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZN2NUIg3k5VgMg63@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695988167;b3b825bf;
X-HE-SMSGID: 1qmBzq-0005kV-8i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.23 05:00, Bagas Sanjaya wrote:
> On Wed, Aug 16, 2023 at 04:39:34PM -0400, Genes Lists wrote:

> Thanks for the regression report. I'm adding it to regzbot:
> 
> #regzbot ^introduced: 101bd907b4244a
> #regzbot title: can't change Samsung SSD power state due to ASPM mode checking
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=217802

Fix is in Gregs tree and hopefully soon in mainline:

#regzbot fix: 0e4cac557531a4
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



