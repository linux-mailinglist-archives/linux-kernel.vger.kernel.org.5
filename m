Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518BB7CD5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbjJRIFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbjJRIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:05:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF2EA;
        Wed, 18 Oct 2023 01:05:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 514C166072ED;
        Wed, 18 Oct 2023 09:05:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697616331;
        bh=QqK3Qq/IcrlEdraizHHF1jjk88t7+0AEUmdS8lWGIZI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XIzOvmtHMIURYqPL5tUpTTLhyIa9K+Xx7sHyL4caNB0k2/OJnFin6Wch6XHwR2tma
         FdOiext+yURbhb9o97fSZu5Z9EeCejI+4vtA6WUK87rVspiR3YGzcBRX5PKO/BphnC
         uRHM6zf9HP7BOQJbSqtLVmtNMg5NpnQ6mwZAk38yYp2Q07jqerZkOIFIryWJz/YPD8
         5cv2dM1rscIVuL1mxtrByKNXnMCsrsf8Oro4vtgJbn0ejOG8Rr+2DLKsxL7mC8TIT8
         WXE85G/2G5/erFrqpZQjIpPzHaw2QYPvSbu7DRiF3LyRCy8ujKsOLl6BAl0o1aIo+W
         saADAWGoMGlWw==
Message-ID: <44f7f491-b8f5-4ed9-b756-db485a178694@collabora.com>
Date:   Wed, 18 Oct 2023 10:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/23] drm/mediatek: Add Padding to OVL adaptor
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231018043650.22532-1-shawn.sung@mediatek.com>
 <20231018043650.22532-19-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231018043650.22532-19-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/10/23 06:36, Hsiao Chien Sung ha scritto:
> Add MT8188 Padding to OVL adaptor to probe the driver.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


