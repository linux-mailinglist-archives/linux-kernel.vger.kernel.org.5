Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1A8036B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbjLDOa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjLDO3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7893AA3;
        Mon,  4 Dec 2023 06:28:02 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1248660711D;
        Mon,  4 Dec 2023 14:28:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700081;
        bh=KkXpkO4uzsj6xvA4i59k3CLFNko3savUBaYI22mJu7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bud/TafLBs8JK0WpIV58pJ5WSOFuQwt/4Q+mr4kx67fZ44XaTFSUe0+D/NUVld1cL
         loHplfot8Av+Mn0ivUnosQ/CCvs4ysLKH63U5BG4xbGFRQgDTHBYfgihdUywdGWgFJ
         Y9ZkigOU8F8HZJOAhWh7Kw4DXV1dyv3MQlJaOYaMqkMTEMFc3RjQgvrILJjvRFtxYQ
         wS/whoNGLmXwKHHrbUMkOaV/0b4F7ZH4RmoPFC3HTT4a70Id+pBYMi2Pn/44MMVD+2
         rqw/hv4qpESADs4S0dAHGdiAJjbN4gT16k06mwediR7grJiI/rF96BbkUraspWyAx+
         i3As60fcz4vRw==
Message-ID: <b8623f65-45f5-4ce6-8b0c-eaf5e820fd26@collabora.com>
Date:   Mon, 4 Dec 2023 15:28:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dt-bindings: arm: mediatek: Sort entries by SoC
 then board compatibles
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231204084012.2281292-1-wenst@chromium.org>
 <20231204084012.2281292-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/12/23 09:40, Chen-Yu Tsai ha scritto:
> Some of the new MediaTek board entries were inserted in a chronological
> order, or just randomly. This makes it harder to search for an entry.
> 
> Sort the entries by first grouping by SoC, then sorting by board
> compatible strings. Also add a comment at the top asking people to do
> the same.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

