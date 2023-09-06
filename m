Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9D793A51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbjIFKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbjIFKtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:49:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15E219BB;
        Wed,  6 Sep 2023 03:48:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9FB36606E9D;
        Wed,  6 Sep 2023 11:48:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693997301;
        bh=XFN7RJKmAs02Y3lJUL7X2wA7a13+qByhBe9Ak6fyjsI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KZvU5xvkVY+Am3g3z7blH+k9wJ9UKugJpI3wVqMYvkVx56dkY9NsMSVY8MVEJd9YC
         ubXtlbPMfkP3EpUMjNf6NFipY00Ug5zs3t2F05zfeQDVtjb2b73vUOFTU4M/go2+nd
         mSo0xxilNexrFbjVfsdw9JAT3dXIzW2fm4uOLkpLWXMbejPQJNYUiEm6tet6M+75AQ
         CHxv82KC+rdJg/TKuT22guqvJD1ODBr1ry8ntuCTSF2hHvZ8QBB4X3XdcUvHD57w6w
         lrrcrqmXt3Ds8tfvDJgjklNeKBZCFRFknYkHRbe0PY0Fwv6kIIgMS3THCMxSVx2SqV
         oWc1aXH9Vu+tg==
Message-ID: <f343b6e2-6106-47eb-71cb-f391aff6cb7f@collabora.com>
Date:   Wed, 6 Sep 2023 12:48:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
 <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
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

Il 06/09/23 11:53, Macpaul Lin ha scritto:
> 
> 
> On 9/6/23 17:32, Krzysztof Kozlowski wrote:
>>
>>
>> External email : Please do not click links or open attachments until you have 
>> verified the sender or the content.
>>
>> On 06/09/2023 11:25, Macpaul Lin wrote:
>>> 1. Add compatible for MT8395.
>>> 2. Add bindings for the MediaTek mt8395-evk board, also known
>>> as the "Genio 1200-EVK".
>>>
>>> The MT8195 and MT8395 belong to the same SoC family,
>>> with only minor differences in their physical characteristics.
>>> They utilize unique efuse values for differentiation.
>>>
>>> The booting process and configurations are managed by boot
>>> loaders, firmware, and TF-A. Consequently, the part numbers
>>> and procurement channels vary.
>>>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>
>> Do not attach (thread) your patchsets to some other threads (unrelated
>> or older versions). This buries them deep in the mailbox and might
>> interfere with applying entire sets.
>>
>>>
>>> Changes for v2:
>>>  - add more detail description for mt8395.
>>>  - add bindings for mt8395, and mt8395-evk.
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml 
>>> b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> index ae12b1cab9fb..d7a20df640d7 100644
>>> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
>>> @@ -248,6 +248,11 @@ properties:
>>>            - enum:
>>>                - mediatek,mt8365-evk
>>>            - const: mediatek,mt8365
>>> +      - description: MediaTek Genio 1200 Boards (Genio 1200 EVK)
>>> +        items:
>>> +          - enum:
>>> +              - mediatek,mt8395-evk
>>> +          - const: mediatek,mt8395
>>
>>
>> I don't understand. You said last time this is fully compatible with
>> mt8195, so why it's not here?
>>
> 
> Yes, mt8395 is fully compatible with mt8195.
> 
> But after reading Angelo's comment, we thought it is necessary to create a new 
> compatible to avoid confusion for users.
> https://lore.kernel.org/lkml/bf8394c6-5460-8696-f46b-0c39927aaf84@collabora.com/
> 
> Although they are fully compatible, developers cannot arbitrarily replace the chip 
> on the board with another one. So separated bindings might be better.

Sorry you've misunderstood; I was trying to explain to Krzysztof that the two
SoCs are fully compatible... my suggestion was in like with what you're trying to
do as in I am agreeing with your first version, Macpaul, to inherit MT8195.

So,

- enum
     - mediatek,mt8395-evk
- const: mediatek,mt8195
- const: mediatek,mt8395

> 
>> Best regards,
>> Krzysztof
> 
> Thanks
> Macpaul Lin



