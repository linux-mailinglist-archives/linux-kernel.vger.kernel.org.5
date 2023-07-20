Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA8F75AB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGTJjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjGTJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:38:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785225FE6;
        Thu, 20 Jul 2023 02:33:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC8B66606F59;
        Thu, 20 Jul 2023 10:28:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689845316;
        bh=ywsg8mrGt5vzRhTvN5yTIHTNMJFTTFdl86eljvEVajU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YW1LezwA0F9SSjfm43jsppvXMLPUsKwCGRFL5gwTu17A2teRS71cYvaETDvcGBgzJ
         EpDy4vBoeHxAKGuUC+OX5qsJxm04WxqSKbfq0fxjuCgtnfLvqBS8eCMMfb0cvkLFxA
         ARkpIjhb+IVlH2RpA9hw+tJiEUxKo0nq7fKtST4SywJrWvoxHs49b21dsFQbuayhmc
         19KVdDVE8R9+yIyopLf0x2gjG6CGo6KiGXMfbHFVjU4zqmx7qZ3quXK0okfnJ8JAQY
         4DdyXReetozLkRSH8BDrtwucnAOywRzUB64qAODKb4v33FlcnFxTSmknklgnuLx2iy
         30xrHWAngX7ZQ==
Message-ID: <f34c542f-e9ad-17ae-f3c8-9495fb534587@collabora.com>
Date:   Thu, 20 Jul 2023 11:28:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3,3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
 <20230720082604.18618-4-shuijing.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230720082604.18618-4-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 10:26, Shuijing Li ha scritto:
> Due to the difference of HW, different dividers need to be set.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


