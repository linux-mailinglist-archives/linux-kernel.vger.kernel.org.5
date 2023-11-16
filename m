Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF5B7EDD38
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344956AbjKPJB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjKPJBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:01:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3571A7;
        Thu, 16 Nov 2023 01:01:21 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 291886607337;
        Thu, 16 Nov 2023 09:01:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700125279;
        bh=3GtzmtDRJWmMBIANQu8gF1p+cuSCdiSRabli1wCj1UM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ShrG+huoA/Fle80o9Bpdz+qisL2slIJUpwcb9gd8NKwgxClm+rk0XBWUgljhC2nFP
         karFwLtwgT2vsniRZ5aXMO8OrKd09u2LUKtMgbI/iwX3VwcDPDBva7Vw0OYo+NJYki
         DC0z4+Yfan5kRj5Bwy/HT5ohVr4iKli2bW9AA1r61CeEWP9sR3p7r85mvc0/a+CYze
         6AEnkwM9QYXA+bAyqQPm3firbcbzr/Tk1JjJ8Nuu6E8yhk7nrS5qE20OLzCJncYBu7
         5rvUh5W8ywl8v0dtFbQePiwv7KnWt+/rLeqBdNlLVvI9sV8w7qQbXEssdhEg4PQ6cO
         /wm3Kr7cihhTw==
Message-ID: <8973ce67-9f87-4a21-89f9-68ed5d6d75bd@collabora.com>
Date:   Thu, 16 Nov 2023 10:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] soc: mediatek: svs: Add support for MT8186 SoC
Content-Language: en-US
To:     Mark Tseng <chun-jen.tseng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231011034307.24641-1-chun-jen.tseng@mediatek.com>
 <20231011034307.24641-3-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231011034307.24641-3-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/10/23 05:43, Mark Tseng ha scritto:
> MT8186 svs has a number of banks which used as optimization of opp
> voltage table for corresponding dvfs drivers.
> MT8186 svs big core uses 2-line high bank and low bank to optimize the
> voltage of opp table for higher and lower frequency respectively.
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


