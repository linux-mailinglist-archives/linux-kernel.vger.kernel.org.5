Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D076597E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjG0REx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjG0REu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B53F7;
        Thu, 27 Jul 2023 10:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7503D61EEA;
        Thu, 27 Jul 2023 17:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA6DC433C8;
        Thu, 27 Jul 2023 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690477483;
        bh=wx7pEgEpcjzZV0HZM5v6UOhxEOweIToIwi8mVUCF90M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np9UNJesVhDbFHPKhi7euJlnSDVbsgrUwU5yNRCuDTUkbzA7DARtyoagVtM0GGQ91
         sXbg/IZhsa/j19NwFztvfus+uN/7TgkMs1iECO86Envs3SZcmcuFIwfgRQLSl3kUFC
         rirUvGDxwlbsT3lebfnUrf3Fvy4r6bsFeRwhj2kFGZnHrSq6G/fVlxZH/061mJGsM3
         eZNRf5F9zQ04Yt22HfKbJ1HjobBPoKWypyr+Q8Vx5NmaJt8ZpdzPd5BGlqgVXOTSdk
         DlB4VCnKAJ7G/5SV2W6+qgYYoi9i+KRYPX6tY/zTDHIhlMyBaoqsyZCSVTjmK4rsSE
         8JsrOpp1yU5Rw==
Received: (nullmailer pid 1814150 invoked by uid 1000);
        Thu, 27 Jul 2023 17:04:42 -0000
Date:   Thu, 27 Jul 2023 11:04:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: arm: cpus: Add Cortex A520, A720, and X4
Message-ID: <169047748130.1814093.15874479054846290050.robh@kernel.org>
References: <20230706205334.306483-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706205334.306483-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Jul 2023 14:53:34 -0600, Rob Herring wrote:
> Add compatible strings for the Arm Cortex-A520, Cortex-A720, and
> Cortex-X4 2023 CPUs.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Also add Cortex-X4
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!

