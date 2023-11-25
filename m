Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3397F8A3D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjKYLhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 06:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjKYLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 06:37:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A1110E7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 03:37:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDB5C433C9;
        Sat, 25 Nov 2023 11:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700912230;
        bh=u3Ud7opf3X4nqSGw+IYKVKYse4XkAAm5XbEyGIYTOsk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=iIWVavDMX8IIeDCrFAW/9zo0uBiYVTpuBL154mdUZyTf/phmfF6G4/Nr/80KelrKX
         ye78qPsyZfB5pF1+3eooBB24/CtiTaA7i8tf1H4UFk0jYR8oaM+8iVF6a9+gmQlHym
         HNZ1p5+Z9F/8pua29v34JB4PplpeslfN6VCZ1B9BkgK3K8PAFzjnwwtzoArZFFjBSJ
         xoK8/T9rWaKH1INhp5+Fj6Czlgt8Pp7jZJ/pifmAw1wmv5RsePb3TUk/DGIeFlHDT1
         c/Hu4vxkMhsW4SJTeaw78VKNQ5gEVUye/ztPBUtc38IYrhIUH/cmJF6s4i9KeY0Hre
         MlsikZsY0euQA==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Seven Lee <wtli@nuvoton.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20231124083803.12773-1-krzysztof.kozlowski@linaro.org>
References: <20231124083803.12773-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: correct white-spaces in examples
Message-Id: <170091222492.2632109.16193424114633167533.b4-ty@kernel.org>
Date:   Sat, 25 Nov 2023 11:37:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 09:38:03 +0100, Krzysztof Kozlowski wrote:
> Use only one and exactly one space around '=' in DTS example.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: correct white-spaces in examples
      commit: 29b0b68f25ae6f9454c3e1c31b054595af0a80fc

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

