Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F14979B8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358394AbjIKWIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjIKLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:03:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00737CC3;
        Mon, 11 Sep 2023 04:03:27 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E13E766072FB;
        Mon, 11 Sep 2023 12:03:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694430206;
        bh=zmb+Vwx3zjcTB7L6BKrvzaQiOZSxQ6E/vnSkZ2DiCq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cCZqKCBVkOog8hAbHsgre8yoWn74wPQJj+QfLg3llNJzJDzvpA5R3S6Rer3UpEruk
         06whb9815zOW1xGXt70FlP7DCVbmFG5OFpUb9VKuNOlgl9bOnAe95SDAxWHXNuw4Yq
         N+DyHTgDL2Pn0rO0xHrg2RmJ5F2ooGxn15gS1qqaBvP/gARJkh500q/dlddC/8pYHs
         hrr52tzYnUer97xKyn5XlD6TWhagYd6TDL77a+i+uRFXNuj1PpS+Who//BmHftnxjw
         Fs6B7AHXDNle/5QHB7HtzTi7np4kMJptNkfKXnaMFZWqV8Ol5qQONCe9mC0zdXaLnB
         QKZoI2FJrTWRQ==
Message-ID: <d7f80d00-a1cf-d7c4-9afe-62f4e59070b6@collabora.com>
Date:   Mon, 11 Sep 2023 13:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3,3/3] drm/mediatek: Add mt8188 dsi compatible to
 mtk_dsi.c
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230911105736.11752-1-shuijing.li@mediatek.com>
 <20230911105736.11752-4-shuijing.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911105736.11752-4-shuijing.li@mediatek.com>
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

Il 11/09/23 12:57, Shuijing Li ha scritto:
> Add the compatible because there are different definitions for cmdq
> register bit control in mt8188.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


