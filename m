Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031076854C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjG3Med (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjG3Meb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864171BC0;
        Sun, 30 Jul 2023 05:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CC360C34;
        Sun, 30 Jul 2023 12:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FBAC433C9;
        Sun, 30 Jul 2023 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690720469;
        bh=5ShksDC7Xwq4ssfgZ4G1k7+uyeAr5iT2+Qvr5RrlsgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eg62zhZIEG/U9ttf7KrIpKUavW582hw9OLPt3q9yO3LMG2lUM62lDJf9aqPJIYvej
         KuioU9e0ixpDln1eatT+5lY2REgQYLXfgbB9RST4iudKoAvZ5iJp2SJQPRO/XksvIO
         WgX9oySERzv/b/qpk8hkC4wBrT/zq/bSS5l1kbTtA/y8rCoZd2bnIhie2KuDH0JNqq
         q8rb8bCEtp2hH0YJxIJW+QwYs3J7pey9rxXKg3iATUtLePVFX8v86Y6ASTZ6aUDEe/
         0E7oKFLk5qc85XFdnl/wix6kfkdxsy1AiVLtLpzi/YUKXTyDZS28F8nFnYcSC2TY2Z
         BxUOJQS3bbOdQ==
Date:   Sun, 30 Jul 2023 20:34:16 +0800
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
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add Gateworks i.MX8M Plus
 gw73xx-2x board
Message-ID: <20230730123416.GH151430@dragon>
References: <20230719161827.7588-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719161827.7588-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:18:26AM -0700, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW73xx-2x board based on
> the i.MX8M Plus SoC from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
