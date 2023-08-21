Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC79A78346E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjHUU6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjHUU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:58:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9FFBC;
        Mon, 21 Aug 2023 13:58:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C31260BA1;
        Mon, 21 Aug 2023 20:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB17C433C7;
        Mon, 21 Aug 2023 20:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692651513;
        bh=E5e9oQ4r7IOuMNrE+VP4h3263NYNYefbxPjf4m73jXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zs9GOt5s+WO796XKC96PZ0b6uaUyn4EzPPwXV7rsT3tdjcyuZs5KTznPdBPkg2Gwt
         D6gQ0VWWVli+hjBfSSOOsuBa0BFu54Kf6XtqAST9k4qtU+WwizDzRg3WcN7QaWWlko
         +d7r2e5+wkqwiiMo52zzVTtog9Rs7pCzIl8QwxbauTjBWKfqTH3p1thAccsssaE+Fd
         zPTYhbPwYwr6w+qO7GUn41OVcpw5tjtCG8GxvKgjZOMQzejREz8JRGvNg9CXmCbU3a
         KDDMc2TNY44isDvaeEoXmCnkiv9BR5K56lgoeboVw7t/s1GEZbGZeLNIs8dcDGb8+w
         1B0/aIct7t8IQ==
Received: (nullmailer pid 2281356 invoked by uid 1000);
        Mon, 21 Aug 2023 20:58:31 -0000
Date:   Mon, 21 Aug 2023 15:58:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH] dt-bindings: display: msm/dp: restrict opp-table to
 objects
Message-ID: <169265150949.2281277.7308307921965060658.robh@kernel.org>
References: <20230820080543.25204-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820080543.25204-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 20 Aug 2023 10:05:43 +0200, Krzysztof Kozlowski wrote:
> Simple 'opp-table:true' accepts a boolean property as opp-table, so
> restrict it to object to properly enforce real OPP table nodes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks!

