Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA747A0A16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbjINQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241480AbjINQAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:00:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36051FDA;
        Thu, 14 Sep 2023 09:00:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0770C43397;
        Thu, 14 Sep 2023 16:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694707242;
        bh=nva7i1S54ZZ/9UJ1D4q1kOnH0iOUc6EYuYwDhqDhiz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmvQmwbVVJgBBH0c86gG8tu0zTFZcqGxxBxnmhRV9EJHfTmW6iLRt9dCYdIhJgTPm
         Sw+b00pjsgGzaNor2YcVCJwiXss5oNacIzHBRMQAJeTPtqLWcVq441GtEMviDw4UtM
         6KFMdLM8c6Nor0dYjPrXvZ3GWfrygj3Se1KnP/Um6krEBSw77Krgd/TzBK/Lvpj+tL
         egTVUq5xsllMlvG5JUlV4um6MU+Q21XaJZt0yYV0BFvfKQ4fJjfzJ9WvXRc6TTrfjz
         rNkYS/PNij8fZIFmm0wwcg368pJkDshvUtE/8KH3Z+pgtf+c0309GNaHbpdwuMpCiQ
         u3uBBmlUm4U/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] arm64: dts: qcom: enable BT on SM8550-QRD
Date:   Thu, 14 Sep 2023 09:04:30 -0700
Message-ID: <169470744882.681825.10529565332880290244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
References: <20230911-topic-sm8550-upstream-bt-v4-0-a5a428c77418@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 09:28:45 +0200, Neil Armstrong wrote:
> This serie enables WCN7850 on the Qualcomm SM8550 QRD
> reference platform.
> 
> The WCN7850 is close to the WCN6855 but uses different
> firmware names.
> 
> This patchset is the followup of https://lore.kernel.org/r/20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org
> with only the DT patches.
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550: add UART14 nodes
      commit: 75cac7090298978c12c59dbca377d957f6f8a8bb
[2/2] arm64: dts: qcom: sm8550-qrd: add bluetooth support
      commit: 1cec289a3ced45b7f4a5e136acd79e401167c1ba

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
