Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDEB7A6F07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjISXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjISXDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4341C0;
        Tue, 19 Sep 2023 16:03:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C80C43395;
        Tue, 19 Sep 2023 23:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164623;
        bh=ivEhs/zpi0JLldx/NRni4lu2jJS2PyalHVCowMrgpWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLactDbzMUkpRGeo3wUh/yX6l3F1Z+OP9F0+eHgseBYs4+6x3+3h5S1kIgo++/u+R
         aBBugArR4+j+/jFhbNpxf8w5voA1wySejdOqewHie3ZElY15etSd1RYyf2nBHozgNj
         DQyw24Km7pMwszPD54CgijbfsnHF1Cnapdk3yR7QcRJA4Fr0UQfwsSRv/Z5zk2Qv+R
         gsOceD1Tkypi4GNFr9GXOSbV/vCMW8TLyr1oWeXGQ/uUWHYiBioQ49HT7ahNOivmH6
         nWNlA09r714Axoezixs3n9B1SxXvH5quKfRT/wvNiIO5XHIFSS/m086nZqXjYSbhpO
         mSvAAHUTclQ7g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 0/3] SM6115 LPASS TLMM
Date:   Tue, 19 Sep 2023 16:07:33 -0700
Message-ID: <169516485994.787935.15338594127555472104.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
References: <20230722-topic-6115_lpasstlmm-v2-0-d4883831a858@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Jul 2023 13:39:55 +0200, Konrad Dybcio wrote:
> This series introduces the bindings and driver for SM6115's LPI TLMM
> block and enables it as a module in the arm64 defconfig.
> 
> 

Applied, thanks!

[3/3] arm64: defconfig: enable Qualcomm SM6115 LPASS pinctrl
      commit: 2f98ed431b77cbaefd75f9690a671c5fe3c9c479

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
