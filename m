Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120FE7F43C0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjKVK0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjKVIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:55:47 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7D12A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:55:43 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r5j1E-0004hl-4x; Wed, 22 Nov 2023 09:55:36 +0100
Message-ID: <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
Date:   Wed, 22 Nov 2023 09:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US, de-DE
To:     syed saba kareem <ssabakar@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marian Postevca <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700643343;f7ed1ba3;
X-HE-SMSGID: 1r5j1E-0004hl-4x
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.11.23 14:30, syed saba kareem wrote:
> On 11/3/23 04:41, Bagas Sanjaya wrote:
>> On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
> [...]
>>> Some help here would be welcome. Is there something missing in my
>>> machine driver code, or
>>> is the runtime pm handling in acp pci driver wrong?
>>
> We were working on some other priority tasks, will upstream the changes
> 
> by next week.

Hi syed saba kareem! Did that happen? From here it looks like it did
not, so I assume the regression was not yet addressed. But it's easy to
miss something, hence this mail.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
