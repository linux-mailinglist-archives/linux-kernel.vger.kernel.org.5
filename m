Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA467EDD1D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjKPIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjKPIvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:51:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEA4A1;
        Thu, 16 Nov 2023 00:51:20 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF9826607337;
        Thu, 16 Nov 2023 08:51:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700124679;
        bh=DqmuAspJuC+u+5khGNbyPkSM/AWgBnoD3ON+vRqFxEU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hbry3TeNmf6wo2GjK0QRPFfwYDol5mVaFG2MbMZ46WWBur37/LA8NpOwX+lDw6cni
         FKJGb78WRqJCgLwCoKEREKKmYHJTj4qE1DituBAp4vTYBAgvyTcLcQxmYrpUZyCohn
         Dm8fBdXNjvw31+mnNLqextpgegosAjzMl7Mrwh5fazOIJk0b4thYtc8SQKNPsPzsxw
         hZ0FGYZxUx5rj2+v9+AqFUdmHhv6Bo+tqIUVKak64ENpiLUh7pNRAq/+Z9kxupyJ8K
         Lriny8urjvLYhmmzyTHZ8i6hlQYsxRFZIqanA0zLhdbSgmeWcK5NFNea0ocMK2bKyq
         YDhhP1+vPSHNA==
Message-ID: <ca7be6c2-d3b4-42ca-bc16-b8cc88a5a832@collabora.com>
Date:   Thu, 16 Nov 2023 09:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: mediatek: mmsys: Add VPPSYS
 compatible for MT8188
Content-Language: en-US
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Garmin Chang <garmin.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231116080129.20617-1-yu-chang.lee@mediatek.com>
 <20231116080129.20617-4-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231116080129.20617-4-yu-chang.lee@mediatek.com>
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

Il 16/11/23 09:01, yu-chang.lee ha scritto:
> For MT8188, VPPSYS0 and VPPSYS1 are 2 display pipes with
> hardware differences in power domains, clocks and subsystem counts,
> which should be determined by compatible names.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


