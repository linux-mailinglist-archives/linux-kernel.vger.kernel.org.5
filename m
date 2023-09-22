Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BE97ABA90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjIVUeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIVUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:34:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F221B2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:34:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72898C433C7;
        Fri, 22 Sep 2023 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695414844;
        bh=fh2nzdkaUADt+b/Vyqr/huEqEK6lXWqUFIL1/jW11c0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DH5lhYXNzlO+ew3BUXFcOyJVuqVlPYo3WqNuWFm/OHXzIDzy18hNBGYFi53/vn15p
         EQEdNv/92IRzaq6rcTmmpMlX9lnfyDQQbvla9PXqrOcISvvOwYuNjH6E7VFj3uAqNM
         s4ncS6i0SB3vS2RIAia7aFy9kfiLkpmlKpfmRFlVQjB2mG0/nvFHlcVGd1kkInVrS0
         DmlRMqsXq17SIS3ZsR1CAtfO7wk5+9XbLmbwxkK7tCKnetrEqjzJ0Zqzp4tcUOsL2v
         23DRjr7NCyLi1z8NlHNnD96ulbiEZgRB5hC1vsOA2EHwMdzkER3j1XUYdEc76pNAZC
         IWehZMuivn4Uw==
Received: (nullmailer pid 3535433 invoked by uid 1000);
        Fri, 22 Sep 2023 20:34:02 -0000
Date:   Fri, 22 Sep 2023 15:34:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add missing
 additionalProperties on interrupt-controller node
Message-ID: <169541483923.3535328.3111610827495188975.robh@kernel.org>
References: <20230915201946.4184468-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915201946.4184468-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 15 Sep 2023 15:19:36 -0500, Rob Herring wrote:
> The "interrupt-controller" CPU child node is missing constraints on
> extra properties. Add "additionalProperties: false" to fix this.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

