Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7380CF04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343977AbjLKPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbjLKPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEADD1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C608DC433C9;
        Mon, 11 Dec 2023 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307073;
        bh=e6CXrMobZvPrjdB6OvAR3xnF7KHYIQZ/dEC/uDNZ1bM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=F22xU4oEYxG9GvfWb/KYdQEu9zL+aWcYtzSFP6Xv4l0GCVu0RApN2VSCYZwMF/mgX
         CrnZPkFZgZtjdLiZc3jhvUffq03e282SGutNa8ipxbY64rmhpvT7ZYlnUvNULZWQXU
         FadEwMg4CiKr7Ksy7EtaEnLdSJWgQf5aWgVhJqfQKaZjPEPaM9BrjdWTr7R+mWPIwB
         hCWQLDFrr02bwgHD3xGzPDX+49UGrBsjAr1Ok+jAr4bp11b0YqLxlJnPqSMndF7LbR
         OERgEgGwPrfUX4+bgtOl+V7U2ZY0m/lExGe9lfKMLe0ar+Fs+oduOoWPtYU+JcLKUD
         Z5qQ1iyJz6gNw==
From:   Vinod Koul <vkoul@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Mohan Kumar <mkumard@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231128071615.31447-1-mkumard@nvidia.com>
References: <20231128071615.31447-1-mkumard@nvidia.com>
Subject: Re: [RESEND PATCH V2 0/2] Support dma channel mask
Message-Id: <170230707042.319997.2049992718193941560.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:34:30 +0530
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


On Tue, 28 Nov 2023 12:46:13 +0530, Mohan Kumar wrote:
> To reserve the dma channel using dma-channel-mask property for Tegra
> platforms.
> 
> Mohan Kumar (2):
>   dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>   dmaengine: tegra210-adma: Support dma-channel-mask property
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
      commit: d95fcb78e7f263f909ce492c3882a704067dc534
[2/2] dmaengine: tegra210-adma: Support dma-channel-mask property
      commit: 25b636225a0816eac20b02fcb37daf6c722d0bed

Best regards,
-- 
~Vinod


