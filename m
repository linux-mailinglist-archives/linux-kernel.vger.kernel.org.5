Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8F7F48F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjKVO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjKVO3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:29:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B689DD4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:29:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8380C433C7;
        Wed, 22 Nov 2023 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700663365;
        bh=0/z0t2JF8PlcN2JPqmU491oJkQrRrv5Qp/yEPfyB980=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=KKGgRVouTQCir2q60Kx3SSl85QVVMiPQzMZITMRG/7p3zyzRF6deLTUs2NnlGOfst
         wtypqY9zi6L5Ck2/AictC9PhHrnqlNqVcmjrhGbe2LBjtTlchCJ/soRHQafuIMnkDD
         GbKhXwRF8avjnWbk4WXX7Yqre9dlszq79bqr0WAYsROi8Gq60gIm/GSSg0LcJVefBM
         yIOWY2KFWYRCwHwxf22uprpYorRmNB6nBs9tF5LnBp0khl/5P67qAZGWpUQ5HQbVvw
         KAkdwgCNBwLBUAN3PWVPVyoP4A6a7CA7UgGQrm1sBKqOHSwJ8K6PhUhra7Yu9P3Rvt
         LOmDCHyX7f/DA==
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20231122101959.30264-1-chancel.liu@nxp.com>
References: <20231122101959.30264-1-chancel.liu@nxp.com>
Subject: Re: (subset) [PATCH v3 0/3] Add audio device nodes for i.MX93
 platform
Message-Id: <170066336159.2181401.18066539425902688042.b4-ty@kernel.org>
Date:   Wed, 22 Nov 2023 14:29:21 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 18:19:56 +0800, Chancel Liu wrote:
> changes in v3
> - drop unused compatible string in fsl,mqs.yaml
> 
> changes in v2
> - Move MQS device node under "/" root node
> - Convert fsl,mqs.txt to yaml
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[3/3] ASoC: dt-bindings: fsl,mqs: Convert format to json-schema
      commit: 9996cd782a602f2542e110e2a4035dd6627bd520

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

