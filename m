Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CECF768546
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjG3Mc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG3McZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:32:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4993F1725;
        Sun, 30 Jul 2023 05:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB71860BCC;
        Sun, 30 Jul 2023 12:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AF4C433C7;
        Sun, 30 Jul 2023 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690720344;
        bh=6rP7JcsUJ5Fo987F4YO2nptT+g6VXI4B1ftcUcuxdjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vcajnly37wfAhe9ClkIOi5wdywC7MYKx92twVnnML6hgJh7gCKhdsm4HEeWpDnmoo
         KgJyIVkOpQOGrSrLv8+hbacCskNU8z64YE1thA08TcKq6TjxS+9srI2P61mgLTo8dE
         Y7tf9hFaI/vmj6n8Fe3wJPkPiyhpHLeS2GuYmJOuw7fLu6SNzKBTsTWuL+571h9Bbp
         pFNt0AJ9fJZFFzZCah9bR3mGrOxL91px4e9bki6a5Ac/bQHALCvgGs0wS4UJUcqMX9
         47Xbg6Os2rPIZnwGUhR3KruWiYVynGV6apzvvXlXaoxQDkzVyuXywwx+kzb/kX60i2
         VeacQj3kplksQ==
Date:   Sun, 30 Jul 2023 20:32:11 +0800
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
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini
 GW7905-0x board
Message-ID: <20230730123211.GE151430@dragon>
References: <20230719161221.7005-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719161221.7005-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:12:20AM -0700, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW7905-0x board based on
> the i.MX8M Mini from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
