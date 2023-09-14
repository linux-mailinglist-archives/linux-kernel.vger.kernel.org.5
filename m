Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3BC7A0132
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237964AbjINKFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjINKF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:05:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8732D1BE3;
        Thu, 14 Sep 2023 03:05:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AAF1466072FF;
        Thu, 14 Sep 2023 11:05:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694685923;
        bh=b9dNXd4DNo/EkCMgek1U0ux67al2IZqZJ/o5s4IfKu4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BYSojtiQaZbENP/vhxCjm5/kWFmmzr8lP1XygN7e1gdIbP6cHG60aOmQAoL5LaaKn
         GgBqfnPhYBL1mKaSPMH7E9jLPKSJ4u2AHHaTWzb213sPLlHqXcnbny4J41XjpRNS3Q
         3rlDa8CGgSQH0+SNj9LkC13R7M1Jnz0PAJEL6BdfCxdlDlYo+/rwIAH0fCDOd1jbek
         vm9JW0WHNkqjos50O1JSj/yvG9/iQ0ggka+CshJSdh1r7OKQO0qz79M6KsVV6lYTPG
         gwOQTyMdrrsIocBiFq2jBj6rmkHvzyL4v3Wv9K5uLx/qGX9xPFxlyTPONhudu1ajt/
         c23H3voGAJj6g==
Message-ID: <01cdd49e-2f11-d5bd-073c-916f7f36f2db@collabora.com>
Date:   Thu, 14 Sep 2023 12:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] dt-bindings: arm64: mediatek: add mt8390-evk board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230914061833.32288-1-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230914061833.32288-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/23 08:18, Macpaul Lin ha scritto:
> 1. Add compatible for MT8390.
> 2. Add bindings for the MediaTek mt8390-evk board, also known
> as the "Genio 700-EVK".
> 
> The MT8390 and MT8188 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
> 
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


