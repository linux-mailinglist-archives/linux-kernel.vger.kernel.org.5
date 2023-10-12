Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7007C6E38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377702AbjJLMfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347164AbjJLMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:35:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE970C0;
        Thu, 12 Oct 2023 05:35:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5776660733F;
        Thu, 12 Oct 2023 13:35:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697114133;
        bh=9YwrfxspUnb7imS3HOKEtNqbSdskF65SOc98nxt5Q60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DD0jWufzf2Jb+8PBpFQg3JL3LMJXE/jZPx+1hghxyJ/1FWsByQccKV50tHxcZtolj
         2U+eaP0yAJDigMDweHV/VLIQi/304DfbEn99rDuYWwsYtWhNLKBPfCOjlsLlfDXg3j
         rMVnDRUH/1u8RraORenVNeWvKBZatHTIp20A9YupE/tmyCUpJn3EY4ZWHN7Ue9rXyj
         4koTJWKPEKpmBDVYd6j33LB8bFYwtTPpdBGes0SbfhSX3Gq+KpSZOrP+m1QS6BrZ87
         UIy8fJb11mjYb1iBuZUrcEyrWb/z7HBcBcPc9HiFrl7wWz+rFAg0eOZwAUPg8Fztc5
         DKBVX71CZZWTQ==
Message-ID: <49a4be76-e389-c6aa-6176-41b351c6446a@collabora.com>
Date:   Thu, 12 Oct 2023 14:35:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v7 16/16] dt-bindings: display: mediatek: padding: add
 compatible for MT8195
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231012084037.19376-1-moudy.ho@mediatek.com>
 <20231012084037.19376-17-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231012084037.19376-17-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/23 10:40, Moudy Ho ha scritto:
> Add a compatible string for the PAD block in MediaTek MT8195 that
> is controlled by MDP3.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   .../bindings/display/mediatek/mediatek,padding.yaml           | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> index db24801ebc48..636b69133acc 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,padding.yaml
> @@ -20,7 +20,9 @@ description:
>   
>   properties:
>     compatible:
> -    const: mediatek,mt8188-padding
> +    enum:
> +      - mediatek,mt8188-padding
> +      - mediatek,mt8195-mdp3-pad

mediatek,mt8195-mdp3-padding please!

Thanks,
Angelo

>   
>     reg:
>       maxItems: 1


