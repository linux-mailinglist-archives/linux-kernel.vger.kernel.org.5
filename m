Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC407C527E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjJKLwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjJKLwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:52:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897FBA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:52:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B3CC0660087A;
        Wed, 11 Oct 2023 12:51:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697025120;
        bh=eRu5lKk7+OejAbFhvWpEvS41OBC3vHDtq4IrLCQJyKA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RpCAi674MfIJ/5bGRDeE79dbFuPBeeUxmT4oDfHqEel39/euOrE1ZRjdzUB5Y9B2f
         SeFRFYlfWRIlHddKdbAZ8Z3eUhfLa4uSpsbKdIi2hkx8jgtL0zl32O5YX+83WhBYJ7
         Ub78kTw6dE9xnxayIj8jwLKQKGbHtpiPoexC7hiBip28S5bIPZ5y6Ot3nuOmp59Fzk
         uoT/wBmYL8dRDe01y8CIdaQRg3AwRBc1p6Z1e6/EMzKuG45L5PTxevIu5KCwDvxhu7
         7Li2mgcqMd3jLvpJ9ImBZ0LkdNu13x0pF3g7TCdy/edbULYDumF6PTbXfOZSuzF+ux
         UQ62WbM+l4kDg==
Message-ID: <ea747fbe-7311-dcec-20dc-2649bc5dd531@collabora.com>
Date:   Wed, 11 Oct 2023 13:51:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for MT8195
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "airlied@gmail.com" <airlied@gmail.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
 <20230918084207.23604-5-shawn.sung@mediatek.com>
 <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
 <30cc93a5-b3de-d23f-fd4d-e695551a71e3@collabora.com>
 <4f16a8ab0b2f5af0bf0d31ad26c83d7ab695c304.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4f16a8ab0b2f5af0bf0d31ad26c83d7ab695c304.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/10/23 11:38, Shawn Sung (宋孝謙) ha scritto:
> Hi, Angelo and CK,
> 
> On Mon, 2023-09-18 at 11:21 +0200, AngeloGioacchino Del Regno wrote:
>> Il 18/09/23 11:09, CK Hu (胡俊光) ha scritto:
>>> On Mon, 2023-09-18 at 16:42 +0800, Hsiao Chien Sung wrote:
>>>> Add OVL compatible name for MT8195.
>>>
>>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>>>
>>> but it's weird to put this patch into IGT series. Without this
>>> patch,
>>> mt8195 drm driver does not work not only IGT.
>>>
>>
>> The driver does work because the devicetree node declares two
>> compatibles,
>> "mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl" where the
>> second
>> compatible is matched in mtk_drm_drv, and the first is matched in
>> mtk_disp_ovl
>> as both are platform_driver.
>>
>> This commit is not necessary, even... :-)
>>
>> Regards,
>> Angelo
>>
>>> Regards,
>>> CK
>>>
>>>>
>>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>>> ---
>>>>    drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> index 93552d76b6e7..7759a06e5c0e 100644
>>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>>> @@ -715,6 +715,8 @@ static const struct of_device_id
>>>> mtk_ddp_comp_dt_ids[] = {
>>>>    	  .data = (void *)MTK_DISP_OVL },
>>>>    	{ .compatible = "mediatek,mt8192-disp-ovl",
>>>>    	  .data = (void *)MTK_DISP_OVL },
>>>> +	{ .compatible = "mediatek,mt8195-disp-ovl",
>>>> +	  .data = (void *)MTK_DISP_OVL },
>>>>    	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
>>>>    	  .data = (void *)MTK_DISP_OVL_2L },
>>>>    	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
>>
>>
> 
> Please refer to c6aa5f1fb505. This is the main reason why we have to
> use MT8195 instead of MT8183/MT8192. Most of the formats required by
> IGT is not supported.
> 
> Without this commit, DRM won't work after changing the compatible name
> of ovl0 to "mediatek,mt8195-disp-ovl" in the dts.
> 
> Thanks,
> Shawn

You don't have to change anything at all in the dts.

The current mt8195.dtsi declares:
compatible = "mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl";

..this is enough to get the mediatek,mt8195-disp-ovl match in mtk_disp_ovl.

Regards,
Angelo
