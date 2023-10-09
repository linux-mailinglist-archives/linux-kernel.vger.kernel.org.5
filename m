Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2907BDB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376265AbjJIMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346444AbjJIMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:20:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D95E4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:20:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F2D0660708F;
        Mon,  9 Oct 2023 13:20:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696854048;
        bh=ipB1t0cSQBymxpdIikiz/0GTXsJ8nWOTmw69GaAQ2UQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jr18bvPegygn6tygNt5zBGY+jZ5jyWS7TnxSWSDFQsK53uootGZUv6iArYChIfpvb
         LsUHOvT8lMcXXTnztBSWd22Xt0QABmwW50y0q9uiipRjqkIy+AwgDC3vShB9Mw3ooz
         3+9HAfDGNYVOdCxao8Do2Ye+re+VDFgVgUgRw7gkmBHkCxyaAd1OLli1R2TShQU403
         Y/ZrCoge1oU/c0d/aNDiR4dHaosENj1Z9+dBUrfhDbTpgilEHk9lCg11ho3flFjrD4
         F98R5O1/W4y0J5z6fi0MEqgZ0Vt/gm9Js7bTvH2AVRoX6UGfX3gre4FB6rFdfzd50D
         bTzA8bI32aQ7g==
Message-ID: <cae3a6c2-d6be-0795-f242-100019f1a070@collabora.com>
Date:   Mon, 9 Oct 2023 14:20:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [v4 1/2] ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S
 support
Content-Language: en-US
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
        trevor.wu@mediatek.com, maso.huang@mediatek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231008014629.4971-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <20231008014629.4971-2-xiazhengqiao@huaqin.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231008014629.4971-2-xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/10/23 03:46, xiazhengqiao ha scritto:
> Add compatible string "mediatek,mt8188-rt5682s" to support new board
> with rt5682s codec.
> 
> Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

