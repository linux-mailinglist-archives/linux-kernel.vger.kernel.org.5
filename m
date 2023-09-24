Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8457ACA02
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjIXObH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjIXObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:31:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF7D3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 07:30:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F823C433C7;
        Sun, 24 Sep 2023 14:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695565859;
        bh=lCkXBJveD4459VWs+UbergDqVNvk5hCEryi1nJFwlZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSQSMlMnKCadjZ5nidZL7oicH5JcDePXNwHmFvXywNotAHGHOWHhUfuYuG9aNgN4P
         YLMf5TNReK+u9Coj86QaCWU/Wdu8rS8qa8lkVvALXkHoorvwurM3TK3MQqvr0/iRCL
         5ieYiZ2Bf0Ofx8IoXDWDyiqKgze69nbDj9t8vqx12k7PEpfVD/xrUuQBmP1fPAodBy
         ABHY1Z/6SVPPjvIzaGoFpPts0o4NXqI/23HQG35YH/6xwwKWCcTkx7A75PqXGOJpej
         7cUuQ9O0wOgc4RqhU1thbNLhoZUEiuYak4G4xr17Mg05ce9Wj/37rO9uRAVgfNyTUi
         gqMt3E4gRxu0g==
Date:   Sun, 24 Sep 2023 22:30:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nxp: imx6qdl-nitrogen6: correct regulator node
 name
Message-ID: <20230924143043.GR7231@dragon>
References: <20230906084625.29491-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906084625.29491-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:46:25AM +0200, Krzysztof Kozlowski wrote:
> Root node is not a bus, thus top-level nodes do not have unit addresses.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
