Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468397AE4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjIZEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjIZEjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:39:14 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B545297
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:39:07 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qkzqh-0003tX-Bj; Tue, 26 Sep 2023 06:39:03 +0200
Message-ID: <72d3eae0-efdc-41ad-bed9-008df36f320e@leemhuis.info>
Date:   Tue, 26 Sep 2023 06:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: AMD Geode LX hardware RNG driver produces regular patterns
 (geode-rng.c)
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Andres Salomon <dilinger@queued.net>,
        "Timur I. Davletshin" <timur.davletshin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMD GEODE <linux-geode@lists.infradead.org>
References: <9a28c2fc-d769-4802-a1f2-77ba2cb34d25@gmail.com>
 <ZP2ERFydER7pJprL@debian.me> <ZRIplFgg0ZnzGzre@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZRIplFgg0ZnzGzre@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695703147;2b1511b6;
X-HE-SMSGID: 1qkzqh-0003tX-Bj
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

On 26.09.23 02:45, Bagas Sanjaya wrote:
> On Sun, Sep 10, 2023 at 03:54:28PM +0700, Bagas Sanjaya wrote:
>> On Thu, Sep 07, 2023 at 06:37:00PM +0700, Bagas Sanjaya wrote:
>>> #regzbot ^introduced: v4.14.267..v5.15.127
>>> #regzbot title: predictable urandom output on Alix 2d13
>>>
>>
>> #regzbot fix: https://lore.kernel.org/lkml/20230910083418.8990-1-jonas.gorski@gmail.com/
>>
> 
> Fix up:
> 
> #regzbot fix: hwrng: geode: fix accessing registers

Fix afaics was slightly renamed on merge, hence:

#regzbot fix: hwrng: geode - fix accessing registers
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
