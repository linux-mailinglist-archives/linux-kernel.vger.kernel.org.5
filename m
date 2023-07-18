Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C127572B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 06:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGREDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 00:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGREDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 00:03:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB39197;
        Mon, 17 Jul 2023 21:03:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB0656143D;
        Tue, 18 Jul 2023 04:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812A3C433C9;
        Tue, 18 Jul 2023 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689653027;
        bh=iXm0IgXmMG4Mov+gaJuhgaz1mS49uydJisSlUErZcrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uf/Gb0miwK/v91Z/N7uyZUQew/4aSqp/oag4+MD/yHYgyB0x2qAq2856XcQDCs1LW
         sGrlzhD28EKc3jiyUYmVTrBmQI1XfJUxBJNm9tgBrB8BfKBnmzdpkmikZUY7R3TtIm
         oUAf4X6ihdtMv+sM+88BnOpB+oH9Rm8uKr3cbfAVzytwvUfeDBR9ECU/1trg384En2
         j/wtq2GcOFMOs/mqShPMkIacSjEcrU6BYOmYNrrnMUYpwV1+aa2ahtBCUG9yB6gZua
         Z7Fzlwm6n6P/jlracGxY1nqyL/pDyvlAcrYrmvxSl1Xt+VU2JWC4q1Y4gl8L8ZhGK9
         4ek59bX900UAg==
Date:   Tue, 18 Jul 2023 12:03:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx: minor whitespace cleanup around '='
Message-ID: <20230718040335.GI9559@dragon>
References: <20230702185149.44212-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230702185149.44212-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 02, 2023 at 08:51:48PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
