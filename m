Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F7E79AD26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242455AbjIKVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjIKLOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:14:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EF9CEB;
        Mon, 11 Sep 2023 04:14:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0103366072FB;
        Mon, 11 Sep 2023 12:14:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694430875;
        bh=wCziWKBrYCLn+iQllKVDANcEQ7lNKBoWAymVUANwCco=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SafZm5o+3vl+C1n72vNwCoE59yHGvzAv4GZYMCY2dItGKGNjoUT/kMolJ0AzxDvs5
         IV4MBnajK0v+Xv0Ihvttsz5UTUsInsIyqDlnxhJ/z0hfsKWsk5PVYPNQFIpxiIT7j7
         LG/J2GH54leijlCRY5QwmKYWRpNWCzrY6HNEniTYQO6/ZOw7wWBouz8Ukd9eRmtxtA
         GecTzamVoYEOk0RGABMREFtAOZD8/SMqEQA5Nuy90iBf9qdNVba8ivmywVNI/YMgHG
         Sx3wE4XbtQljCEeJ3OJFDdI3XsmQZZayKSyVopWccc7ksZmUbzQgDDqGHGGNIv1Tf/
         bTobRshmTPG/w==
Message-ID: <5146679e-3ae8-edc7-69f9-c89ca1e7199b@collabora.com>
Date:   Mon, 11 Sep 2023 13:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3,1/3] dt-bindings: display: mediatek: dsi: Add
 compatible for MediaTek MT8188
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230911105736.11752-1-shuijing.li@mediatek.com>
 <20230911105736.11752-2-shuijing.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911105736.11752-2-shuijing.li@mediatek.com>
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
> Add dt-binding documentation of dsi for MediaTek MT8188 SoC.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


