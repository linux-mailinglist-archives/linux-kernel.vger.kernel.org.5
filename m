Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9CA8063A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376346AbjLFAt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjLFAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:49:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA37C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:49:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50153C433C7;
        Wed,  6 Dec 2023 00:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701823775;
        bh=pUu4T3RbOJaOKyAMtNvfnPVIR42cAMmezEVLe9JyB84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHTIQAtRxJiPRpOd2KeyUjX5PjjvR55c5TBr2iQXmoa7iz7uBueLGZKKzV0hleHO0
         mT1dYbxsrbxBmFBVBjjCmyk1snX2Yjfl1qthNlLJ4pnNLbj5gmgKfRX5MtMu+SfSsd
         //58K6OvzCzM1gbAR2zxQs71srtrpgkznfdVBa2xj6u94Ijg9y9SAWI+CVmUx+sB/N
         IZIS81OUlhpFdAY6YGJoycTqCMqLwoMXI1UuY8nRiZrJOis9+DedAqLgX7WxJHim6u
         CLZpxac3v7/djnrJgcSVp/Tlbr9F2Fb5BgN6j0nCY3PB5pfTZb7/3aN4n8EdD/JhFo
         RP5peYgT0r7hg==
Date:   Wed, 6 Dec 2023 08:49:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, leoyang.li@nxp.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v5 0/3] board: imx8mn-rve-gateway: add support for RVE
 gateway board
Message-ID: <20231206004928.GJ236001@dragon>
References: <20231205150814.344883-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205150814.344883-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:08:11AM -0500, Hugo Villeneuve wrote:
> Hugo Villeneuve (3):
>   dt-bindings: vendor-prefixes: add rve
>   dt-bindings: arm: fsl: add RVE gateway board
>   arm64: dts: freescale: introduce rve-gateway board

Applied all, thanks!
