Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A3B7F4D7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbjKVQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKVQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:55:27 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C7D43;
        Wed, 22 Nov 2023 08:55:23 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5qVV-0005Lt-CB; Wed, 22 Nov 2023 17:55:21 +0100
Message-ID: <bbeb662d-78d0-4157-b062-b061eab66088@leemhuis.info>
Date:   Wed, 22 Nov 2023 17:55:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: [Regression] S3 Sleep Mode failures since Linux 6.x on Dell
 Inspiron 15 5593
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Arnas <arnasz616@gmail.com>
References: <585dcc9e-7e72-473a-98ec-4f06018d542f@gmail.com>
 <ZV4AP1GY3fHAxmtx@archie.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZV4AP1GY3fHAxmtx@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700672123;f00569b5;
X-HE-SMSGID: 1r5qVV-0005Lt-CB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.11.23 14:21, Bagas Sanjaya wrote:
> On Tue, Sep 26, 2023 at 07:25:48AM +0700, Bagas Sanjaya wrote:
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>> I'm having some weird issues with sleep mode on any 6.x Linux kernel version - it's a toss-up when I close the lid as to whether it will sleep properly or not - when it fails, the screen will lock, but it will not actually enter S3 sleep - it just blanks the screen, but the laptop stays on (and fan does too).
> [...]
>> #regzbot introduced: v5.15..v6.1 https://bugzilla.kernel.org/show_bug.cgi?id=217950
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217950
> 
> Hi Thorsten and all,

Bagas, please ask me things like this in private. Developers get enough
mail already, we should try our best to not increase the amount too much
with stuff that is just there for regression tracking stuff.

> It seems like the BZ reporter is really busy with his college life; IOW
> he can only bisect in the winter break [1]. Should I mark this regression
> as inconclusive for now?

Let's put it on regzbot's back-burner.

#regzbot backburner: will take a while until this is bisected
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
