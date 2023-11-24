Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B0C7F7541
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjKXNdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjKXNdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:33:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1C1BD1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:33:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDB3C433B6;
        Fri, 24 Nov 2023 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832790;
        bh=w2vrWaY2W1yyeyUd3D1xtc1/2feKd+9XpwZav22IVlU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=IJbGuOTVoZzGgHzL2n3+pqidFq9URhPJ/Z74tDEhQME9qO96fE/lBLvaBvhHHYVow
         j62I0B+icdOVufbwe1Uq0HgF7mNs0crKjyHQo3b6hEiNq7Y15//Zxsq0JqKmN2psuY
         bi2shCNMbeiz0iFAwJ8fv/y1kiqwUEyxfYwuHsSRW8XTkHhjB4E25dldS4k852x6aw
         7Y180+UXqyyh5nnfyxo27sZhmyPgqLz1U79qr1bnNSgA9TxZmj23djEl9nacAPD59Z
         U1pluRi6tCjo0Jji7PvaD7Qq3SN1GQCwKuVHvuY4q/8okDH7Yq6SGdL5WohSbs5TeY
         S/fimnwjjLo/A==
From:   Vinod Koul <vkoul@kernel.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     agross@kernel.org, quic_gurus@quicinc.com,
        quic_rjendra@quicinc.com, abel.vesa@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        iommu@lists.linux.dev, quic_tsoni@quicinc.com,
        neil.armstrong@linaro.org
In-Reply-To: <20231124100608.29964-1-quic_sibis@quicinc.com>
References: <20231124100608.29964-1-quic_sibis@quicinc.com>
Subject: Re: (subset) [PATCH V3 0/5] dt-bindings: Document gpi/pdc/scm/smmu
 for X1E80100
Message-Id: <170083278459.771517.8795954738266891145.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:03:04 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Applied, thanks!

[3/5] dt-bindings: dma: qcom: gpi: add compatible for X1E80100
      commit: 66fb6eb6fab63ee80fd26cd5bdd9164aead0d207

Best regards,
-- 
~Vinod


