Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C975B27C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjGTPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGTPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029EC2D61;
        Thu, 20 Jul 2023 08:24:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AFAA61B50;
        Thu, 20 Jul 2023 15:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DDFC4339A;
        Thu, 20 Jul 2023 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689866684;
        bh=Jliqfd5mnqCAkUIslPQiqH4TUKAm3tt8HYvvIhA2oj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmNP06gR7kr9Q+Cu89zKreWNtquXn/1vAVwmkHbkwS7A0O/2h0y467B0pvGC00gAL
         F/gGpHPRtYDSFhrJO7ZdXlFp69PYFLjS8YLGQm7OoWhvc5F9u8nMLARfkEujb4U7tS
         LoNrd/T/YEuQo7owbkml8I6zC3ZB8GlSlnNtYzcdVD+jG3I/bpeEM08yRKGeOmB1yv
         Nm0ZKSZjAom1SQt0DZVWvnA1r4KvxWBEY72G8CmVVVxQpF4t2GPsCv1Pq5CVXfbUGF
         U3eUY79ltfMjI6gK3hJy/tfOzIgjfnOjq4GAMlquBU7kwazw+VF5BnVwQl4t6I6H8q
         +bncgWCoeIoLg==
Date:   Thu, 20 Jul 2023 20:54:41 +0530
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
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8180x-pmics: align LPG node name
 with dtschema
Message-ID: <ZLlRubD5NiUEwZHe@matsya>
References: <20230720083500.73554-1-krzysztof.kozlowski@linaro.org>
 <20230720083500.73554-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720083500.73554-4-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-23, 10:35, Krzysztof Kozlowski wrote:
> Bindings expect the LPG node name to be "pwm":
> 
>   sc8180x-lenovo-flex-5g.dtb: pmic@5: 'lpg' does not match any of the regexes:

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
