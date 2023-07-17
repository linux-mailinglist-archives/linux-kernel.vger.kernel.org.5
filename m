Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43087558F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGQAs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGQAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648FCF7;
        Sun, 16 Jul 2023 17:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02B3E60ED5;
        Mon, 17 Jul 2023 00:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41480C433C7;
        Mon, 17 Jul 2023 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689554936;
        bh=M0mlkwz8SOe5ZDfFsPjiSlm8/FWG6j+oo9OO7qHgva8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDSN133C5A3hHxCUPwZ7NUI3DYjsqG7wasUD9+GPihdKxZlTO51uwWTU+2FG2Wl0/
         v7IgN3WwpVMCt9XMTYpALPPFNBob+6jYGSFfhhNsRpyVhOeJmkP8/pJE1yt3jpGj07
         U+vI6tjg+y0S/nbClIMpHhy2+a5l2YHUGd7jJmJoiLymk6YVL6CQsT2ItPtkfAQ9pZ
         evtGUbxNqQYVp/1wmUOdr3MlXivzG2C/rIVnxL/oXC50n0lLZLfMLGkMgekuTQhDi0
         25E2WG8ckft/5La1GGpNnBKfl5kn05kVOuZPM0/vFMa9Ds6CdN62z+CjXRbNuUaWLd
         O13auekdXAFZA==
Date:   Mon, 17 Jul 2023 08:48:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: fix
 imx8mm-venice-gw72xx-0x-imx219 overlay
Message-ID: <20230717004846.GL9559@dragon>
References: <20230609233521.3624808-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609233521.3624808-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:35:21PM -0700, Tim Harvey wrote:
> Fix typo in imx8mm-venice-gw72xx-0x-imx219 overlay causing it to use
> gw73xx configuration.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
