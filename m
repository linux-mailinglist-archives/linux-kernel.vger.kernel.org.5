Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A3F75B277
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjGTPYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGTPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C22733;
        Thu, 20 Jul 2023 08:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D62261B50;
        Thu, 20 Jul 2023 15:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D0C433C8;
        Thu, 20 Jul 2023 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866665;
        bh=4qHILuv6ipDyY0XKctnBYIH/GNE7VqG1uAq+Pe1kDX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVSrrQTiExkjw9pCikfC6vu5Vor5ZApsycq3OrfmXCD+DUAcfYiedj9L42C/w5Tny
         9VaGVgrtZq675Nh+f5jd4RMXqy15SK7NdAbDvh141E2iDHtBRPtLhOaruAMp/NRwWx
         r3ivMdQm3i7cuX/o1pBBO4rbKSN1PPX2k3HjcKsJ1wMjMlo/sObg3J12txvLmnXLWT
         05fRFM+Aokw2qnQupkBtr6cyMrofDPGv4T77qZ3OMeXP9biFFAGgJaVQTFI+QVCLaD
         ayL0PWhoFyGZ5F8eft+mFKpAsfI/Er1p94jrtJ1I0iHUSW9VInQ9LTmDPgA4WZHTxi
         AThtFmKqxshcQ==
Date:   Thu, 20 Jul 2023 20:54:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8180x-pmics: align SPMI PMIC
 Power-on node name with dtschema
Message-ID: <ZLlRpcrMSRs2DoFj@matsya>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
 <20230720083500.73554-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720083500.73554-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-23, 10:34, Krzysztof Kozlowski wrote:
> Bindings expect the Power-on node name to be "pon":
> 
>   sc8180x-lenovo-flex-5g.dtb: pmic@0: 'power-on@800' does not match any of the regexes:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
