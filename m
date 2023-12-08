Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACC8099EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573045AbjLHCzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573123AbjLHCyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:54:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8141987
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D0CC433C9;
        Fri,  8 Dec 2023 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004026;
        bh=Fz0tiY104hQ+SP9PBMlxjLEbkXLArrk6DRdKJTOJeOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLWt3ca85Zr7bkNYtm+NUwtm8tt0OoEMCf5kiWXQNHe5nj3XZCYTIaCFHwLt9Ussi
         JvuhJiLI85KRJSbkw28pRC5PVZ09JsLU0t1feTe5hhcWBAb99s0v18JVGfS24eCPfi
         2ASzi4czvDvwD37vDC6PIq48HPtmQ8p9K8pQDsHrP1WdeO8QCp5szd9R7h+MyyAZxI
         ZNKlw6lLRRUJkNEMkTwOy7X7enlJQKnJrftXVjFxEj+eKTChwUOOOnkF0SM8f+VSio
         0GeXFyECe6I2KyAKZ0YMZM17AHbR8y9Jz22EqAZ9crcTCflA7j1lJGDk/1cefSk/pi
         9ZVuOBAOEXEWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, lee@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8250/sm8350
Date:   Thu,  7 Dec 2023 18:57:50 -0800
Message-ID: <170200426910.2871025.1931459275540622967.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com>
References: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com>
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


On Wed, 25 Oct 2023 22:36:38 +0530, Mukesh Ojha wrote:
> Document the compatible for both sm8250 and sm8350 SoCs.
> 
> 

Applied, thanks!

[2/4] arm64: dts: qcom: sm8250: Add TCSR halt register space
      commit: d59653233e8779e3fe082eb5635b9785f2095af6
[3/4] arm64: dts: qcom: sm8350: Add TCSR halt register space
      commit: 1accc6031d925c6045c4776d5f3646996b0b242a
[4/4] arm64: dts: qcom: sm8550: Enable download mode register write
      commit: 44b1f64cad5703c87918cc9ffbf9b79bb959418d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
