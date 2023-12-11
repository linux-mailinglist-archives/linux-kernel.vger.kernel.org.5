Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1E80D110
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjLKQUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:20:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD923AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:20:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A08C433C7;
        Mon, 11 Dec 2023 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702311610;
        bh=tgoKaQNovHS9RWp3+K6M2LkRytAhgXwHG6PjpqOenpU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IhwDGvMDayZhO/ouKOmDaaOJzNx/xwMIjs9YhcTCcKs+t6IObyGFBnqQRsygnWr3/
         g8LzhS5VFgM9/a6Dce6Uqb/y5hcsD/2R2ap+NbMQGlvJjQLhjbPNJhppNcVSCciB/p
         YDlLzd8uaya95w/+DaKbPa55aUs7hW0YF1bx49uOY4HFCG7BbjKNGpN808LQ0EZOnP
         4FgU7ocVEVgoDDxqI0DE5Uf5KKImlv0jsMu9OZpuxGPCCa8fAL9Hsk1uTR67sGVzpr
         pRSmAieOqPpI3s4IwjjaxlyX31RaEMJa1bdhhOfpeERwX+9iNrSoCpHy+3JQU9Ish3
         f9k5ov4vq0YYA==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
References: <20231129113014.38837-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8650
 LPASS RX
Message-Id: <170231160677.85457.6870068020415164910.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 16:20:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 12:30:11 +0100, Krzysztof Kozlowski wrote:
> Add bindings for Qualcomm SM8650 Low Power Audio SubSystem (LPASS) RX
> macro codec, which looks like compatible with earlier SM8550.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add SM8650 LPASS RX
      commit: 0bfa20b18acbcdd133d41e04e07a2d78bcc04bc5
[2/4] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM8650 LPASS TX
      commit: 5a5085c9ce381f92399c755be6deaf1d76ad57e8
[3/4] ASoC: dt-bindings: qcom,lpass-va-macro: Add SM8650 LPASS VA
      commit: f243ef746d0ace20fe092fc1ee9987ecf003f7a4
[4/4] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add SM8650 LPASS WSA
      commit: ab8921e1da8fdca14192c44775151f50c1cdb763

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

