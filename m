Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162678036AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjLDOaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbjLDO3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B95385D;
        Mon,  4 Dec 2023 06:27:49 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DCDF16602F41;
        Mon,  4 Dec 2023 14:27:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700067;
        bh=V9x5XsnAYvTRabg/WvQRDL3w7N8rufl/OG+QWOqronQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hir36KpxRDGhkVeELLiLNB9qCCq2/X7ZoUG6lyCWRfccnF6rhMDrBYZH2QQAXgV/J
         79sw1Slt214xnYDOGqS/AOLHx3+Nf9ZYZ+er3XX01IUWqczOp7ASEaOxASa9lBhyqh
         EUDo2Tcl+O/uxc04HqwDYK5Adehm76h6zw3Yczm95VVhKlU6geoDku+tJLh/Pk+gyF
         VDlBXJGGwhZ7PXnGH8OjZgp1GUF3j+7MtLspBjDff6nOLPPiRHGK+P14HpcYopxtej
         3FCeKN0L9fUoGh1LRaGhbU4PIw/DM5OPSCY8eBGg0nz5PTiM0fidwWNA26nWGGiHHI
         tGmL71pD8OWIg==
Message-ID: <e68dddc4-7175-4457-9882-6403b09a1e8b@collabora.com>
Date:   Mon, 4 Dec 2023 15:27:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] arm64: dts: mediatek: Add MT8186 Magneton
 Chromebooks
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
 <20231204084012.2281292-10-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-10-wenst@chromium.org>
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
> Add entries for the MT8186 based Chromebooks, also collectively known
> as the Lenovo IdeaPad Slim 3 Chromebook (14M868). It is also based on
> the "Steelix" design. Being a laptop instead of a convertible device,
> there is no stylus, which is similar to Rusty. However Magneton does
> not have ports on the right side of the device.
> 
> Three variants are listed separately. These use different touchscreen
> controllers, or lack a touchscreen altogether.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

