Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082C7C04CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJJTjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjJJTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:39:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4199
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:39:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B5C433C8;
        Tue, 10 Oct 2023 19:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696966757;
        bh=jLybmmqCIxDnVXPrUBWg4L5usGGWYSA0Tz28a1z32eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OhW6aqX9qYWPUWDh37OuLKGEds1Y7s1JNlK96sq2lea69gtAuYyBX2UHuUwcaXK95
         zLhbTqJYwaovHiATNuAGy/MUR/Gg0JsxiQr9vmUheTGlJMzqNeFocPgWhdBL6MTOnp
         UDcWMNtPTTjPqQTloYsW3osT26E89Zn5H2pQYVYQaGLzp4c8zp5yRYbsDUB8nEKfPY
         +/sbb5C1vPCnXsDRH2ZDOu+FRU1vqIBO06uSaEOSQK5HOF0MZE1pzvPGc2CK4gTxOa
         njcpS2CjFU05n6LE+fj55Rdto71TywMmlhWyFeIcxXn8RhgEcEUXl991NqB62WqsU7
         WYLkmafY6SOkg==
Received: (nullmailer pid 1426033 invoked by uid 1000);
        Tue, 10 Oct 2023 19:39:15 -0000
Date:   Tue, 10 Oct 2023 14:39:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     conor+dt@kernel.org, s.hauer@pengutronix.de, broonie@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de
Subject: Re: [PATCH v2 3/3] ASoC: dt-bindings: fsl,mqs: Convert format to
 json-schema
Message-ID: <169696675468.1425993.2823968878328380539.robh@kernel.org>
References: <20231010133838.799714-1-chancel.liu@nxp.com>
 <20231010133838.799714-4-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010133838.799714-4-chancel.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 21:38:38 +0800, Chancel Liu wrote:
> Convert NXP medium quality sound (MQS) device tree binding
> documentation to json-schema.
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,mqs.txt     |  36 ------
>  .../devicetree/bindings/sound/fsl,mqs.yaml    | 113 ++++++++++++++++++
>  2 files changed, 113 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

