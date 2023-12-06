Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203A38064D6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376606AbjLFBvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjLFBvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:51:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA399A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:51:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DC2C433C7;
        Wed,  6 Dec 2023 01:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701827466;
        bh=7jRfIVx1+60KM935PoKkTUIodP1pufhXRHS5Rlp+FW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIdpcWOllhXxTR/G5ouwXAyVXNHWhwo0A19JvSVSFtmLnXebORW/Km8I20VwTxb6I
         z3AVduKX6EvBk6Peq1VtWm0TK6kdHQnUiC4puaQJZuRb9lUx+rZmmqFw8syiDGtD7h
         ZY7UH2xBGGKCYIrlHOWgYgJKaytveZIjbPvfsuWRbG4qVsV/5KJ2pBgOp+pJCo1ZMi
         bg75GlBRgBunXi4VYcALBDbSlCF1WmCxlf3ob4HomQm0OOLHsUEpgsk2Kx+fsvnThP
         FP6vk+xtHpcEt7C90SNvUnXs42YVNoAplCjnU1hQ15420t8CvWW1NYsnczZr726nHE
         DhOWMO6DSuMog==
Date:   Wed, 6 Dec 2023 09:51:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Li Yang <leoyang.li@nxp.com>, Stefan Agner <stefan@agner.ch>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: nxp: minor whitespace cleanup around '='
Message-ID: <20231206015100.GD236001@dragon>
References: <20231124095104.58772-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124095104.58772-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:51:03AM +0100, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
