Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD180F46B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjLLRVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376521AbjLLRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:21:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC132E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:21:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508E4C433CA;
        Tue, 12 Dec 2023 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702401702;
        bh=95qSBRedvB7M5d2E+Y4LFzyqtZbthes0VM007xjmBkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcX0iT+qutSFfhVVjuIVyyQEdkJMjTWaFHICz3BBoVAVwA7iLsdGtQAqkd7XI81GA
         OEfKpgO+vyAgYGbPLiHRkYvBcT4fsqxFnfE6vsYu3CrlrjOpWrWEPDgDQwK6/GTIcj
         /QvphctdOmQxXLsMsEg62nz1LuFsR6JMFJn4v8quG69prOXRgq6QhqCHHRJXftterQ
         HWgLiftxaGOcM02qoYdsoOMlyW1EMVN5LG1m/kK9+7PA1oZTIWpMAIbSRupnDa9OlL
         U4gRvhwS2urEu+EAjFeO+pcermczBiylwKXahYKwOsuldk3E05Mgr7DNR4o14Bc6ij
         3xQ3vEq81oc7w==
From:   Will Deacon <will@kernel.org>
To:     andersson@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        robin.murphy@arm.com, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, joro@8bytes.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        quic_tsoni@quicinc.com, quic_rjendra@quicinc.com,
        neil.armstrong@linaro.org, devicetree@vger.kernel.org,
        abel.vesa@linaro.org, quic_gurus@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, agross@kernel.org, vkoul@kernel.org
Subject: Re: [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu for X1E80100
Date:   Tue, 12 Dec 2023 17:20:59 +0000
Message-Id: <170238310080.3094703.7257298864480960361.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
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

On Fri, 24 Nov 2023 15:36:03 +0530, Sibi Sankar wrote:
> This series documents gpi/pdc/scm/smmu/soc for the Qualcomm X1E80100
> platform, aka Snapdragon X Elite.
> 
> Our v1 post of the patchsets adding support for Snapdragon X Elite SoC had
> the part number sc8380xp which is now updated to the new part number x1e80100
> based on the new branding scheme and refers to the exact same SoC.
> 
> [...]

Applied SMMU binding change to will (for-joerg/arm-smmu/bindings), thanks!

[2/5] dt-bindings: arm-smmu: Add compatible for X1E80100 SoC
      https://git.kernel.org/will/c/fa27b35c9102

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
