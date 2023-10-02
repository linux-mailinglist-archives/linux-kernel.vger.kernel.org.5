Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD57B5013
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjJBKUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbjJBKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:20:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA601B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:20:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA257660576C;
        Mon,  2 Oct 2023 11:20:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696242020;
        bh=JdnSSJ//lHHfQq7wEqGDpkl5trSnE/FLPBWBzxKVa6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fpswa4iCgXO5deugZXfP50E+0ha82k45UL9FXE2WNj3NARN6fDZvxs7VcudIZMpxS
         QQHvk+aMFNDySzykJl4jPZUqZC8IQ9DnJucaEu/3BjJPeS7j7Nh370xYRVqGiMnHzA
         FVVmPcLrmvcfiGDmuqpQe9amTj7HZIcdq6nyZJOgoVLHVi034oeUjc34vTG4cpMZ+e
         OMyj+U/e+1DRE7sJkrvkjfj2K5bFakkhoN1pZbusKHABAuvY/Cl/XE1i9D70ksjkbx
         pZlkF1BWbV3ukK7q7owhM+QgMiDX646MsiEVW2vBhsPQym6hj8yv3NsbqIqy0NCZmC
         2ms5RBROOjR4g==
Message-ID: <77bfcbca-e7fe-49e1-952a-c99596160c0f@collabora.com>
Date:   Mon, 2 Oct 2023 12:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     nfraprado@collabora.com, wenst@chromium.org, robh@kernel.org,
        amergnat@baylibre.com, arnd@arndb.de
References: <20230929082009.71843-1-angelogioacchino.delregno@collabora.com>
 <d26ee3f8-d5d3-e46d-4d79-098992d13790@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d26ee3f8-d5d3-e46d-4d79-098992d13790@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/10/23 11:41, Matthias Brugger ha scritto:
> 
> 
> On 29/09/2023 10:20, AngeloGioacchino Del Regno wrote:
>> I am a top reviewer mainly for MediaTek SoC related patches in most
>> subsystems and I've also been upstreaming both improvements, fixes
>> and new drivers and devicetrees when required.
>>
>> The MediaTek scene saw a generous increase in number of patches that
>> are sent to the lists every week, increasing the amount of required
>> efforts to maintain the MTK bits overall, and we will possibly see
>> even more of that.
>>
>> For this reason, and also because of suggestions and encouragement
>> coming from the community, I'm stepping up to be a co-maintainer of
>> MediaTek SoCs support.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Thanks Angelo to volunteer on this. It actually was on my list for the last days to 
> ask you to help me out as I'm not able at the moment to cope with the review 
> process. That's unfortunate and we missed one merge window (August) where I took no 
> patches but after holiday situation didn't get better. I don't want to be break in 
> the MediaTek upstream development, so it's great to see you stepping up.
> 
> As I read in the thread, I agree the best will be to have a share tree at 
> kernel.org. It seems I can't share my tree with you, so hopefully you will get 
> access fast.
> 
> My idea is to not disappear and create a collaborative process for us on the 
> maintainership in the future.
> 

I am really happy first of all see that you're fine, and then to see that you
are happy with me going for this.

I will be even happier to create a collaborative process for our maintainership
of MediaTek, as I was really hoping for that to happen.

>> ---
>>
>> P.S.: I tried to reach to Matthias for almost two months, but I couldn't
>> find any way to talk to him and he has been unresponsive on the mailing
>> lists as well.
> 
> I think you didn't tried matthias.bgg@kernel.org, but that should be no excuse from 
> my side for being unresponsive. Thanks for your help!
> 
> Please contact me on IRC for any coordination.

Coming to IRC for a nice chat ASAP!
Thank *you* for this email, and preventively thanks for *your* help!

Cheers,
Angelo

> 
> Regards,
> Matthias
> 
> 
>>
>> P.P.S.: This also comes after Rob Herring's suggestion to have myself as
>> a MediaTek SoC co-maintainer [1] and support from other people.
>>
>> [1]: https://lore.kernel.org/all/20230804225813.12493-1-robh@kernel.org/
>>
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 208cfcc1aee3..211a8322c801 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2330,7 +2330,7 @@ F:    drivers/rtc/rtc-mt7622.c
>>   ARM/Mediatek SoC support
>>   M:    Matthias Brugger <matthias.bgg@gmail.com>
>> -R:    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +M:    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>   L:    linux-kernel@vger.kernel.org
>>   L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>   L:    linux-mediatek@lists.infradead.org (moderated for non-subscribers)

