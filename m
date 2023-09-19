Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D302C7A6142
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjISLch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:32:34 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9A894;
        Tue, 19 Sep 2023 04:32:27 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qiYxq-0007SV-K9; Tue, 19 Sep 2023 13:32:22 +0200
Message-ID: <9c791f68-bbfe-4722-9cbb-5e791ce042ec@leemhuis.info>
Date:   Tue, 19 Sep 2023 13:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Marvell RAID Controller issues since 6.5.x
Content-Language: en-US, de-DE
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
 <ZQf9mh3v5qfN5Tm0@x1-carbon> <ZQgCoJ17UioOtdOJ@debian.me>
 <ZQlFg4GsULu633P1@debian.me>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZQlFg4GsULu633P1@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695123147;844ed6a3;
X-HE-SMSGID: 1qiYxq-0007SV-K9
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

On 19.09.23 08:53, Bagas Sanjaya wrote:
> On Mon, Sep 18, 2023 at 02:56:16PM +0700, Bagas Sanjaya wrote:
>> On Mon, Sep 18, 2023 at 07:34:50AM +0000, Niklas Cassel wrote:
>>> On Mon, Sep 18, 2023 at 07:18:28AM +0700, Bagas Sanjaya wrote:
>>>
>>> This is a duplicate of:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217902
>>>
>>> Problem is solved by:
>>> https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
>>
>> I have asked the reporter on Bugzilla to check the fix above. When he
>> reports back successfully, I'll mark this report as fixed.
>>
> 
> Another user has confirmed the fix (see Bugzilla), so:
> 
> #regzbot fix: https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/

Bagas, FWIW, using "#regzbot fix" is not supported (maybe it should, but
I have other priorities currently), hence let me fix this up:

#regzbot fix: scsi: Do no try to probe for CDL on old drives
#regzbot monitor:
https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.org/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
