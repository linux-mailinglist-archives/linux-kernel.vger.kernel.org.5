Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316276854A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjG3MeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjG3MeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214821BC1;
        Sun, 30 Jul 2023 05:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2D1360C0A;
        Sun, 30 Jul 2023 12:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41367C433C8;
        Sun, 30 Jul 2023 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690720443;
        bh=ucouqFyrE16pOZzn/ScUxf300YUWRTVniM1gUdJql54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dOv1x/yFiLHwIPEpKqQYxlW5r9PFpLdDI0hXkQjTcacShYlcpLSWInPpHClZy/d+H
         l4XQGUtoaQlpCDPlt8b2B5n/9yBb93qNWJkCdGcRQMgR/a+WCnnhAU5T8NVXTNIjPU
         2o0p77WzQ3OD5RFJap/lYovdzQLXWi4kW9BNnRn38D/NoH8VduvKTExo3YcKaCnT96
         +jfWDDgvIWuBO9OUpGoAxsLeytB6LHC5Z/S43Cw+c1uno4/jYHLJhjTtqBeZKgWQsO
         D4GC7q6Ozc5SQGc7gthb36C7xbzXFVEzIP7bA1sUN3J5lX8eGlGV7YJd+oTG2PbEJc
         fRgK15iZFpFZw==
Date:   Sun, 30 Jul 2023 20:33:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add Gateworks i.MX8M Plus
 gw72xx-2x board
Message-ID: <20230730123351.GG151430@dragon>
References: <20230719161531.7444-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719161531.7444-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:15:30AM -0700, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW72xx-2x board based on
> the i.MX8M Plus SoC from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
