Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8A80CEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjLKPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjLKPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:04:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD2E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37496C433C8;
        Mon, 11 Dec 2023 15:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307066;
        bh=KJD+xYzc6CAoRixh1BSpxyBDmJjGrrIXDFFv6pBnCcE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=K+oV1h6F1sMyVxX2kiAGh+v/5Ueibnk86Lcvc1uHhRlw48GQCvp8CpYxGu6iWYWKt
         G52BDl3WcfSeHGxC9Fzi0jFONRaxQHjWg+4KtWLwoZkN02rLWSQMGvxiwWgby4GCep
         l4ufZqjiNzxGQyfalytZ1M095enQyJPkJSQSYQ5NC9duS0U/q42q24cd5omoH6Zxfl
         QOQjmiipeIsX7RX0KeiytIs/rUk5BkYwGBWJHmfrFZLd5I7wlWIpiwkk00OSTEtdWW
         Pe2HRuPLf2t9BR9OeTmLL6yPTLERhALRJvKQVe1yUgLczjHxUXCHzRgNPRayyGuDgU
         bSbFGVxSf85gg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231122235050.2966280-1-robh@kernel.org>
References: <20231122235050.2966280-1-robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: dma: Drop undocumented examples
Message-Id: <170230706382.319997.13782235714250384432.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:34:23 +0530
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


On Wed, 22 Nov 2023 16:50:50 -0700, Rob Herring wrote:
> The compatibles "ti,omap-sdma" and "ti,dra7-dma-crossbar" aren't documented
> by a schema which causes warnings:
> 
> Documentation/devicetree/bindings/dma/dma-controller.example.dtb: /example-0/dma-controller@48000000: failed to match any schema with compatible: ['ti,omap-sdma']
> Documentation/devicetree/bindings/dma/dma-router.example.dtb: /example-0/dma-router@4a002b78: failed to match any schema with compatible: ['ti,dra7-dma-crossbar']
> 
> As no one has cared to fix them, just drop them.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: dma: Drop undocumented examples
      commit: 4a8ececbb50f0dd9395ffc4188ae780916df4a9c

Best regards,
-- 
~Vinod


