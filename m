Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2507B6A4B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbjJCNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbjJCNUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:20:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A75F4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:19:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841B1C433C8;
        Tue,  3 Oct 2023 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696339197;
        bh=bL/2RWcdfIs3uBPgbF0uigzU0E9baOJfVQtweOW66cA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=gzECuFYFB67U4/QV8U0/sDvcEva1Sf84KNvoRerS3j/7DAF81qoa2nMJI6e4EfFfF
         0Zkddvo2m2t3Te2gYMxksxAc81cTubgsjNXZb0DtLEt4H7nhc15BntmCEuRXysBluw
         myNuOy3UwOGNvwAnxUIHM0t1WWQhz2eI0WhHA3aIPWlL81WNJ50H8NBmeFxyPaPIz0
         xcpa1OgK26QjdvZc5QqKUtN0MKsI3C9wlabBJweHrICjwqfDNYSAgwYVo7qwmQ50e1
         CZPEIoCFcrm/QiJ+trSkBB+juv46OGfLf8xH1Kk/0OA7NTvfbuW+i81KbRwLDEpi6T
         XD1/QYTGP1MWA==
From:   Mark Brown <broonie@kernel.org>
To:     Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
References: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: pcm512x: Adds bindings for TAS575x
 devices
Message-Id: <169633919521.32637.15894077647457160748.b4-ty@kernel.org>
Date:   Tue, 03 Oct 2023 14:19:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 17:05:55 +0200, Joerg Schambacher wrote:
> The TAS5754/6 power amplifiers use the same pcm512x driver with
> only minor restictions described in the bindings document.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
      commit: 736b884a7b68c4eeb66dbf75b97c8ec9b9eeff7f

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

