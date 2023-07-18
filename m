Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E33757218
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGRDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjGRDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EEDE60;
        Mon, 17 Jul 2023 20:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B489612DD;
        Tue, 18 Jul 2023 03:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CB3C433C7;
        Tue, 18 Jul 2023 03:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689650094;
        bh=FsZT3UAWVWPqsLlBW1hX+7mNsXdgptzx0IrC97bX7ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJS/xML4a1tEeTGB+WxO5zldbAibzs1WAP3GE66jTobU8GUh+EG5TL+r4gma0K90K
         tVAKWKvBzI0tFGkcjWgKcVnVDGHWxi2qG/Ngy42ecIOtyriuyu8pLLNLHpCemU2Xco
         ASsFO2CRdxfg+HRd+Ws6DCupM0JSlBrbgd+IYfgVb23rwYkFtxPUN6BRsjs4q3Sx0V
         9uDU7bTZWcBdcK23/a7rM2oeLqVFHLfaI/fvuizP+CJw0+dI6/vznkr3YfqrrFGNQh
         TfS8+RMebAOzC4TZMdR8xy+J00FVGnum2wIr7VqlMeHeqxGZ6qmV1P9FJapUHSRe7U
         IB2g2tLLukp9A==
Date:   Tue, 18 Jul 2023 11:14:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/4] arm64: dts: imx93: add thermal/cma/cm33 node
Message-ID: <20230718031444.GB9559@dragon>
References: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625122549.4066027-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:25:45PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>  Add label for remoteproc-cm33 in patch 3
>  Use Three entries in patch 4
> 
> Add thermal, cma, cm33 node for i.MX93
> 
> Peng Fan (4):
>   arm64: dts: imx93: add thermal support
>   arm64: dts: imx93: add cma area for i.MX93 11x11 EVK
>   arm64: dts: imx93: add cm33 node
>   arm64: dts: imx93: enable CM33 for 11x11 EVK

Applied all, thanks!
