Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE0D7E6666
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjKIJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKIJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:15:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01B210A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:15:21 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31F126607410;
        Thu,  9 Nov 2023 09:15:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699521319;
        bh=7E495mU7BugXetHo15jEPw07igwc/8Jw3mgxbekLybc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XfBLTN+CXU+gg+KTN2BCtfLv3c4NautMO+PV5X0bavRwxKLeKIICb+XDy4dcR97nI
         HNtrfoRI9D8GQvH1n7rg8+dm05v0EwSJwLYP80DTf1/4Xu/D5C891IOFmUGKPH1WvY
         umOnA8ejsNAylamAhHk8g48Zrc3gHv6Ru+xqWX6Ysd8eREKFjD8QHS9+tXGh/xL/5i
         Ba2zo2ctz8ChQ+tPWVyOAXUHP2G49XISME1ZuVLnFHzeYO/6dHt4HESs4wPDeFTwkK
         8ACzW1pc2qYfquXs6ire8pi1D3vjnfXy0OX/jJoiP9VGjxfLbUgge/sjg+qMvdts2O
         XVDvyFmkXsFeg==
Message-ID: <c28c99b8-36f8-479a-adbf-442c87062ca2@collabora.com>
Date:   Thu, 9 Nov 2023 10:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: clock: mediatek: Remove compatible for
 MT8188 VPPSYS
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>
Cc:     Nathan Lu <nathan.lu@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231109082201.7698-1-yu-chang.lee@mediatek.com>
 <20231109082201.7698-3-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231109082201.7698-3-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/11/23 09:22, yu-chang.lee ha scritto:
> Remove VPPSYS0, VPPSYS1 compatible on Mediatek MT8188.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

The mail recipients are wrong/incomplete. This patch cannot ever possibly get
upstream if you don't Cc the right people/lists.

Please use scripts/get_maintainer.pl to get the right list of recipients and
resend.

Thanks,
Angelo

> ---
>   .../devicetree/bindings/clock/mediatek,mt8188-clock.yaml        | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> index d7214d97b2ba..860570320545 100644
> --- a/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8188-clock.yaml
> @@ -43,8 +43,6 @@ properties:
>         - mediatek,mt8188-vdecsys
>         - mediatek,mt8188-vdecsys-soc
>         - mediatek,mt8188-vencsys
> -      - mediatek,mt8188-vppsys0
> -      - mediatek,mt8188-vppsys1
>         - mediatek,mt8188-wpesys
>         - mediatek,mt8188-wpesys-vpp0
>   


