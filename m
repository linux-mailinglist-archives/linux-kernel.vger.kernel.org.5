Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDE27B6818
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjJCLiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJCLiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:38:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3289E;
        Tue,  3 Oct 2023 04:38:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E7316607313;
        Tue,  3 Oct 2023 12:37:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696333079;
        bh=CBp8+gNkRzBEFZU964Z4m7S1kl7820hZYja9Nis+J5c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iV63/FouGYa1jsTZp6muZhX+6NhaklXSntSFMFCy/BeuPBWvJRtEy5MGFkKknJbRp
         5j/w4UtJ1yRneKZZqYtFqT8gjfdOr1EpSAaioLQZhjhfiz5LExJu4L6519eUojSLgq
         nNyrJAhVBozE1kOoMPuhhH2MVz3c3TiancKmYTSPv/htADbAEl/oKHtcnwvzR6OyZu
         045V3oOcP5T6zykG4hDpe7cP2+R4wEnUi/oXZ4VWviQPxls6tpp8CUc6XlWYIkBPAG
         btPp3OvnrhSCpdlx0GLEzI6FuDALfTm0ZsubS6v7xJVaKGqF1hZV1ZMn1vPWCx6GZE
         KSltA2GZpcZFA==
Message-ID: <51a5e6e7-c583-2ecf-3928-24b2fc07aedb@collabora.com>
Date:   Tue, 3 Oct 2023 13:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/5] MediaTek: Update MAINTAINERS and dts fixes for v6.7
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Jieyy Yang <jieyy.yang@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231003-mediatek-fixes-v6-7-v1-0-dad7cd62a8ff@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/23 13:13, AngeloGioacchino Del Regno ha scritto:
> Hello SoC maintainers,
>      
> As suggested by Arnd in [1], I am sending an update to the MAINTAINERS
> file, adding myself to the MediaTek SoC maintainers, and some urgent
> bugfixes for MediaTek devicetrees.
>      

Forgot to add....

[1]: https://lore.kernel.org/all/84b2de54-8337-42a3-a25c-a95cf2f3349f@app.fastmail.com/

...so doing that as a reply to this cover letter; sorry for the miss.

Cheers!

> mt6358 PMIC
>   - Bogus property dropped
>      
> mt7622/mt7986a
>   - Fix dtbs_check for t-phy nodes
>      
> mt8195:
>   - Fix early boot failure when DSU PMU enabled
>   - Fix memory layout for demo board
>      
> Regards,
> Angelo
> 
> ---
> AngeloGioacchino Del Regno (1):
>        MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer
> 
> Eugen Hristev (1):
>        arm64: dts: mediatek: fix t-phy unit name
> 
> Macpaul Lin (2):
>        arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
>        arm64: dts: mediatek: mt8195-demo: update and reorder reserved memory regions
> 
> Nícolas F. R. A. Prado (1):
>        arm64: dts: mediatek: mt8195: Set DSU PMU status to fail
> 
>   MAINTAINERS                                  |  2 +-
>   arch/arm64/boot/dts/mediatek/mt7622.dtsi     |  2 +-
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    |  2 +-
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 39 ++++++++++++++++++++++------
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi     |  1 +
>   5 files changed, 35 insertions(+), 11 deletions(-)
> ---
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
> change-id: 20231003-mediatek-fixes-v6-7-341b5cfdc07a
> 
> Best regards,

