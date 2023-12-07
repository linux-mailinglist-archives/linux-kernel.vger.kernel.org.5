Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31417808818
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbjLGMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379517AbjLGMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:38:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3241701;
        Thu,  7 Dec 2023 04:38:03 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0C5356607394;
        Thu,  7 Dec 2023 12:38:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701952682;
        bh=hb6z2Q9CYyAeDNhwbTzdfMk0lfdKi2GgZN0PWnVEr7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iOSzA8mj3cT7Vug+lBFst481/o3Jw4y8+7P/jZnj7NAenxNxL3BmwAdje2a+4uv9L
         hWMUqjaOmgEKfErzODvCOQSHVcJCdVsLAUyN6S+fy/KZLmkbWCD2ekUiUkeXCfB3Ez
         +KpuytKTWzXg7P8LRckyNFogNCt59M1D95ZPEk6ukh7qvcaohEyrHdZxFOMcSCWkFI
         KLTUaUNtGSZUgk8vhuhcOna5SYNPgBcFe+QlQfcW5b6m1aRDhPw6jWcSyB2iskUrca
         fM3PQe0iDG9Ci5uRrS9wTzQfvNS6mLF0N6+bIHJl9LUOgyM0oFmKBRS+mDSTvVXcxw
         GRh7d5kf70SHA==
Message-ID: <8dbd5913-8448-468e-b99d-6e3820ff0c72@collabora.com>
Date:   Thu, 7 Dec 2023 13:37:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: mtk-sd: add tuning steps related
 property
To:     Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231207063535.29546-1-axe.yang@mediatek.com>
 <20231207063535.29546-2-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231207063535.29546-2-axe.yang@mediatek.com>
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

Il 07/12/23 07:35, Axe Yang ha scritto:
> Add 'mediatek,tuning-steps' setting. This property will give MSDC
> a chance to extend tuning steps up to 64. With more tuning steps,
> MSDC may achieve a more optimal calibration result, thus avoiding
> potential CRC issues.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


