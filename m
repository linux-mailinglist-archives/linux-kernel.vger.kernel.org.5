Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7D79D92D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjILSxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjILSxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:53:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E92B106;
        Tue, 12 Sep 2023 11:53:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C397C433C7;
        Tue, 12 Sep 2023 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544784;
        bh=42xcdlbrjyVky2/tm5xi0r/vdFecT+EUTCaruqGYrrg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tnBXOzns3TRJQ3v2DIWxovHmqpLyVkrdcfa60aU16eqotefX6AAO9ny+VhyOzVTwa
         vMVlIV1+6hNvf1rt+deYVUX7gXM9V9QdeaZOgSX9LLWJ84wCPMzwus4JETKqLHDFie
         tNpBDpsy59MWbR3IhREh716peEmbR1aCuxc7C1wfvSsRx7qe3ReSzhUFhI9KWrnQcp
         vhq3FBdz78lg7Sj/1q4JyfcVMiyyQqFfkbDnkIETWv8F1/V1yLvzVcL9nkwoSAgdfP
         Z2sb/yqMAUcJnQZSl6mp/qwECmAcbPMIC3tcTyLmmNv/UdA30S0hVPhkz0BS7PcLom
         g6rQL+BgRt33g==
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
References: <20230825-topic-6115tx-v1-0-ebed201ad54b@linaro.org>
Subject: Re: [PATCH 0/2] SM6115 TX Macro
Message-Id: <169454477946.2415953.15150744982318349138.b4-ty@kernel.org>
Date:   Tue, 12 Sep 2023 19:52:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 19:23:11 +0200, Konrad Dybcio wrote:
> Like most Qualcomm SoCs, SM6115 has a TX Macro.
> 
> Only some minor changes were required.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,lpass-tx-macro: Add SM6115
      commit: 9ff143aaabba989f275612de0d83cf9d39274828
[2/2] ASoC: codecs: lpass-tx-macro: Add SM6115 support
      commit: 510c46884299cf8da8e9d7db27572eafa9a0c567

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

