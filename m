Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BA8099D4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573188AbjLHCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573066AbjLHCxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712011BE2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:53:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205CFC433CC;
        Fri,  8 Dec 2023 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702004017;
        bh=pYFZ54dCpPeECJaD3wMxCgf0DmpliLHsDQObtMICiuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QkVPEoYJhbfrfcA9fITBTLMBtrrtP7cbHRsvv75zVxLUvwgrIRO5Ofnx34lCv45B9
         xBRiDisOWD6ZBS6Bfi963U03EmC3CPjS01Nfa0ub11snBoTiMN96u7MhVd4hLgCitN
         WPzDyifm9Ex9SBCVhgnKP5Kf/t/qJE2A8G78om3+lBNUqTl44W8Gr3ky7ltBba1V3h
         uoF4d7w2hG9Ro6hqj3e1K/hfeFx1AhieQdCz4fNptgUNLwdLzlqrvsJJij+ryVX8fn
         M+fUVsP6MIdIsTUNtPp59C2JxXll4syL4zH9TFYbvTxsdRdkQcJpIfdEPOJcxHNpYN
         Zz5nehN34Kw+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Luka Panio <lukapanio@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v11 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
Date:   Thu,  7 Dec 2023 18:57:41 -0800
Message-ID: <170200426937.2871025.11513762361673782003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125220315.118922-1-lukapanio@gmail.com>
References: <20231125220315.118922-1-lukapanio@gmail.com>
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


On Sat, 25 Nov 2023 23:03:14 +0100, Luka Panio wrote:
> Add a compatible for Xiaomi Pad 6.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
      commit: 25bb226508a1384723b201da8bd5c16ac57f34cd
[2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial device tree
      commit: 264beb3cbd0dc6d78357aa382297d5c94ffb4a3e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
