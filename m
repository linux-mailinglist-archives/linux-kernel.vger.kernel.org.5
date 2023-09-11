Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846D579A3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjIKGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjIKGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:48:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F5612E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:48:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFECC433C8;
        Mon, 11 Sep 2023 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694414934;
        bh=hPkw5GuTE8bPGfOu0uc05CKGeaAlGIBq7eXbCERyugc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ldhH/t0eiRtV+iZqz18Dv1szdI3r/3d5j6n9FFbDsWFdFE82vSeKbXvo+TBa57BKv
         6Z4Kbb8pfOH4sPXuzEXBbsW0ZEMS47IT5HfsK1sKXFqYVrh1ZF5EJ3XzBDmXDxRXIi
         rfwwWluSwQNnQzoeAznGl9WbBfa8C9zRqSZ6FSndf4T/B6VJA22jqSCmAXMX1XXIQ9
         SxYb/5wLKkuE8hcSlMovNHP736w2vNTbT8p8BBx+dOqX+qMlUaNRSluFXu4TjBvTO/
         5c1lxGkXI13A8E27RaTHYdpzJ//L0LdG6gvsillgR/Wf9zcCzLTu1+YpOdzia3te5v
         oYjFxdiJYO0+A==
Message-ID: <f8f2403e-5931-1b33-850e-e88cca4b057b@kernel.org>
Date:   Mon, 11 Sep 2023 08:48:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 01/20] dt-bindings: display: mediatek: ethdr: Add
 compatible for MT8188
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230911031630.12613-1-shawn.sung@mediatek.com>
 <20230911031630.12613-2-shawn.sung@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230911031630.12613-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 05:16, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 ETHDR.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

