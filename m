Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651327B173B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjI1JYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjI1JYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:24:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7CCAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:24:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CED2066072A2;
        Thu, 28 Sep 2023 10:24:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695893076;
        bh=x3Cm7auwoIUOgII2Rhz2cmoHlHW0TwBSCVD6n8f4Ti0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gAFRz6577QKM0TiVZIYzURalkWB2wB9rmZz5P3oJ8KGDq9SDbEh4qWQ/io9xhmUoN
         AMUCxoSQSzKHqHpI9HddTH7+x87og6VlNm1mqYph4igIJ8oI5JX6JITH8TpyZnhTCv
         /XU+SrOfhJTJibc/sMrh3A0VFP8evZwy+gWyDQJKYWvsVutKloua4dTXBYD8ziJ5zJ
         VDLkwStCZEZkWh+DgNY0E1LWma4P/KvwiMxiUhLlfsGXnJpCfgIPFJW/dNWbqJMz1n
         tPLTPkwQPUuKJRB44MbOVRZhSN94EacH3hEUCphe9ajT8F/6VVtZcJBHtpMssDSzgX
         wigu6rIIlsgIA==
Message-ID: <dde725f0-2e9f-f506-7a7d-d5ca4797f1cb@collabora.com>
Date:   Thu, 28 Sep 2023 11:24:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 7/9] drm/mediatek: Support dynamic selection of
 DP_INTF0 on MT8188 VDOSYS0
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230927153833.23583-1-jason-jh.lin@mediatek.com>
 <20230927153833.23583-8-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927153833.23583-8-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/23 17:38, Jason-JH.Lin ha scritto:
> Move DDP_COMPONENT_DP_INTF0 from mt8188_mtk_ddp_main array to a
> connector routes array called mt8188_mtk_ddp_main_routes to support
> dynamic selection capability for mt8188.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

