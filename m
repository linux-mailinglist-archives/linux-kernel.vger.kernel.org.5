Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39787A1A73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjIOJXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjIOJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:23:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168D12D46;
        Fri, 15 Sep 2023 02:22:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C2A8066072F9;
        Fri, 15 Sep 2023 10:22:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694769746;
        bh=fzWaPZEsAH1sXxqOkzkVtQ4njuoVic2dFspzQhvmEhQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hLKOt4CQSs1fT5XRZVgDtipG8WoOmZASj/JOMREm3A29RtJ9QGt0Z3jPdU05Y2DdE
         aG+x2vOsMsD48u2FVmgr5jcD2tpjZKXKzekCQTY01kFRr8LDL5xCcASGcaLGxnN/8v
         cxOzBNZHO32+VfRniTSz6FZumw6pWdCOlkqsa8MRG/03MP/lFx6ten0E8QgULgQT72
         N2hiCs18TNhtWQ2fXCiQVfQIyXdraOMzxqeXmOXa5obPEtqiks4vWHR7leejQyV3/A
         Il262QCiRBVDL2ZVbBe0qxn53LeZcZyb0/LZBua7CZ/IMiXG025Up3V2rN6SAPnOkM
         fzqHsE/0J+nCA==
Message-ID: <bf87aa29-ea42-f811-7ae9-3888336989fb@collabora.com>
Date:   Fri, 15 Sep 2023 11:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: mediatek: add mt8188 svs
 dt-bindings
Content-Language: en-US
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230915075003.1552-2-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/23 09:50, Mark Tseng ha scritto:
> Add mt8188 svs compatible in dt-bindings.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>

This commit does not apply. Please always develop and test on upstream.

> ---
>   Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> index f21eb907ee90..7eda63d5682f 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> @@ -22,6 +22,7 @@ properties:
>     compatible:
>       enum:
>         - mediatek,mt8183-svs
> +      - mediatek,mt8188-svs
>         - mediatek,mt8192-svs
>   
>     reg:


