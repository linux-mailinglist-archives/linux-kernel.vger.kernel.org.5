Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43437BA3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238971AbjJEP7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjJEP44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6FA5BB2;
        Thu,  5 Oct 2023 06:55:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FF0C43215;
        Thu,  5 Oct 2023 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696514104;
        bh=ruPafLxqiqN5GVxCe5nkJ2euYsptGUelC3r4B7yxjts=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WQz4G4yYnAdDDEo1AaWaMUeq+Ut8JXdSfJlNQcrG0O9WNOg2EptQ/FY/ZcdWUvTMG
         i3Fngj/gkp6CClxwXXLKWH+0xKI/IGpm3cg8WCvtLWM5xwmNt7wx0TAOKFJOzC/928
         VoNPrNPKCDAoqctzmVPhaRbjgre0dB7d0bpKvb/u3rDa+5EfIF1vSjUzFCthlVqHQz
         bdPlYV7e1P2sDeS7IAYcqyxA3hUL7NH1diuUHIAM/xis2VRjtNvljpYzVTwnjkzSC5
         IVmC/vjFvY+q0nmbauREp932iuThtGgzHx/YVkUKsQqFHfF6R2y3+FtDwQG6DrKYlZ
         on2FyWwL/MOmw==
From:   Lee Jones <lee@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002-pm7250b-gpio-fixup-v2-1-debb8b599989@fairphone.com>
References: <20231002-pm7250b-gpio-fixup-v2-0-debb8b599989@fairphone.com>
 <20231002-pm7250b-gpio-fixup-v2-1-debb8b599989@fairphone.com>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: mfd: qcom,spmi-pmic: Drop
 unused labels from examples
Message-Id: <169651410138.777767.3255528451615557124.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 14:55:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 09:00:11 +0200, Luca Weiss wrote:
> There's not much point in having unused labels in the binding example,
> so drop them.
> 
> This patch was originally motivated by ea25d61b448a ("arm64: dts: qcom:
> Use plural _gpios node label for PMIC gpios") updating all dts files to
> use the plural _gpios label instead of the singular _gpio as label but
> this example wasn't updated. But since we should just drop the label
> alltogether, do that.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: mfd: qcom,spmi-pmic: Drop unused labels from examples
      commit: cac94656ff2b16827d7cd455f0d3746280cf3138

--
Lee Jones [李琼斯]

