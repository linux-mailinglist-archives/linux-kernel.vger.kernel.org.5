Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4D75DA11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 07:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGVFOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 01:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGVFOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 01:14:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C872F35B1;
        Fri, 21 Jul 2023 22:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F85860B00;
        Sat, 22 Jul 2023 05:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2540C433CD;
        Sat, 22 Jul 2023 05:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690002854;
        bh=F5QOKfd9rVycX15fb+aTu+pQ5DAKmS9iQSB6PwsGykg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TylFMm5c5HySmxZFmYPJ0lrEomxNUy6IR0TLv5fEssC6vsDJn/WZBTK2Y0ey2Dkla
         K9jQfx3kBh3ySZfvrBGu3gPQF9iRfNpRyFQxUGr262O0VYcGdfHTwGnYCZsJ84qsZm
         Km4kpuDDKaAbpanAosA7iFm3tgs8FbB+JpZKj9edxS1GIpMDk1atzvWR+fF9Y1fhF9
         CMH48PMLv/xnaAhULn/SspeWI42sUMFPrCBqfhOrR17j3S/aIlbS9O18hPB6qCmGOu
         xiERtUsBt+Hfm8uBuHHg0yrHF7yIA4f4RVFtwXEP2tzz4OPGnZ4jKcOWYjjA74ROnH
         aVO4Ii9m801Cw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: qcom: sm8350-hdk: include PMK8350
Date:   Fri, 21 Jul 2023 22:17:13 -0700
Message-ID: <169000304201.3611206.10707826316383236624.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
References: <20230719192809.434709-1-krzysztof.kozlowski@linaro.org>
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


On Wed, 19 Jul 2023 21:28:07 +0200, Krzysztof Kozlowski wrote:
> HDK8350 comes with PMK8350 PMIC, so include relevant DTSI.  This also
> allows to use reboot reason.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8350-hdk: include PMK8350
      commit: dd29cb5eddfd2d9fbe9a3924ff1519670633d1d0
[2/3] arm64: dts: qcom: sm8350-hdk: add uSD card
      commit: 423f3a7ec72db9f2be02c20e4661e69300ba0a21
[3/3] arm64: dts: qcom: sm8350: add APR and LPASS TLMM
      commit: 45a6bf1b272ee6b590233984408e0ba2093ac903

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
