Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174A76EFA0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbjHCQfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjHCQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:35:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1475B10EA;
        Thu,  3 Aug 2023 09:35:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A91561E3A;
        Thu,  3 Aug 2023 16:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E0DC433CA;
        Thu,  3 Aug 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691080512;
        bh=B7iMMPhtI8zGB+saRPAwn0dPeNYjgb1E2JNBLxARHU0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NvtJ/8+LSXFQMmOGrNMVGde6/ZchShwDGt9aGxIqlQBDiYeQN/Z1gBASahASnJOVh
         f2CSZb+5NlOSqg4tLBIHe946HRXFJBXk9Y9B9n3XNnqQiX2nejA3ZgkpZOG/PZRv8P
         s5OvHP0LkTNvLoVt/qOZ18+FsrnE7OtbiB30dG1UCHyAsy8jfV7KIp7o9jQjaTEhXp
         6aFW6bOardGeUPy+5tUlfpZW3yo2Q2ktiikvF6gzwiizIHGW97IEHzEoZsyDul9vFR
         pBgmttezql9NMCfjPoITdugd5boXjNi2i0Wdv1DXEHGAzBrX0R4LH+nv3Vg4nByhFq
         tY4Phyg+HxqPQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: msm8953-tissot: use 0 as speaker DAI cells
Date:   Thu,  3 Aug 2023 09:38:02 -0700
Message-ID: <169108064638.108343.4289147714035180439.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730201913.70667-1-krzysztof.kozlowski@linaro.org>
References: <20230730201913.70667-1-krzysztof.kozlowski@linaro.org>
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


On Sun, 30 Jul 2023 22:19:12 +0200, Krzysztof Kozlowski wrote:
> MAX98927 speaker amplifier has only one DAI, so DAI cells can be just 0
> (as expected by bindings).
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: msm8953-tissot: use 0 as speaker DAI cells
      commit: 7c0755120f1f0495fe418d50f0618945136df9d1
[2/2] arm64: dts: qcom: sdm845-enchilada: use 0 as speaker DAI cells
      commit: 636f47cac06a881415b8126802c38cbe5b32b575

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
