Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F865768548
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjG3Mdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG3Mdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DA1BC0;
        Sun, 30 Jul 2023 05:33:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FD560BB8;
        Sun, 30 Jul 2023 12:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73612C433C7;
        Sun, 30 Jul 2023 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690720409;
        bh=MktGFYcp5SJnOaIiQZ3V1X98yKj/pubSvn8VfFXBdyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oe44o8jx6odBfYNi5veCSOufsRZM7tW4ZmXjlC0zXx4MahN6oLcodgFQ9WDKGGL/p
         f8vquqjWpxe4TXjSODs8LIYii39/ADc16vuMr5Mi4To9IqShv2pM0SSwc0ldASIqfE
         IzlIAHBl9tgoN4dugMsu2OV3XHxlDfwjbR9inEciyVDNwSglCrTzjXJeeLDNt5jQAv
         hSxSFduTF7hWBjszgdLULIqPoVQ9NzZ8UmeXLGa0Gfpn6GxsMwgWTTx4K1bq/Pup05
         zBKyfsho2gTCOrI0uMO0UHYTZfXvlV+roTTQmjQB1tBjhkwFIVScs4RY+cQck1Lqwd
         qupkyoUjMP7Tg==
Date:   Sun, 30 Jul 2023 20:33:16 +0800
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
 gw71xx-2x board
Message-ID: <20230730123316.GF151430@dragon>
References: <20230719161451.7319-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719161451.7319-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:14:50AM -0700, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW71xx-2x board based on
> the i.MX8M Plus SoC from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
