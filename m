Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA480CF00
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343973AbjLKPEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjLKPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:04:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87061E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A26C433CB;
        Mon, 11 Dec 2023 15:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307070;
        bh=oEHEZ/BZD3hXy5YrgjxCeoF/SHNeUm8EOWEDSzWiTPw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CzHE3pyszj6WWL+ZhVIdIgiSQij6QaNCh3+YllWQ2kPXJSo8xUW1cNXgsIT1P+8el
         0FwDa6R+b60xYAnMCGtYzcYOK6GWtwMjRA7hcsqXlM08EO8cXMu+SHVPB7pYk/n0Td
         W2Vzuui6baPjBs9uGVYV+afhld7R/j8W8MTLcQ9CUvva9CrWp1kLJ3tfcx15FPeIOc
         hi6+2/7rmZw+xq0y8GK2gVxyJx5gbL1gC8wNEpSG/MVLNq/AnNkQnmXgK/0jlGkgDU
         otBkLixKURTxZNcC7YNmsZgNTATKvgX3/1CW8dyXS0Gu0CDyMnGDrZ/MD6cqJwxko0
         xlpuTEnN/B9ng==
From:   Vinod Koul <vkoul@kernel.org>
To:     green.wan@sifive.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor+dt@kernel.org,
        shravan chippa <shravan.chippa@microchip.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh.relli@microchip.com, praveen.kumar@microchip.com
In-Reply-To: <20231208103856.3732998-1-shravan.chippa@microchip.com>
References: <20231208103856.3732998-1-shravan.chippa@microchip.com>
Subject: Re: (subset) [PATCH v5 0/4] dma: sf-pdma: various sf-pdma updates
 for the mpfs platform
Message-Id: <170230706622.319997.1279433550352049584.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:34:26 +0530
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


On Fri, 08 Dec 2023 16:08:52 +0530, shravan chippa wrote:
> Changes from V4 -> V5:
> 
> Modified commit msg
> Replaced the sf_pdma_of_xlate() function with
> of_dma_xlate_by_chan_id()
> 
> Changes from V3 -> V4:
> 
> [...]

Applied, thanks!

[1/4] dmaengine: sf-pdma: Support of_dma_controller_register()
      commit: 8e578b47e6d92d5e43982ddc54045973dd4a7de5
[2/4] dt-bindings: dma: sf-pdma: add new compatible name
      commit: 72b22006ba78c2e3bf39b486a7b8155dc9020133
[3/4] dmaengine: sf-pdma: add mpfs-pdma compatible name
      commit: 58eea79a1cf285a62af886851b1a91ed5aceb401

Best regards,
-- 
~Vinod


