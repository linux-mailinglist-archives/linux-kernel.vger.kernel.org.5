Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576AE7F650A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbjKWRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWRQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:16:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453BCD7E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:16:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11565C433CC;
        Thu, 23 Nov 2023 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700759779;
        bh=Y/Uu3aDbe5RYcazWSJu1Y4R/Eztt9hVU2SQs2W4+78c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YoPrU2JS7HDeMPu4upQlU/qpD/pYUqQS9SWoTRpG2v1NggNz1jXv+k880M7lnfBel
         ppYf1zlobGd74Blu64PU004hGv6lrLiDTTAIbKI0P0hEVYZY+nOkyy+cLrFR+HF9bD
         wIg7epMwdt748PKcKQSY+s+H84mbpRkh8FUfHHfxy4S4OkQcI8BB5tuDFslSr9qAi9
         MyDh/8pUdtanfGuURroPfvoFypIafD9CpqM8fRazwzkCJUVrx/JHCIySrEseUoxDAh
         EBj5oiqAyMckbWsGb9f3M1vhHNbk0SewNdB6A8eDP+ViM+za0grEddMHbTg0d6lU0k
         xi4ylofeDy63A==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dang Huynh <danct12@riseup.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
References: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
Subject: Re: (subset) [PATCH v2 0/4] Add PM8937 PMIC support
Message-Id: <170075977679.1459397.15383633309594797039.b4-ty@kernel.org>
Date:   Thu, 23 Nov 2023 17:16:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023 12:34:58 +0700, Dang Huynh wrote:
> PM8937 is a power management IC. It is used in various boards with
> MSM8917, MSM8937, MSM8940 and APQ variants.
> 
> This patchset has been tested on Xiaomi Redmi 4X (MSM8940).
> 
> 

Applied, thanks!

[1/4] mfd: qcom-spmi-pmic: Add support for PM8937
      commit: 587fcef6762cef9f44eb1aadc294d515262e6da3
[2/4] dt-bindings: mfd: qcom-spmi-pmic: Document PM8937 PMIC
      commit: 2a7b788e2ee041ee8b96481952b3cf4bebed60f3

--
Lee Jones [李琼斯]

