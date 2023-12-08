Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A2B80A640
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 15:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574143AbjLHOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 09:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574092AbjLHOw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 09:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24C212C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 06:51:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD1C43391;
        Fri,  8 Dec 2023 14:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047093;
        bh=ilm8bRNtzJLA54Zj2yn6UjdZz9VCFVwyXwI43qcyg7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMtssf5Eex2g+o6RdbZl97u/QLg9hYcZQQn7Fpp5/7E4B+k98xgJdgoEYeQ9iWWLD
         mycw+sHrqlFvwlGekAzcSfB/DP+tzLA3ZUeN+wRK04aVb4JzebQnuBmQolitptxdQp
         CDZHMKojROPLJ1G/Wo3qddS/1zhF6B5sOeA9pRNfNmxRC4kCMe7ZZRguCjE3M5Wzuw
         1ShEMet4EVft82/n01sm3UKIvMaE4m8TWcEMi1VrX7ERsvk5+gSh7aZi2Op6Mcx4no
         RElfFkZxCBhcGJYKzw5t80302JdRsOiCQAX3I5oTFPznaSNMM49fF5lBBfjQsa/JVu
         H3FA0L1Puazmg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: clock: qcom,gcc-msm8939: Add CSI2 related clocks
Date:   Fri,  8 Dec 2023 06:55:39 -0800
Message-ID: <170204733614.342318.15697921791345644925.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029061948.505883-1-vincent.knecht@mailoo.org>
References: <20231029061948.505883-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Oct 2023 07:19:47 +0100, Vincent Knecht wrote:
> When adding in the indexes for this clock-controller we missed
> GCC_CAMSS_CSI2_AHB_CLK, GCC_CAMSS_CSI2_CLK, GCC_CAMSS_CSI2PHY_CLK,
> GCC_CAMSS_CSI2PIX_CLK and GCC_CAMSS_CSI2RDI_CLK.
> 
> Add them in now.
> 
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: clock: qcom,gcc-msm8939: Add CSI2 related clocks
      commit: 3f373de6da2c960f0630a63890dded7d53358e2a
[2/2] clk: qcom: gcc-msm8939: Add missing CSI2 related clocks
      commit: 8f799d304c313f6628c4b21cd0227ac56b581944

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
