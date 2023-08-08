Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1F77744F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjHHSdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjHHSdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:33:13 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EF1193C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:54:59 -0700 (PDT)
Received: from [185.238.219.14] (helo=[192.168.44.45]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qTQv0-0004FA-Vs; Tue, 08 Aug 2023 19:54:55 +0200
Message-ID: <47437162-e1bd-58c1-9f34-ca4b661c3e34@leemhuis.info>
Date:   Tue, 8 Aug 2023 19:54:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression fix not progressing towards mainline/stable
Content-Language: en-US, de-DE
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     sound-open-firmware@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Alsa-devel <alsa-devel@alsa-project.org>
References: <661fcece-a83c-cb24-1b37-5d8693b1fb94@leemhuis.info>
 <98188012-8e07-4bb1-be1c-04d6c0f5260a@linux.intel.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <98188012-8e07-4bb1-be1c-04d6c0f5260a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691517299;48c2aee2;
X-HE-SMSGID: 1qTQv0-0004FA-Vs
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.23 13:03, Péter Ujfalusi wrote:
> On 08/08/2023 09:10, Thorsten Leemhuis wrote:
>>
>> I'm talking about about the fix "ASoC: SOF: intel: hda: Clean up link
>> DMA for IPC3 during stop" for this ticket:
>> https://github.com/thesofproject/linux/issues/4455
>>
>> Two more tickets about it:
>> https://github.com/thesofproject/linux/issues/4482
>> https://bugzilla.kernel.org/show_bug.cgi?id=217673
>>
>> It seems the fix is ready and reviewed for two weeks now,  [...]
>
> We take regressions (and user reports) seriously and trying our best to
> provide fixes asap.
> We do prioritize bug fixes over features but in this case for some
> reason the review process took longer than it usually does and the patch
> has not been sent upstream. [...]

Happens, thx for taking care of it!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
