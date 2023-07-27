Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D17659D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0RQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjG0RQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEB330EB;
        Thu, 27 Jul 2023 10:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF3461EF1;
        Thu, 27 Jul 2023 17:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A4C433CB;
        Thu, 27 Jul 2023 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690478186;
        bh=/h8WTc7ffM2/OK7+VjlH18R26PhyR6KOVEkzXTCV5+U=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=HVHZU8mxKfMxdWLwjnggTMuODXoZ/0z14Pv+ML3/RI5yA9PIGscEMluf7ltc9ctRQ
         Q+H0JwK6D9ynUR9eIDGigu7C/STY5kh1WOsOMI0AmMXBSHoQTqtoytsnq6099R19si
         wYlJRaDXBu34joWB1u4GSc8aIZVbAPr6oRRYKJEjD8nM63P9E3jpR0b4/S5+dMLbrE
         9e58JPeFNmsS0BK4K7myh7ULjrpqkayx7ikZwBeUYJF/Ftdqag1N0ZPPyXf2ZuDH3Q
         YJiowB2dBDv0CJ6m+9mLOWhQ/TQ7mJsy2RB8wENsyWAmxukN6bNHtGRAOQ5bwuRaMn
         2zFDDzmYik5/w==
From:   Mark Brown <broonie@kernel.org>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Jeong <eric.jeong.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727085434.16596-1-krzysztof.kozlowski@linaro.org>
References: <20230727085434.16596-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] regulator: dt-bindings: dlg,slg51000: Convert to DT
 schema
Message-Id: <169047818411.132925.12507293568862505459.b4-ty@kernel.org>
Date:   Thu, 27 Jul 2023 18:16:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 10:54:34 +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for Dialog Semiconductor SLG51000 Voltage Regulator
> to DT schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dt-bindings: dlg,slg51000: Convert to DT schema
      commit: cfef69cbe3726c095f55769bd0e7c72f32bf5060

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

