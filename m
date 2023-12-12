Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767F880F464
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjLLRVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjLLRVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B4D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29598C433C7;
        Tue, 12 Dec 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401697;
        bh=sBE0NWnO5VIuoycB+dlcp2FMbiCfoxuzt1biDA8rV2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xs4mIMfPlfpcJpaVVlbOh3BzKo+oA57GZ5WRH+fpRwklV7Jr4/2qwR6yY78+GjCp6
         i+aqgILPqIatSrF8TDMvNF4H2Lagv8erEOfcJJsL1stt/sU/rNPuFqi8BWkxhHZ5WI
         XWjET2xuTc/raygkYaFxKTr7LCqLGAtFM9OnWHH8MD4A2cnlwodny6OhMc67RFaRc1
         QLFBMm+n4HCjMTDvsyYfsAiG40oNgdD8BxQNt1PI9Lpav4+XYz9NN2qDCKoim/EWrd
         dOcxSDtkSs/kbHkPC9ihtXluIKkjnnBWapRK8MkhJta3VM58tuFPiqFhJk7O3sFS0l
         qcgtVXFgvEorg==
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iommu: arm,smmu: document the SM8650 System MMU
Date:   Tue, 12 Dec 2023 17:20:58 +0000
Message-Id: <170238294290.3094261.9750012382616477796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
References: <20231128-topic-sm8650-upstream-bindings-smmu-v2-1-d3fbcaf1ea92@linaro.org>
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

On Tue, 28 Nov 2023 09:41:23 +0100, Neil Armstrong wrote:
> Document the System MMU on the SM8650 Platform.
> 
> 

Applied to will (for-joerg/arm-smmu/bindings), thanks!

[1/1] dt-bindings: iommu: arm,smmu: document the SM8650 System MMU
      https://git.kernel.org/will/c/61683b47df44

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
