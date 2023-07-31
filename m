Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543CA769355
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjGaKpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjGaKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:45:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186471A7;
        Mon, 31 Jul 2023 03:45:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B4106606EF9;
        Mon, 31 Jul 2023 11:45:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690800302;
        bh=/xy20Cx4V6EcMmCM8zDIAQr6l+aYKGfHtIlKmzg8S3o=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=kH/YeZhuGKaOtHqLEoRX/qQ2/e9rZ3Jpmfi9GcY3R2995jNbEbKVZNs/UqnReqGu2
         ZylGZdK8yb8QsXtB7Y9/rJjINZBL/056DWM1UZBL6KTZlWt23VcctporE2HHOURKSi
         EABlVob6ZwWjO92I4tZkaDXN5YJaBNTVCZgwU0x93VUzmRWLo0xI+nqPOcOz052+lh
         NPi0RsiUYDXKeSTpCE2ePfHEXRxuyjXP68dPEAzT2oKn2ZyUrkg+TFfhsTJdaQzSYv
         q53//+H1ZZ4GdwywQjETz+n9DH+zSqAFm3o7ZTfRMDyssICFVBePj7hTQq/5M4GvfD
         eOSJmovLnmX3w==
Message-ID: <fc142ae5-bc96-ca95-eb96-e54d6d9cdb22@collabora.com>
Date:   Mon, 31 Jul 2023 12:44:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: mediatek,mt7986-wm8960: add
 mt7986-wm8960 document
Content-Language: en-US
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-6-maso.huang@mediatek.com>
 <8e207baf-4a85-71f1-8ea3-08eab438b7cd@collabora.com>
 <ebfc016f57ec50ea8026efdce575813a75676b5c.camel@mediatek.com>
 <4aa7dd33239d568cfdf46f1e403bdeeef947726a.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <4aa7dd33239d568cfdf46f1e403bdeeef947726a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/07/23 08:42, Maso Huang (黃加竹) ha scritto:
> On Fri, 2023-07-28 at 18:16 +0800, Maso Huang wrote:
>> On Fri, 2023-07-28 at 11:55 +0200, AngeloGioacchino Del Regno wrote:
>>> Il 28/07/23 11:08, Maso Huang ha scritto:
>>>> Add document for mt7986 board with wm8960.
>>>>
>>>> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
>>>> ---
>>>>    .../sound/mediatek,mt7986-wm8960.yaml         | 53
>>>> +++++++++++++++++++
>>>>    1 file changed, 53 insertions(+)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/sound/mediatek,mt7986-
>>>> wm8960.yaml
>>>>
>>>> diff --git
>>>> a/Documentation/devicetree/bindings/sound/mediatek,mt7986-
>>>> wm8960.yaml
>>>> b/Documentation/devicetree/bindings/sound/mediatek,mt7986-
>>>> wm8960.yaml
>>>> new file mode 100644
>>>> index 000000000000..76394f7e5502
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt7986-
>>>> wm8960.yaml
>>>> @@ -0,0 +1,53 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id:
>>>>
> https://urldefense.com/v3/__http://devicetree.org/schemas/sound/mediatek,mt7986-wm8960.yaml*__;Iw!!CTRNKA9wMg0ARbw!lu4Z6pJeRiL7-8l4T3ptqUCM54FnHTBiyh5KWBNqSjl6mOOI7WmzHpWEd-ZSZ-2NJ4Cs9PPaAF_75ywo2SKW16MPPRaROt0$
>>>>   
>>>>   
>>>> +$schema:
>>>>
> https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!lu4Z6pJeRiL7-8l4T3ptqUCM54FnHTBiyh5KWBNqSjl6mOOI7WmzHpWEd-ZSZ-2NJ4Cs9PPaAF_75ywo2SKW16MPttZILAo$
>>>>   
>>>>   
>>>> +
>>>> +title: MediaTek MT7986 sound card with WM8960 codec
>>>> +
>>>> +maintainers:
>>>> +  - Maso Huang <maso.huang@mediatek.com>
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: mediatek,mt7986-wm8960-machine
>>>
>>> mediatek,mt7986-wm8960-sound looks better.
>>>
>>> After which,
>>>
>>> Reviewed-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>>
>>>
>>
>> Hi Angelo,
>>
>> Thanks for your review.
>> I'll change the compatible to "mediatek,mt7986-wm8960-sound" in v4
>> patch.
>>
>> Best regards,
>> Maso
>>
> 
> Hi Angelo,
> 
> One more question for this compatible.
> 
> The suffix "machine" means alsa machine driver for mt7986-wm8960. It
> might be better to use "machine" here.
> 
> Or you prefer "sound" than "machine"?
> 
> Best regards,
> Maso

I prefer "sound" because of consistency with other MediaTek machine driver
compatible strings.

Regards,
Angelo
