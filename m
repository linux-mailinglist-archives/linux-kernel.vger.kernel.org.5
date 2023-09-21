Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0905B7A9CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIUT1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjIUT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:27:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A07A4A9A;
        Thu, 21 Sep 2023 10:58:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 61E406607298;
        Thu, 21 Sep 2023 08:19:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695280762;
        bh=NCoS11TMBletQQuR/cD/4ifg4uBFUuYSpa3EvBEYdzU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i4+tGfrj8stBs2bJPHoKS3fkXMx674udFF6nMweSkbQZAM1oRcUGMmgsrC0ANk/IM
         p5WZyhVu7imzLd5ljB5qAdGdwor+nPpE6HgTcUT4l11c7aJix2qEZORBozafr/6biK
         fpcFZ/SbW7kHwdWvd0toRpIyekypbiPYWWxl/kNcI8ZyFjbw1pd4zWkG+5u/psAhxn
         b6TSBP8e2qeHclUEaOUT9shuGM6ZCu2SuC+NxFifjUwkfwFt2BKj4JuaUMLo/8tCAk
         lfT0cWxdKmYqr+6lMMVdhaw+KgOXJWPWK7uvRNC4aAInjpSyAhYNPTHvDeoN4hSwKe
         HiWgx14suzSOw==
Message-ID: <c5d331a6-b5af-f5b4-ea9d-059d3c3c78db@collabora.com>
Date:   Thu, 21 Sep 2023 09:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 2/3] soc: mediatek: svs: Add support for MT8188 SoC
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
 <20230921052637.30444-3-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230921052637.30444-3-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/23 07:26, Mark Tseng ha scritto:
> MT8188 svs gpu uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


