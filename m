Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DE57B6F46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjJCRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjJCRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:08:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA5B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 10:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA139C433CB;
        Tue,  3 Oct 2023 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696352917;
        bh=c2Amx6bwFllppZWhw8zB9Zq4+W/JCoESVGF4gZggaYM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=njLVv3nX1o4MOD24uGsN7Q7lYhGER1gt6o5JaKCzoD2RF+azLcdEq3jJe/a0bo+DS
         GwjuQWcBBMntcj4AqIbunDSINJ+FcHshd9CAUddVntBYT9GD4bVaqE0QRNzm4zSEkz
         GcCVWVgMmw2V4A9dUm+5u7AnVzRnQ1b+cXiroCAW6Vl5vcdY2ljb/6rWsWhNku1PJK
         2ETgSSCrmT8zIGz+6dJ9aBpkB7HuIvsncZ+mjS54I5ANomltyMGVdPx1qm800sGRNn
         QTCHPIgZ73ZMzNqm6iHgBJdTnJmAo/hFK+orPDoJEWigTWDPv38Gh0kP8HGeednneS
         z19ntSi8Kapug==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230930165050.7793-1-bragathemanick0908@gmail.com>
References: <20230930165050.7793-1-bragathemanick0908@gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: rt5616: Convert to dtschema
Message-Id: <169635291560.42044.12417015204070109267.b4-ty@kernel.org>
Date:   Tue, 03 Oct 2023 18:08:35 +0100
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

On Sat, 30 Sep 2023 22:20:50 +0530, Bragatheswaran Manickavel wrote:
> Convert the rt5616 audio CODEC bindings to DT schema
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: rt5616: Convert to dtschema
      commit: 943bcc742ec4d7da4d26477f2188940ecad76569

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

