Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFD7AED79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbjIZM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjIZM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:59:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D21B6;
        Tue, 26 Sep 2023 05:59:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A916FC433C8;
        Tue, 26 Sep 2023 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733160;
        bh=z8o4JuRpxvSYlgwJN2Va3OBMKYGSPZHqX6/S5fP8NVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WWYQDLeU8GmAQQVkF0jWCN5ImPSm72s5bYbooHrHAZ6QhmFNvtcAXswFcoN2rpYA9
         QDGYhFnniYjMx/UqdEVwM+KElywaxLDPXcoElwHkJqPqKZ+FATW3/UpyYj5Oh0uPyU
         i1uhfp5KCnWTIOiccDCUdeesoMMYqrq4PSri1rD7oLfGOSLAwtkojehZqfTL8dYTKa
         MuyY/Gjb3IrhpqCTyPeh0MTZQSE8NOSTB1x6MrFoX8sRwdFzQ0qfBueh4iCsF/FOjo
         2EUtGe9OYuxfvikRwNZjisvWp133Nv8ceG6tmeXSvlEMmXrgQdebDIvo7eZmd1Wn7J
         dHWfDPFlGBr8g==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-rockchip@lists.infradead.org
In-Reply-To: <20230925212614.1974243-1-robh@kernel.org>
References: <20230925212614.1974243-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Make "additionalProperties: true"
 explicit
Message-Id: <169573315641.2623557.2641052084011389770.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 14:59:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 16:26:00 -0500, Rob Herring wrote:
> Make it explicit that child nodes have additional properties and the
> child node schema is not complete. The complete schemas are applied
> separately based the compatible strings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: Make "additionalProperties: true" explicit
      commit: 9f778f377cd3b8d6699025ea75732ca91a239cd1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

