Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE87EE26F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjKPOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjKPOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:15:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078711F;
        Thu, 16 Nov 2023 06:15:36 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 82342660734A;
        Thu, 16 Nov 2023 14:15:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700144135;
        bh=EIPsM67ANJzpy88Piqk/eKq1WBdo5WSII3uZmoT8sOk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kPMkCqRYwKWnoOxHiRwASL+IIWJYbjM4FcTkMQHZt3rYct2xV3lG6J9SIMtEAVs86
         Du5Kj9l38OjG4SOd43rnBBRz0fuWpXLo1B2XvV+kGzv9FRWVARc+eo5CFq/5IWkqV4
         syjVJhywj3pJZQY3CcEb1kbZoId+l0j1N8pa3oRumqTQQBV51hVnozMRuy1IvGDl0B
         yOsNVhj/rAxPXJ3iPv4jClAky0ERJ5x/SnMbw2EJuWNaQXf+z/aFEibpOzDlXtDmfz
         7ck3+XwaJKxY7gSJwg/vT2Gtv8pGup9/4It/dE3pD4KTl80hxmyfJ9qhnuOKlWLG6P
         yZdE+Ua8lXrLw==
Message-ID: <a5a3e14f-9e10-46cb-a0a3-f76248738a87@collabora.com>
Date:   Thu, 16 Nov 2023 15:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: soc: mediatek: add mt8186 and mt8195
 svs dt-bindings
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
References: <20231116110447.3598-1-chun-jen.tseng@mediatek.com>
 <20231116110447.3598-4-chun-jen.tseng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231116110447.3598-4-chun-jen.tseng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/23 12:04, Mark Tseng ha scritto:
> Support more SoC svs compatible in dt-bindings.
> 1. MT8186
> 2. MT8195
> 
> Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


