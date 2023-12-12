Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2015F80ED88
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbjLLN10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjLLN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:27:21 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A22911D;
        Tue, 12 Dec 2023 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702387644;
        bh=EiuZhr5Xmzs0FwCEPG+Ew4eAAMJCP2ZsrkEzvE1VxkA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d+QQcCfZGvmR6TTIxeqCgLgChC9poL3EWtIVAUDH49RE8VeFzqRJNNAjX21Ns5vun
         yoWvaEqc1H/HX7edIyHY5JfTkD++6o4vY3/WVs7Sj24KhAEoN6aeP12gsWLlsO+qos
         vXL+L5eCT4uNgy2QSLr7CLXeexvQ/68TLdTLueoNCwyIvw4Ko5nUR5xFGvbhQoqhmk
         HRYmepsXuz6BoWDCIphamzwlH1dSR61XKD1maU1kPtoQ33NMo1f5yIDDfYl1dFpgai
         1S4czM+xMLsW6i16llsWF1ubeeSzUx/ehD39R9BpM7yNsIGYc9RdbM74N3EBcqSBGP
         WD3+0nxoc0RXg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31E293781463;
        Tue, 12 Dec 2023 13:27:23 +0000 (UTC)
Message-ID: <fbaa1652-8402-4f6e-9f68-fbe16c78ce73@collabora.com>
Date:   Tue, 12 Dec 2023 14:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] drm/mediatek: Add OVL compatible name for MT8195
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, Sean Paul <sean@poorly.run>,
        Fei Shao <fshao@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
 <20231212121957.19231-5-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231212121957.19231-5-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/23 13:19, Hsiao Chien Sung ha scritto:
> Add OVL compatible name for MT8195.
> 
> Without this commit, DRM won't work after modifying
> the device tree.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


