Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5648064AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376654AbjLFCFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376671AbjLFCFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:05:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D821B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:05:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D347C433C8;
        Wed,  6 Dec 2023 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701828340;
        bh=q7kBWoEGiJcmUw2nDHVAx/qtiR4gJ5tI5mmdyMUBRVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hNrPM6DW511/RSweMNjPMc3QBSfFt9qZviV5ipFgzHHQ4le4k4gssNu/82i4UtJF9
         Ffkmpc2lsYIeygiSRYzwFVFjLc4enTIfJlx4P9WWOhfDO/fA/f7MY6rqlrP+ADfzlB
         9MvdIy0uk0pP61cRVtcNEP0SMTMniqolKwLg7TSKEE+9fcrM8w54zGBz2KUjNYK1Cb
         X7/Y0TwqNsE3kSuKQS8tpMAlRyCEDQz4uSJz3wGNRsXjCXl45kPEFLiOwSBBwuWwDg
         ZJXtvTZA3/YMogjRtLE7EvXo+xBbcIxnaG4Cs9vpdjhUappzM/k2jMxy27stKOorLK
         BA4k7+Hs7BUsA==
Date:   Wed, 6 Dec 2023 10:05:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <Frank.Li@freescale.com>,
        Anson Huang <b20788@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx7: Declare timers compatible with
 fsl,imx6dl-gpt
Message-ID: <20231206020534.GH236001@dragon>
References: <20231127-b4-imx7-dt-v1-1-6ecbd0471cc4@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-b4-imx7-dt-v1-1-6ecbd0471cc4@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:05:01PM +0100, Roland Hieber wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> The timer nodes declare compatibility with "fsl,imx6sx-gpt", which
> itself is compatible with "fsl,imx6dl-gpt". Switch the fallback
> compatible from "fsl,imx6sx-gpt" to "fsl,imx6dl-gpt".
> 
> Fixes: 949673450291 ("ARM: dts: add imx7d soc dtsi file")
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Applied, thanks!
