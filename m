Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E595F8036AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjLDO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235845AbjLDO3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344A385E;
        Mon,  4 Dec 2023 06:27:49 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E628660715D;
        Mon,  4 Dec 2023 14:27:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700068;
        bh=d8f+uHH0ZzAQlhfNlUmTKSsNaY4TuqeSn7iPVuJ/3vU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kUue6Bc7WklHVY8YY7v+bkCUfMNyactF5IFHJoM2yPgLS1AOSEh2LtEqHrkZB3dgs
         fgSaVUWjqec3N28dStowXIVtBv/d8/BbtVFoPxvXIhxI2+HANpW5XUw/YdIYKofFkv
         4VmQgJfU5NF/bd7Ree89VkFEeETXDuzczlMKMxCpVr+GzcupKZ32TXvXsi8Gqh9Utp
         fwOnYykeee303AroVheubGGqWq28DS33EhLUz8uXicuznhPmJI1vBtj3+LuGac7FxY
         TtStjTm87zwJfuWwKoFvZxsDtp/PpqBBUXJCCY8mCkJH2akhDoumVRkNcXRcNacJBt
         z+CphlB+ykH3A==
Message-ID: <ec4b992d-5761-44fb-bce5-91b1a8813f82@collabora.com>
Date:   Mon, 4 Dec 2023 15:27:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] arm64: dts: mediatek: Add MT8186 Steelix platform
 based Rusty
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
 <20231204084012.2281292-9-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-9-wenst@chromium.org>
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
> MT8186 Rusty, otherwise known as the Lenovo 100e Chromebook Gen 4, is an
> MT8186 based laptop. It is based on the "Steelix" design. Being a laptop
> instead of a convertible device, there is no touchscreen or stylus.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

