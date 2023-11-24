Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1179B7F7544
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjKXNdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjKXNdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:33:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD5D1708
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:33:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FE4C433CD;
        Fri, 24 Nov 2023 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832800;
        bh=a5c+eNFRWI1rPiXFiX1qkJlP9FBi0Vr2npPbeXqFnqY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=GDT+ydXhwi0T3I5Av3tY7zmJAAkmRvHxo1YU5PuP0py4GdE/pCxNRuN0upFrKQhUF
         iAm109qGDKI4j9rZPYSpppJsREnI2lcD3t3BLHFCPDd1VuXSlEcqWsVVzUTeSOpydt
         wIMDPeoEW8a61FiooIAyh7mHsKgc1MNneUn5oEckEwGTnTWSOVZToln2FsXBtRphxF
         rlTcbFHir6mbDSJU03mIl4TOPVqZum0A5B9G6vBJWgCuJLsYUpt3aKfTYpK9Tsy5O2
         o58Ocp6ulabpGEA28Dfnnm4L1cQVB/CNIyP9cby+KQZASUWyrzZribujI6SCC2U0bg
         v6bcoSjXkn/kg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org>
References: <20231025-topic-sm8650-upstream-bindings-gpi-v2-1-4de85293d730@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: dma: qcom,gpi: document the SM8650 GPI
 DMA Engine
Message-Id: <170083279691.771517.11496206562841467676.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:03:16 +0530
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


On Wed, 25 Oct 2023 10:23:04 +0200, Neil Armstrong wrote:
> Document the GPI DMA Engine on the SM8650 Platform.
> 
> 

Applied, thanks!

[1/1] dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA Engine
      commit: 375ff42c4c9825c19a53b9095ae4b3337cc83442

Best regards,
-- 
~Vinod


