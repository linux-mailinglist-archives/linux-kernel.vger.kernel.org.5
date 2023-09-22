Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6365C7AACA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjIVIaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjIVI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:29:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458D81AC;
        Fri, 22 Sep 2023 01:29:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E5C066071F1;
        Fri, 22 Sep 2023 09:29:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695371380;
        bh=vTUoTNsUa8plce4ZbB7dv+A/sBuZjeEuE9SHlr92eUQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XRIegUlz87ygvplzkHPyr2QBNrDZ7bxFA3fdLff1RuEmu9zv7pbyKyrtzsGo5jeco
         NFDJL3h2bUajx2ogb1URIm90kzcWDoOdwrXcSqFE/z2xF5ApRZFDyOflFfmqzWLzHV
         RncnRPGMU89bUCfCprQugeieiwvJDMFkVdKa1bQ0wfkIRfk9ia3+pXB/+cA6EKrfSx
         CPRVDwpeU8ZjR6IneQMiAZZ/+y+ufEG7O9TV94vya7ipXMUplVcNUBc+kX2vw5Hrul
         ZXpIZY+So9oHq9cx+dhYIHeAyDJq1wOVxtxUuD3zugKyQ+Ktusc/+2QeakoQVpLs35
         HMWz9FVSO1psw==
Message-ID: <5b743459-1866-3f51-f3eb-8af335035800@collabora.com>
Date:   Fri, 22 Sep 2023 10:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 1/2] arm64: dts: mediatek: mt8183: correct MDP3
 DMA-related nodes
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230922065017.10357-1-moudy.ho@mediatek.com>
 <20230922065017.10357-2-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230922065017.10357-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/09/23 08:50, Moudy Ho ha scritto:
> In order to generalize the node names, the DMA-related nodes
> corresponding to MT8183 MDP3 need to be corrected.
> 
> Fixes: 60a2fb8d202a ("arm64: dts: mt8183: add MediaTek MDP3 nodes")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


