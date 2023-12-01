Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13AB800682
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377986AbjLAJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377977AbjLAJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:04:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DA194;
        Fri,  1 Dec 2023 01:04:18 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 525386607355;
        Fri,  1 Dec 2023 09:04:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701421457;
        bh=0kTgGEFrtxmALDxuSPD6o0PLxYETkKdh7nPJkhHPcNs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZHyFuCVnw5FXu3RVfPY4oOVdtFuk2vNmxRgw3PQ9Ro7TVV4A3jhGNTY6DwbzIoYnr
         co/Bv0eEApPWkxTkZyCsawZ4ZWADLUeck2FtkVbIL5AuED1SsWZWe5Y2EE9/Cof1RE
         eVQqB5uayS5FmyvznPNMFmxOvX4UcUuJ8MHM4V7ODN/wVUgEc4USt0FKmav7QS+dmg
         A2gzIytwhIWiPUt3osopudPbEuspmmpVXUhAOX26rNl/C8Vwi5LjXTLWVXDRC8gwF5
         rwVoEDwlm62VS5d3GBo5X0u6AvuykwyU5WV7733S40aquizZIZGDE/by8dCsRfUBHN
         EHIpX/0GVyniA==
Message-ID: <6a8b3f78-a7f0-47f1-af9b-671ca900ab8e@collabora.com>
Date:   Fri, 1 Dec 2023 10:04:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: mediatek: mt8186: Fix alias prefix for
 ovl_2l0
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231130074032.913511-1-wenst@chromium.org>
 <20231130074032.913511-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231130074032.913511-4-wenst@chromium.org>
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

Il 30/11/23 08:40, Chen-Yu Tsai ha scritto:
> The alias prefix for ovl_2l (2 layer overlay) is "ovl-2l", not "ovl_2l".
> 
> Fix this.
> 
> Fixes: 7e07d3322de2 ("arm64: dts: mediatek: mt8186: Add display nodes")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


