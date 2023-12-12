Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849C80F461
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376471AbjLLRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjLLRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DDEE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19992C43397;
        Tue, 12 Dec 2023 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401691;
        bh=sSxIwv9uKyJ/rIqLLqJ7vYztgpbdcDuftbN+NtSi6mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sz7J+vz6px2kl/is1dj9InR8F/YBJ+KgTJGGmsdAI7LOZhZRF1Me2Ruxof2xfvEaH
         ArPuC4+niMfP0keucraLSyGDYm6GdKzinkmCC1kgrBR4BoMa/HnrQWhEniRc2DJLk0
         ZDqbUYFW2SbANM0J0zGyG6GPEsjFwdnJpUDmxb2YRBFaYFKXF9qfAEIacylu9lbpw5
         ramdUTUWcyiEm7T4+m0q2LnIBldGDfQunCmw51ETRL9MwZ7HFPDS0eQjI5c15ARlfI
         JqHx8QZxo+ReFnWREgmzMPyAb8NMvN/0p5CbHco9Lj5YnjxiJyIou8Oj1OyfhsrgJM
         TLiDA2UXhV88w==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
Date:   Tue, 12 Dec 2023 17:20:56 +0000
Message-Id: <170238274439.3091090.6038983968830615339.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
References: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 12 Nov 2023 19:45:22 +0100, Krzysztof Kozlowski wrote:
> Document the clocks for Qualcomm SM8350 Adreno GPU SMMU, already used in
> DTS:
> 
>   sm8350-hdk.dtb: iommu@3da0000: clock-names: False schema does not allow ['bus', 'iface', 'ahb', 'hlos1_vote_gpu_smmu', 'cx_gmu', 'hub_cx_int', 'hub_aon']
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
      https://git.kernel.org/will/c/54dae6d5d3f0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
