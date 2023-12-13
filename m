Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC6810D37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjLMJSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjLMJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:18:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0ABB7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:18:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81FC433C8;
        Wed, 13 Dec 2023 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702459130;
        bh=UCR2zqaZGFe+0JBqYTQeeFFVQLdULVGr1Di1EOawjEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QznIbqvclrC4C2BwVAts0jr7ZjhGqF6LnBdhfMwVxR3zgbaqf1m1rRikLEzJFe+ZR
         LX6rkbKX7n+f78iIUs3GRX6IrWdd03hJl83ovw/NRGwix6sX/r/liXNXjNpRJ7S6rj
         q6LGBYQaaf6QlJVVdkVsPLL1UBvg1Mz6bEImsAtboqtpkYGCtTUypYx85HCmmWEJDP
         jY5HzJexEOr3IidvKNyHj69oddWKCfNhyGgqmNXbKpvjrwluIi7Ja2F7Sfcmj+bDdq
         X0A14+E9zpbY0D7CjHKSGoKJMVeHnHCeUXYkCwVDC/WB9S4Q/xCa4FdaoKnU5tF90I
         0nREBa+JWQncg==
Date:   Wed, 13 Dec 2023 17:18:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH 0/2] TQMLX2160A support
Message-ID: <20231213091844.GM270430@dragon>
References: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-for-ml-tqmlx2160a-v1-0-622e41ae4d8e@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:01:00PM +0100, Gregor Herburger wrote:
> Hi,
> 
> this series adds initial support for the TQMLX2160A SoM on MBLX2160a
> baseboard. The various supported Serdes Configurations are added with
> overlay files.
> 
> Patch 1 adds the compatible to dt bindings
> Patch 2 adds the dts files
> 
> ---
> Gregor Herburger (2):
>       dt-bindings: arm: fsl: Add TQ-Systems LX2160A based boards
>       arm64: dts: freescale: add fsl-lx2160a-mblx2160a board

Applied both, thanks!
