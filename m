Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385D27E9E13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjKMOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjKMOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:05:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B35D73
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:05:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7504C433CD;
        Mon, 13 Nov 2023 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884334;
        bh=6scqCP6KmruB1FI722uEIB9ZpX+PcxEvio8fakOFAAs=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=OkhPOVvZL0e1+6pkDkC6APCiOoT0QgxMKALIXRTsYat/zRx/6GhgdJAbvl1rRAjfF
         MyzIFpgo262OPgoOcV31zr6ClN2eZvZwF2mnc6vnPVevUYpk9u3fh1KDhGzgW89/aJ
         xtMsCZKzvJkfr2rLK/iGu8VJkermAwCYGLUsHNF/b+la7oJT/LOkTRmBhjyk6JuX27
         pEt+i9AOLvDMCRr7U5o9QLL6yFa0bDJoPfzCuFLcHX8nOZEC73lvzBrjEIGyexGV51
         vJ+uOEn2RkJMw6ZXFJimhZDxLUdXUh3IlO3SbN9ZUi0HBbrsY1fN2akwAPC4lAAe5q
         e5qNgMX0h2aZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231106180422.170492-1-krzysztof.kozlowski@linaro.org>
References: <20231106180422.170492-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: qcom,sm8250: add SM8550 sound card
Message-Id: <169988433104.3280890.1283507627992945147.b4-ty@kernel.org>
Date:   Mon, 13 Nov 2023 14:05:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2023 19:04:22 +0100, Krzysztof Kozlowski wrote:
> Add sound card for SM8550, which as of now looks fully compatible with
> SM8450.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: qcom,sm8250: add SM8550 sound card
      commit: c239b79315167d3e9b4b1e537b00e1ff5b87a317

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

