Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1697D0DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376945AbjJTK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376699AbjJTK4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:56:02 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06679E8;
        Fri, 20 Oct 2023 03:56:00 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qtnAc-0001wr-FQ; Fri, 20 Oct 2023 12:55:58 +0200
Message-ID: <37c2c8ee-d909-413d-9cf7-e67efd7fdb30@leemhuis.info>
Date:   Fri, 20 Oct 2023 12:55:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: High cpu usage caused by kernel process when upgraded to
 linux 5.19.17 or later
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Developers <coreteam@netfilter.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
References: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <01ac399d-f793-49d4-844b-72cd8e0034df@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1697799360;0c50cbf2;
X-HE-SMSGID: 1qtnAc-0001wr-FQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 23.06.23 02:58, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> kernel process "kworker/events_power_efficient" uses a lot of cpu power (100% on ESXI 6.7, ~30% on ESXI 7.0U3 or later) after upgrading from 5.17.3 to 5.19.17 or later.
> [...]
> #regzbot introduced: v5.17.3..v5.19.17 https://bugzilla.kernel.org/show_bug.cgi?id=217586
> #regzbot title: kworker/events_power_efficient utilizes full CPU power after kernel upgrade
> 
> Thanks.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217586

#regzbot resolve: afaics: misconfiguration became more problematic due
to new mitigations
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

