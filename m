Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D827F9795
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjK0Cnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjK0Cng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:43:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7EC111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:43:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7679C433C8;
        Mon, 27 Nov 2023 02:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053023;
        bh=5z40dfgaEb6RQO8XoHtHaxIii3Z0u2135a55C6fTJsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bFwUiUTQY9U/ZnxDn76B8dvKypkeKX7cN1ewuYbQrYhmS01b+6PUA69E/sdcF0WeY
         ELpV4b41SbpxdQatiJEwKD8obyQjpmOWAPSZFCXaKnuS1XNaPvdBMkAmb3pPUI4BqB
         A9XySh9x57hnq94VjnQ3iAILlpKEamg15GkwGF+Mvz2RSrSjbdrTw1r8P+PLyLMCIq
         ogrdPtkjog7DVIDCEcbzdXDLOYLwYWjAMN6/TgMiGBCDY75zu1yBqzwjNVsKoZo4Pc
         wdOLVZde/2yaM/V2pG9f973WfYFEHX1FOIPdmASZIDGH7+yDM2xUlmN8c9p0fa+JWI
         LLEaVimOqcazA==
Date:   Mon, 27 Nov 2023 10:43:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw72xx: add TPM device
Message-ID: <20231127024337.GN87953@dragon>
References: <20231018180922.2164324-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180922.2164324-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:09:22AM -0700, Tim Harvey wrote:
> Add the TPM device found on the GW72xx revision F PCB.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
