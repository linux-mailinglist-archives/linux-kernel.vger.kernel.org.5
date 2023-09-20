Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212607A713F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjITDzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjITDzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:55:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905EFAC;
        Tue, 19 Sep 2023 20:54:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C88AC433CC;
        Wed, 20 Sep 2023 03:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182099;
        bh=YB1y3YniIxZUraElg8KLKmN9/py1zDRKyK3VJvniHUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUtdB3FCt8kKOfOzoJCZSG932f9J6RIhulw/mzyxqdgrP5FM+3ULM56SHhXcn46zL
         4kOhSES1l8yA8QhCwJULmrs46eAAqX23eRRE0tXcVr3RRHa3UxmCynz0gI+jX0hzNG
         G0vceT5CO01PtfRaHIXE/3iHwLFToksZTGEvnholFluXRSAxgR9dzu/59aJbbXGIv9
         mjZyEBj8dxsObjYIYTX2Ob0niHWW6NPid3PMNj3wYPTbYB6G6RuSvzF+HOnFpNEG7c
         /RVz8g2HC9XUWB2Aehyxdi2CF4UNRatm1nKbSD8RDTBf+o2qDxkm+ei8cWBkI+4Urx
         uvn5usbVdnWCA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm670: Fix pdc mapping
Date:   Tue, 19 Sep 2023 20:58:50 -0700
Message-ID: <169518233712.1055386.17785713559908049172.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org>
References: <20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org>
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


On Fri, 18 Aug 2023 13:19:09 +0200, Konrad Dybcio wrote:
> As pointed out by Richard, I missed a non-continuity in one of the ranges.
> Fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm670: Fix pdc mapping
      commit: ad75cda991f7b335d3b2417f82db07680f92648a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
