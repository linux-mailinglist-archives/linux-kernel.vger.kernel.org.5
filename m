Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7D7A1A78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjIOJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjIOJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:24:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAFC2D5F;
        Fri, 15 Sep 2023 02:24:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E05366072F9;
        Fri, 15 Sep 2023 10:24:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694769844;
        bh=mhYU2dTqP/Di35yOWqzCvi5rnNihke8nVgNOY3LOpdU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=ggH9xcwdfV/qtrkUdkW/3y6ZC05u7ljr5RP4vNL0yu8hViqfNTy7Uf39cXdk2j0MH
         6fuLSe671hDpmswDpUiGM6ANdCBWskvlj2nXVMLZGm+YiY3tqg3U2xZ4DB9cqgsQRQ
         Bg0FSX9hgbX5d9Uo0Eb+gKyYdpu2k4TdEkLFP35tWwtPLcWIDvtAWEhmSpeRrJONTy
         Rmt9cF+eF19+0xzkBmXeKpHDpCwm5ZHs2kJyYGt8RuaeurBwRBD1Bly5lh50D1/Vm/
         6n2Ld1u0Z9XGirJ3lEbguc3UL007MRXlw6bxfFP4wdNj512AOqpgHu3PRYunEe8O4G
         8fl+S1f6pgwhw==
Message-ID: <33c8f603-fc73-7067-ed3d-6bb973d9655c@collabora.com>
Date:   Fri, 15 Sep 2023 11:24:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230915075003.1552-1-chun-jen.tseng@mediatek.com>
 <20230915075003.1552-2-chun-jen.tseng@mediatek.com>
 <bf87aa29-ea42-f811-7ae9-3888336989fb@collabora.com>
In-Reply-To: <bf87aa29-ea42-f811-7ae9-3888336989fb@collabora.com>
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

Il 15/09/23 11:22, AngeloGioacchino Del Regno ha scritto:
> Il 15/09/23 09:50, Mark Tseng ha scritto:
>> Add mt8188 svs compatible in dt-bindings.
>>
>> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> 
> This commit does not apply. Please always develop and test on upstream.
> 

Actually, I'm sorry, it's *me* checking the wrong kernel tree here.
This commit is fine.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Sorry again,
Angelo

>> ---
>>   Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml 
>> b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>> index f21eb907ee90..7eda63d5682f 100644
>> --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>> @@ -22,6 +22,7 @@ properties:
>>     compatible:
>>       enum:
>>         - mediatek,mt8183-svs
>> +      - mediatek,mt8188-svs
>>         - mediatek,mt8192-svs
>>     reg:
> 
> 


