Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4317A45C8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjIRJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjIRJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:21:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F2B5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:21:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B3D036607122;
        Mon, 18 Sep 2023 10:21:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695028908;
        bh=YTlzKMW/0OtSmibUGJ5lMjEhNq6syCtetx5FkGedM/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IUliO9kmejttZPTVRZez6rnPT7OS5T+Qf1DXTQM+X++CktDVCCcKuKKE7qKBPUuy6
         Rfdhj3t0dg+0JkTe4HQXUV0xRZzYWE4OGHv+7wU8mWVZ5vZffenwVhJGWVQuLog2Jp
         o7dJq3b70+HpD4zH0LtLUAsZHIGedZGjaRo/W7vEJmCefJUdFEYnvzvBK7ftK9RDxz
         rEAJjdkhy7ZiOqwQGdi/WvhFqdyNos035QxNEBjOe1+AKUF0qzIRgH606gwqsZ2rys
         uzVlD3OPthQ75PZx2Komo5izvdmK2MP6iahgc91VW4OAAUtiltmuisyW8PdB2f5pj2
         qX2FRu6yUB4+w==
Message-ID: <30cc93a5-b3de-d23f-fd4d-e695551a71e3@collabora.com>
Date:   Mon, 18 Sep 2023 11:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for MT8195
Content-Language: en-US
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
 <20230918084207.23604-5-shawn.sung@mediatek.com>
 <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/09/23 11:09, CK Hu (胡俊光) ha scritto:
> On Mon, 2023-09-18 at 16:42 +0800, Hsiao Chien Sung wrote:
>> Add OVL compatible name for MT8195.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> 
> but it's weird to put this patch into IGT series. Without this patch,
> mt8195 drm driver does not work not only IGT.
> 

The driver does work because the devicetree node declares two compatibles,
"mediatek,mt8195-disp-ovl", "mediatek,mt8183-disp-ovl" where the second
compatible is matched in mtk_drm_drv, and the first is matched in mtk_disp_ovl
as both are platform_driver.

This commit is not necessary, even... :-)

Regards,
Angelo

> Regards,
> CK
> 
>>
>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> index 93552d76b6e7..7759a06e5c0e 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>> @@ -715,6 +715,8 @@ static const struct of_device_id
>> mtk_ddp_comp_dt_ids[] = {
>>   	  .data = (void *)MTK_DISP_OVL },
>>   	{ .compatible = "mediatek,mt8192-disp-ovl",
>>   	  .data = (void *)MTK_DISP_OVL },
>> +	{ .compatible = "mediatek,mt8195-disp-ovl",
>> +	  .data = (void *)MTK_DISP_OVL },
>>   	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
>>   	  .data = (void *)MTK_DISP_OVL_2L },
>>   	{ .compatible = "mediatek,mt8192-disp-ovl-2l",


