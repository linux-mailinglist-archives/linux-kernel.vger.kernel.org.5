Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8368175A218
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjGSWkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjGSWkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:40:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6D2100;
        Wed, 19 Jul 2023 15:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC0961844;
        Wed, 19 Jul 2023 22:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B6C433C8;
        Wed, 19 Jul 2023 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689806431;
        bh=qrdWCQK214hl1LeQQAZG5WIyx6uTUdmIiR4IHkfdhLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXtznVOuaSYMubANpDEyplsjCDQ8j6R3XJw5Hz3AZezZKlHIMRHAMDaNWD35LrlB0
         /Tp2YO99xn7Eg0c8TMqVE8+YGC9oW3W0yDERn2sEzAykplZqrjBV9Vlpq0FyVNC/k0
         pulmEapILi3AamNmGrRX4H3KlrfEIS+qBgrBv4WAEnA9Cj13i3SxIYQ/Pi4O312qhy
         BxzZAB0XH6+ekitSAQr8EmyzfMQcjAqy1P8vOAlul60LRIkfG9AXYjJA7FfJRR93jJ
         BsG6iIBsk5XiKlMRgYFJoeBUiTwH76+RYEAFTxjJnbPLCzsdZNDvZpDXgjGAHT6Mg+
         0+JR2T4VXn1Hw==
Received: (nullmailer pid 900862 invoked by uid 1000);
        Wed, 19 Jul 2023 22:40:29 -0000
Date:   Wed, 19 Jul 2023 16:40:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     alsa-devel@alsa-project.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        CTLIN0@nuvoton.com, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] ASoC: dt-bindings: nau8822: Add MCLK clock
Message-ID: <168980642934.900810.16549122314642905552.robh@kernel.org>
References: <20230719124752.248898-1-francesco@dolcini.it>
 <20230719124752.248898-3-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719124752.248898-3-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jul 2023 14:47:52 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add nau8822 master clock input.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/sound/nuvoton,nau8822.yaml          | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

