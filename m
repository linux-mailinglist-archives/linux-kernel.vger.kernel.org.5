Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A48063F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376383AbjLFBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjLFBDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:03:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E004AC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:03:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB43AC433C7;
        Wed,  6 Dec 2023 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701824602;
        bh=0vLsY6u2UoxJlbnKoMmD/RQTZH8jVMu/7QKA/18Jqgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcBQTLeu4y1WjBDbqOFbfqDN9Wv8SUEa/G7Yd5L0yELcX9QHjkWj6UwcL7d27bY/t
         YO86+dGkn4o+7uGWgVzHzxqJ0oR/SDeYk6c8kLh/9mwdAoJGaILtkK6PVy1tiyhLVX
         HKprU8cvKywLUmxcR4wBjHidrZXUGZQe5K/98vXCDIPwrvRK2f1Wo2gDK9ouzbqEhc
         vmI/B3Ad8udotta/K8dp9SoZV0sWeCZHBC1RnAXK0Sg/RRR9PwRtDA5wJ+7G2DOBIH
         ZujvipcSZ07MsQ4mNPnLwbNzfvCpN76K+pcRsuyjoO0eiDHdxX7WZRfqQSZZte/oxh
         ZL3jJtHXe64lQ==
Date:   Wed, 6 Dec 2023 09:03:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add compatible for SKOV i.MX8MP
 RevB board
Message-ID: <20231206010316.GN236001@dragon>
References: <20231113113855.4076151-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113113855.4076151-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 12:38:54PM +0100, Oleksij Rempel wrote:
> Add DT compatible string for a SKOV i.MX8MP RevB climate controller board.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
