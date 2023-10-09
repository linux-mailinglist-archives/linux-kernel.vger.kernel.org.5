Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1197BDE67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377060AbjJINTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377045AbjJINTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:19:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB8AB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:19:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83898C433C9;
        Mon,  9 Oct 2023 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696857555;
        bh=ztzncHnGPFaPWuZ166bpyDahB+29GvIXPBNg+KvQPI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=siAKZGFd8OFJLn+c/32SwXUR4Hx8Pajh6djGm1/bF939ysjVWnK3Z64idYws56B16
         5upm0yFH4ohdS28CRPO9cg6yh5hvd8XCdMITblPEl5dyHpEufcXt0xWLyJTSE+omGW
         lM5Jg0lDgS1brK97Js84L14ovV2QoTVIRLVyXYG3a1esYYyp3J0YATYiOyZDWhco/Z
         YkQlR4bTHoPUTUUrW8gXrzg7XoL5bcSXLjjJu1rb5r5jFS8qmIWObUEfXbWMiBymBJ
         ngajVolOQOYMmbtuQJyjlvMzXTNB7UN3xDVGic0it4NOm9J4f0QWwLPnFMKni0L7Tj
         1UrvUTVgd3q1A==
Date:   Mon, 9 Oct 2023 21:18:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yannic Moog <y.moog@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/2] Add support for the phyGATE-Tauri-L IoT Gateway
Message-ID: <20231009131856.GB733979@dragon>
References: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925-tauri_upstream_support-v2-0-62a6dfc48e31@phytec.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:25:17AM +0200, Yannic Moog wrote:
> The phyGATE-Tauri-L is a SBC that uses the phyCORE-i.MX8MM SoM, but has
> a different carrier board.
> This series adds support for the board and most of its interfaces.
> Notably, RS485 support is missing.
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v2:
> - change license of tauri devicetree file.
> - fix devicetree style issues, no functional change
> 
> ---
> Yannic Moog (2):
>       dt-bindings: arm: fsl: add phyGATE-Tauri-L board
>       arm64: dts: freescale: add phyGATE-Tauri i.MX 8M Mini Support

Applied both, thanks!
