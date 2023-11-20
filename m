Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F12C7F148E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjKTNlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjKTNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:41:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81601AA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 05:41:17 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64D9F6602F1D;
        Mon, 20 Nov 2023 13:41:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700487676;
        bh=PfevUn2vEpVwdELNCNuBvMAFJ97ByO4+qoe/NlZlijg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L3bxV3SEJrsJ68N83Y21UhALaDEq+rP54Yg+fETvbxwtxSTlRFBOlRy8515AsSxKT
         t2fC8iFEJ+oal37ScMpl7DLMaoKvvP01QGtxNRstfE/JzQYBiBr0toRm71Nb+fu443
         Nscfkin9tK/eXCl3wj8sgdPxtXmfILRIUtd4lVS18RB27iDaqQ3tA/lo2vH0xMNX90
         WeahCdnQAx93mhAJvWsFHb+HvoLQoFu21ss0y0g/p7dsoYH1Hr3zsL9Hc42flXnh6f
         bijtP/lKaUOPd6DbcYY/D2alMKQeHrccShG9MwSriut38cdj5CGWFVzY9KC0LEbWdV
         WjIP2zZjpBHlg==
Message-ID: <a7243a4b-766f-4e77-b0b5-0450f02d32e9@collabora.com>
Date:   Mon, 20 Nov 2023 14:41:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: mt7986: change cooling trips
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
References: <20231025170832.78727-1-linux@fw-web.de>
 <20231025170832.78727-4-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231025170832.78727-4-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/23 19:08, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Critical and hot trips for emergency system shutdown and limiting
> system load.
> 
> Change passive trip to active to make sure fan is activated on the
> lowest trip.
> 
> Fixes: 1f5be05132f3 ("arm64: dts: mt7986: add thermal-zones")
> Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
> Suggested-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


