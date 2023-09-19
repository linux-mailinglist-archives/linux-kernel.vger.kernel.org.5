Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2607A6F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjISXDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjISXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:03:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC66C5;
        Tue, 19 Sep 2023 16:03:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA70BC433C8;
        Tue, 19 Sep 2023 23:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695164621;
        bh=nnYY7JEJ7bFSMtO/wZJytTWM6LCJzG6A9H+PGbDlH84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dka5hH4kX9w5iZs5TKRfVjW9O8Fl+15LcYDCF5x+oiHQbbmVRUFKiYpQVIaHtV/MA
         KcGPQhKahtC4Yf378ZMZa5PQl3IJytw7o/g5wY+TJBEHeW4w+Ty917kMKGl+6lqPHH
         hfS9wxzjvIfFuxxrXCkDFEwoGewJ5JoFL+gMDT1eYmIP4I1pUXPQFSlk6sKOg111ib
         JFcqSi4EgSH6iSPgb88bQ72DjIXQyTPR1W9+DRP0kEK00btR/4EHmqr7yoZDQEncx3
         YxxyNLpX4LmbLFTHHyPsDXbvrljNuRiE0OkqmIn8qxL2NecFXfJRQK/vHTczkDIV87
         hI8wNaIT9vXGw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] arm64: dts: qcom: sc7280: Add missing LMH interrupts
Date:   Tue, 19 Sep 2023 16:07:32 -0700
Message-ID: <169516486002.787935.10123239154326346450.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
References: <20230811-topic-7280_lmhirq-v1-1-c262b6a25c8f@linaro.org>
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


On Fri, 11 Aug 2023 22:58:22 +0200, Konrad Dybcio wrote:
> Hook up the interrupts that signal the Limits Management Hardware has
> started some sort of throttling action.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Add missing LMH interrupts
      commit: 3f93d119c9d6e1744d55cd48af764160a1a3aca3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
