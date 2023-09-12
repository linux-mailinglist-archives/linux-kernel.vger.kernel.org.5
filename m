Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFCB79D399
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjILO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjILO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C09115;
        Tue, 12 Sep 2023 07:29:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E40C433C8;
        Tue, 12 Sep 2023 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694528957;
        bh=51edGkZ7783Z2mPfwBbVsUX+4b8Z6WBJFR6Cg5U+Xxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GK9lxXw/TAmm75A28OnnkW7VWKbpRnzn2B76mkVGvKGMXNMDlfIX/DaY4oqqpqb6j
         H0/h84rL2u9gApx0u8WIfgnpIoVeHtagWO1zGs4+nzdCsnwnlg0jf0OD/NuK+mjXVG
         Y7cJ9D/JzIkvgjn3tyUBlbqMJf491VO7JapS44BHl2LJwzsvwb4lHP7ChT2kCIAMxu
         2OMBlzzIUIin3MaZqLnRoZ/s1bhBYXc5jJ8dsYpwnbh5y8BGSk400XMFy1wnNj3tBI
         E3nA9a7KZYYchzvg1W269CK6yYaFl4yDfNx1hVYgMdlw1OFbOKjMC+RaGPMVePUAo2
         YAhQdiU8oIhMQ==
Received: (nullmailer pid 751949 invoked by uid 1000);
        Tue, 12 Sep 2023 14:29:15 -0000
Date:   Tue, 12 Sep 2023 09:29:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Olivia Mackall <olivia@selenic.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: rng: introduce new compatible for
 STM32MP13x
Message-ID: <169452894267.751273.3176397821021102917.robh@kernel.org>
References: <20230911120203.774632-1-gatien.chevallier@foss.st.com>
 <20230911120203.774632-2-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911120203.774632-2-gatien.chevallier@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 14:01:54 +0200, Gatien Chevallier wrote:
> Introduce st,stm32mp13-rng compatible.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/rng/st,stm32-rng.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

