Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CA7B2F0C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjI2JSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2JSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:18:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C08411F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E219C433C8;
        Fri, 29 Sep 2023 09:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695979099;
        bh=sSE2ufPYYysKrqreHDDK6x2F7lHFW9wHus1rU5Gyqa4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OL7Z9t0eGVsDSZPFGnlt09R/M6FKqLC+BNINqQyS273SmJtKHDd7hncmOQ3Hz2mm1
         sqwfWYo2xUCS+ThqHPjVQ0z0OAXY7a++BMPrWZMWc6o59LGZfMDrPmB0V8SRh4LK6s
         oWaE8PDlDyxGaFtH0kaMwOEczo26uNKrhypDbVhJPCQRtjeBZsK1885SpjhDB/M6qn
         xJD5wi0NEQdSWtOzjoTpXqpUFO2TBzkaanViCpM8r7wDYPBTwHsuFKm/d87Bg4sMZJ
         OxO38KYtoJBUHzxKxeKISDQ2OuGns38N9UKXP40dK0l2a55wrtqlF1nAgXoEn2sgfZ
         s569bjJS3Y49A==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230928194126.1146622-1-robh@kernel.org>
References: <20230928194126.1146622-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Simplify referencing
 dai-params.yaml
Message-Id: <169597910032.2796594.13616316041876097635.b4-ty@kernel.org>
Date:   Fri, 29 Sep 2023 11:18:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 14:41:16 -0500, Rob Herring wrote:
> There's generally no need to use definitions to reference from
> individual properties. All the property names are the same, and all the
> defined properties are used by all the users.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Simplify referencing dai-params.yaml
      commit: 967dad97757057dcd72ec27cdb3c14c1774f606c

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

