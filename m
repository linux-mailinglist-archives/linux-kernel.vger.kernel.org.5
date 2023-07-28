Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A74766684
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjG1ILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjG1ILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:11:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4935A3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:11:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF5C3660704F;
        Fri, 28 Jul 2023 09:11:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690531867;
        bh=vCwUzlqOQGnNY9fGXomLGaxMGGyn0nTi6KpRvQZbsfw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K7hVcO8Oeapz0cviNUSNSl24JJFW3497w7NWQsDmgOOWg+mfCSAeRiao3ndHFmNLB
         uF0MzRhYqtapZnPT5MQDaMOg89Ul/j1VfCA4ABKVpSfJtTnmbn8s9UCjb9qVPUjPsP
         rZ1GYkthazIVXwZkicAzMeR2YlC3IfKrKO+de4igI6/bt3K+1FwBLyhSGxOYXwpWX9
         z4arbaKCBqHrhsnqRGiwcTFzmUMYaX/YO1uU6LhQ0zQ7LLSdWWo+gB+FnvYrvMbE8H
         TuOgLdfPhTzE4sBViPG1nos5UM1suh1PAhaFse0zNLM1DpRmBQzkG02DK0Puv/Ujr6
         GbXM3zzwC/DZA==
Message-ID: <fd1cb69e-f942-581a-48e8-4fd160ab1b64@collabora.com>
Date:   Fri, 28 Jul 2023 10:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 1/4] drm/mediatek: Add mmsys_dev_num to mt8188 vdosys0
 driver data
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
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
 <20230727164114.20638-2-jason-jh.lin@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230727164114.20638-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/07/23 18:41, Jason-JH.Lin ha scritto:
> Add missing mmsys_dev_num to mt8188 vdosys0 driver data.
> 
> Fixes: 54b48080278a ("drm/mediatek: Add mediatek-drm of vdosys0 support for mt8188")
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


