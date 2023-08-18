Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE0780A64
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359850AbjHRKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376380AbjHRKnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:43:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6F849C6;
        Fri, 18 Aug 2023 03:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D807676C1;
        Fri, 18 Aug 2023 10:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF3C433C7;
        Fri, 18 Aug 2023 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692354899;
        bh=5gYnBS8TenuhKeOT2Up5sY1thHDey3X5OUrwVSR/vKo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XC+DmqGY9ePxMX4QdkY9ykzdkVy3H2eSqZKzdC/rb3zjAvpAA5qB8lNi3oAIQUpk9
         jQ6hwyP9K6ZvUMYmYwnyZp4OGHkhLs+RlaFVvlluohm181Rtll4JJ8uVHQLSneHb7L
         osBlQhswRBxJgAqaiGx1EEL2hzFuNRDQJ9A4dLcsWJx3xI9BovJun8xfuyRfayFhSr
         CSypkv4UHsBmHRxxM2xPdFg2860dQSl/Tu+6++kGK4xoswi8wQxXS3tF7eAJDs4SFb
         YjvLPDJqW43iH/8nAqqT6ox8W67txKP2lFywntBh215YWV/AoiV+iz5N3m+8gIk3qG
         8Mym/Fu95+XVQ==
Message-ID: <82252735-f75f-8f09-0088-46f216ff1720@kernel.org>
Date:   Fri, 18 Aug 2023 12:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SC7280
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, agross@kernel.org,
        kishon@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
 <20230816154841.2183-2-quic_nitirawa@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230816154841.2183-2-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 17:48, Nitin Rawat wrote:
> Document the QMP UFS PHY compatible for SC7280.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

