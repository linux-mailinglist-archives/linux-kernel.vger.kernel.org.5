Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED327ACD50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjIYAwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjIYAwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:52:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7EDD3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:52:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F118C433C7;
        Mon, 25 Sep 2023 00:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695603126;
        bh=onvI1Fm9he2xc7lcLVjPo1DMVfrsnVpk+nVaTkzpS2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lvv04zhCLtXR70ozqhgwEHI5reyK99WoeKEJAF4eoLui/LTkmIGRGKXgmLjXOF8ZI
         oBUWgfediUspCEZHecw8HzajpEsCA+SeaGKSzJKhQoja5cKz3uFz7J9jMVakaed6vV
         1Zp4CsMKDlLMw2AEHAgT+3jwPlVbBOpTLPwijNWd/Fx9y96ga/Ap95MSzWWj3Ep0MM
         hCH1QdmsFMmGPipYKNYN/BuvDz79he5jEeH/XTtBCMIo6RvyjNnYY0WWofQCkyoRqX
         eyqGyr31c7yjnUamuegZe9fmP7liUi+NhLSXR37gjdawRXKzfjmh7aSHIRRsiT0x1l
         tDdA/KWfLMOGQ==
Date:   Mon, 25 Sep 2023 08:51:55 +0800
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
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: freescale: imx8m*-venice: remove label =
 "cpu" from DSA dt-binding
Message-ID: <20230925005155.GZ7231@dragon>
References: <20230828192741.1202218-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828192741.1202218-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:27:41PM -0700, Tim Harvey wrote:
> This is not used by the DSA dt-binding, so remove it from the devicetrees.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
