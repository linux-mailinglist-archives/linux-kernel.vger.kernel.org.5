Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6D58064D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376649AbjLFCGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376398AbjLFCGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:06:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183C4137
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:06:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EE8C433C7;
        Wed,  6 Dec 2023 02:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701828416;
        bh=2PnunHshfH2jdMqvDzbdFHu7hocNX8uyz8ujGPuP5hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQUBRNm0tvayYdIJGrcFeVcsVGA+5k4lYxvOM68JzH8wV27tMvNhcL5/g3UXqWQP4
         XtV1RHjqTKsGMXV05Uk1aWKIEADWreaEuixoFNNSaff0RKnxzdE8ykvGkyaiqluOBg
         pcpY4vJxSq4Sjv/nTDTcYGYM0jP8SEv8RGAI9mXz+TBHrQaCenE9bofS0QmMlkgSnQ
         8UKNs1ipTyqa1NeBQa6JMwCNoMUpf0L0ksDyQEdVhED9CJrghRJf4iruWGPGOIJ+JN
         peEnLPfYqizC2HwsMCk7uddePecfouDxw3a5E9mgUuIwJbHKDEk2HgJTBgBS5ER+2V
         WkQqp4LoyA2xw==
Date:   Wed, 6 Dec 2023 10:06:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] ARM: dts: imx7s: Add on-chip memory
Message-ID: <20231206020651.GI236001@dragon>
References: <20231127-b4-imx7-ocram-v1-1-430a75e3e9db@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-b4-imx7-ocram-v1-1-430a75e3e9db@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:15:01PM +0100, Roland Hieber wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Add the 128 KiB on-chip SRAM at address 0x900000.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Applied, thanks!
