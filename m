Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF617B1739
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjI1JYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjI1JYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:24:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEDD193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:24:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 103086607333;
        Thu, 28 Sep 2023 10:24:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695893077;
        bh=OKC1ZB4o8RZIhby/fkaNfRn42DaLxN+2mi9lYCYJJeg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QAI9BX+ye6e4uq8fHfbGLRKOlmHv4N8T235esvCLTrUhF3uXUADNvR5I90d8kSgd9
         OugA2C0HU04GN7zcBMgMP64vBIWz152uY6EgEBusNbMyWgaLe6/4SxKmww27fjytAt
         kx7mYRGzge/qklvgX2JzPFkmxkk6P9ElWYZAZKyzumLa0OP2GypZbRouCPRi9cAwmk
         Mc2+YPx6elFPSxxJfpOQdltbZgCgesNxQ2IB9C+aF8drxs+wnWjQwE1xuTb+AaqxtA
         hMtrgHFnnG6mLmBjSCNF+e4fOx96qrOwhPm2cT/zs1nQ4IEH51vIJTskAEnYscIypc
         GR2TkzXoRVnhw==
Message-ID: <fa509d7c-412e-98ca-80a3-0cfe2ecfd6de@collabora.com>
Date:   Thu, 28 Sep 2023 11:24:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v10 8/9] drm/mediatek: dsi: Support dynamic connector
 selection
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
 <20230927153833.23583-9-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230927153833.23583-9-jason-jh.lin@mediatek.com>
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

Il 27/09/23 17:38, Jason-JH.Lin ha scritto:
> Add implementation of mtk_dsi_encoder_index to mtk_ddp_comp_func
> to make mtk_dsi support dynamic connector selection.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

