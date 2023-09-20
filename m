Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2A7A7134
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 05:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjITDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjITDy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 23:54:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0858B9;
        Tue, 19 Sep 2023 20:54:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72111C433CA;
        Wed, 20 Sep 2023 03:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695182093;
        bh=GXSUaLuNK5r0XvwfaHFTrr+dslJlUGIbM/d+lmdmSAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sjz/B+LMt+UIfdCK/yDaa1GHCRDeQ2ECYbFeeu1CZdUN9HL2Bh8B7KQXfnMg1qhGJ
         ntID01kvozO15BOnTMXxOXfnbpa7oygg3F159pn5Klt6nFZcGqVPSuf0R1JTEFe5x3
         DCRernp3wjLBZHGR/4CfBkedOxR/GOR2v7aUWFJgTEA4jOyA1fKzZgFnVriPZCTOIU
         GYn5BVPi3SVwPxRH31X1s8qp9oohhejuOHVkTO+EEunNmm+xaGywOB592dggcxA0Xl
         U0LutQNOgSfKMiEnGIcQH2j5ZcW8htQu92qDvEPJ+ujqBe+PliS0im4Grl5MBPhkmj
         C8WPmYouYwonQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        David Wronek <davidwronek@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org
Subject: Re: (subset) [PATCH v4 0/7] Add initial support for SM7125 and Xiaomi SM7125 platform
Date:   Tue, 19 Sep 2023 20:58:44 -0700
Message-ID: <169518233709.1055386.6053331761982073486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230723190725.1619193-1-davidwronek@gmail.com>
References: <20230723190725.1619193-1-davidwronek@gmail.com>
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


On Sun, 23 Jul 2023 21:05:01 +0200, David Wronek wrote:
> This series introduces support for the Qualcomm SM7125 SoC and the
> Xiaomi SM7125 platform.
> 
> 

Applied, thanks!

[3/7] dt-bindings: arm: qcom: Document SM7125 and xiaomi,joyeuse board
      commit: 9b4adf37fdc0ca8cd1d14b4160e2f04b63df98e6
[5/7] arm64: dts: qcom: pm6150: Add resin and rtc nodes
      commit: ec053ec90c245a4efc8dda87d9207de0adf0040e
[6/7] arm64: dts: qcom: Add SM7125 device tree
      commit: 72fbf05149bd451e7222c2ed1e3823972f19df9c
[7/7] arm64: dts: qcom: Add support for the Xiaomi SM7125 platform
      commit: 7d65d4b7d70fb9560ce9baaf4219fb24646bd578

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
