Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8E7BF07B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379385AbjJJBs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379375AbjJJBsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:48:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1E4AF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:48:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67570C433C9;
        Tue, 10 Oct 2023 01:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696902503;
        bh=kUwYCV1HWM2P6lIEq3c4qI+osCI3I4iSKL4CC7IOPzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwknGgGaIJbp3a4SIe6EeBsAKpOXssiNh0kEsBusc1Pp3GscQjPo6m1MOx9BboFzI
         61aFnm4MwrQ+JDS46s2bpnT6yndY+1ucnp2J29URok67KKcasNfD3VtWAgLxJFbVTv
         TkKTsKavDQlOHuQE2EnHROWbXK5xo2mSBRdvpBwWK6y1RBF2KsmyDFCLz62b0Dy6DX
         gRsa201hH4rQSB0/j5fq/IIlSkhOVhSzGaZhcjxGQ5LttMr1xb+YBcI8yJLxVRlmcr
         IFKWy7YwXTh42ezIhrp58k7UgipMJTcxMK9PE3NftY5n7fDddIBqRu5Unu3py2l6ze
         NBVJK9mxhEOjA==
Date:   Tue, 10 Oct 2023 09:48:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Josua Mayer <josua@solid-run.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [v6 0/4] arm64: dts: freescale: Add support for LX2162 SoM &
 Clearfog Board
Message-ID: <20231010014812.GF819755@dragon>
References: <20231001103259.11762-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001103259.11762-1-josua@solid-run.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:32:55PM +0200, Josua Mayer wrote:
> Josua Mayer (4):
>   arm64: dts: lx2160a: describe the SerDes block #2
...
>   dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog Board
>   arm64: dts: freescale: Add support for LX2162 SoM & Clearfog Board

Applied all 3, thanks!
