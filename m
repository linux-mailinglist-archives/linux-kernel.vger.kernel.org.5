Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC4E75C510
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjGUKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGUKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:54:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F78171A;
        Fri, 21 Jul 2023 03:54:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD22619BA;
        Fri, 21 Jul 2023 10:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1711AC433C8;
        Fri, 21 Jul 2023 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936882;
        bh=P93rQLt+HbT+haMc2bru+0/BFEl6sR0r4+uZfisc2mU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=js9LRL8BYtSeSsiAGLiLTDDfDPpCKPqL1KLUgbQX/A1WRYTEqa8mTGuxe4UOm86Cl
         HD4NWCgGvwbVqsCLU5V0/znaqqcmboX9J9ubnV8C274sbysgmw0Lktq/pvAPfBhjt9
         lgeI2QP/vFmYexeHAHw8QwWPPIk6PFlgWPGYGFTf9bEzhDiikRx5+5NnK2aU3Hgb8W
         zxHa4JbMyEnak1R6F93bwxM+9R89l/L6Xlk/KrwGnw8zlDsBEF+7QR6uW6HqHDpY3E
         VLHt0Eb38FqriAOKSv/naBEUSwAwFMwuAlnQPae93WwsFhUPkRq5i9/D/JooU1kf4i
         EhmbiGw53T67w==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, CTLIN0@nuvoton.com
In-Reply-To: <20230719124752.248898-1-francesco@dolcini.it>
References: <20230719124752.248898-1-francesco@dolcini.it>
Subject: Re: [PATCH v1 0/2] ASoC: dt-bindings: nau8822: minor updates
Message-Id: <168993687980.20527.4752913856777924592.b4-ty@kernel.org>
Date:   Fri, 21 Jul 2023 11:54:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 14:47:50 +0200, Francesco Dolcini wrote:
> Minor updates to NAU8822 DT bindings:
>  - Add #sound-dai-cells
>  - Add MCLK
> 
> Francesco Dolcini (2):
>   ASoC: dt-bindings: nau8822: Add #sound-dai-cells
>   ASoC: dt-bindings: nau8822: Add MCLK clock
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nau8822: Add #sound-dai-cells
      commit: e8c213ca026d3cadbc306885ad1b37efab02c218
[2/2] ASoC: dt-bindings: nau8822: Add MCLK clock
      commit: c214131f492083025e33354430d5b420add88b5e

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

